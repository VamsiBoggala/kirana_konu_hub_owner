import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

/// Storage Service
/// Handles all Firebase Storage operations for image uploads
class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload single image to Firebase Storage
  /// Returns the download URL if successful, null if failed
  ///
  /// [filePath] - Local file path of the image
  /// [storagePath] - Destination path in Firebase Storage
  /// [onProgress] - Optional callback for upload progress (0.0 to 1.0)
  Future<String?> uploadImage({
    required String filePath,
    required String storagePath,
    Function(double)? onProgress,
  }) async {
    try {
      final file = File(filePath);

      // Check if file exists
      if (!await file.exists()) {
        throw Exception('File not found: $filePath');
      }

      // Get file size for validation
      final fileSize = await file.length();
      const maxSize = 5 * 1024 * 1024; // 5MB limit

      if (fileSize > maxSize) {
        throw Exception('File size exceeds 5MB limit');
      }

      // Create reference to storage path
      final ref = _storage.ref().child(storagePath);

      // Upload file with metadata
      final uploadTask = ref.putFile(
        file,
        SettableMetadata(contentType: 'image/jpeg', customMetadata: {'uploadedAt': DateTime.now().toIso8601String()}),
      );

      // Listen to upload progress
      if (onProgress != null) {
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          final progress = snapshot.bytesTransferred / snapshot.totalBytes;
          onProgress(progress);
        });
      }

      // Wait for upload to complete
      final snapshot = await uploadTask;

      // Get download URL
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } on FirebaseException catch (e) {
      print('❌ Firebase Storage Error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('❌ Upload Error: $e');
      rethrow;
    }
  }

  /// Upload multiple images in sequence
  /// Returns a map of storage paths to download URLs
  /// Stops and returns partial results if any upload fails
  ///
  /// [uploads] - Map of storage paths to local file paths
  /// [onProgress] - Optional callback for overall progress
  Future<Map<String, String>> uploadMultipleImages({
    required Map<String, String> uploads,
    Function(int current, int total)? onProgress,
  }) async {
    final results = <String, String>{};
    int current = 0;
    final total = uploads.length;

    for (final entry in uploads.entries) {
      try {
        final url = await uploadImage(filePath: entry.value, storagePath: entry.key);

        if (url != null) {
          results[entry.key] = url;
          current++;
          onProgress?.call(current, total);
        } else {
          throw Exception('Upload failed for ${entry.key}');
        }
      } catch (e) {
        print('❌ Failed to upload ${entry.key}: $e');
        // Return partial results on error
        return results;
      }
    }

    return results;
  }

  /// Delete image from Firebase Storage
  /// Returns true if successful
  Future<bool> deleteImage(String storagePath) async {
    try {
      final ref = _storage.ref().child(storagePath);
      await ref.delete();
      return true;
    } on FirebaseException catch (e) {
      print('❌ Firebase Storage Delete Error: ${e.code} - ${e.message}');
      return false;
    } catch (e) {
      print('❌ Delete Error: $e');
      return false;
    }
  }

  /// Delete multiple images
  /// Returns count of successfully deleted images
  Future<int> deleteMultipleImages(List<String> storagePaths) async {
    int deletedCount = 0;

    for (final path in storagePaths) {
      final success = await deleteImage(path);
      if (success) {
        deletedCount++;
      }
    }

    return deletedCount;
  }

  /// Check if image exists at path
  Future<bool> imageExists(String storagePath) async {
    try {
      final ref = _storage.ref().child(storagePath);
      await ref.getDownloadURL();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get download URL for existing image
  Future<String?> getDownloadUrl(String storagePath) async {
    try {
      final ref = _storage.ref().child(storagePath);
      return await ref.getDownloadURL();
    } catch (e) {
      print('❌ Error getting download URL: $e');
      return null;
    }
  }
}
