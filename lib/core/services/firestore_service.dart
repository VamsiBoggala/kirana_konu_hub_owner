import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/firestore_collections.dart';

/// Firestore Service
/// Handles all Firestore database operations
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Add or update document in a collection
  /// Returns true if successful
  ///
  /// [collection] - Collection name
  /// [documentId] - Document ID
  /// [data] - Data to save
  /// [merge] - If true, merges with existing data instead of overwriting
  Future<bool> setDocument({
    required String collection,
    required String documentId,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    try {
      await _firestore.collection(collection).doc(documentId).set(data, SetOptions(merge: merge));
      return true;
    } on FirebaseException catch (e) {
      print('❌ Firestore Set Error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('❌ Set Document Error: $e');
      rethrow;
    }
  }

  /// Get document from collection
  /// Returns document data or null if not found
  Future<Map<String, dynamic>?> getDocument({required String collection, required String documentId}) async {
    try {
      final doc = await _firestore.collection(collection).doc(documentId).get();

      if (doc.exists) {
        return doc.data();
      }
      return null;
    } on FirebaseException catch (e) {
      print('❌ Firestore Get Error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('❌ Get Document Error: $e');
      rethrow;
    }
  }

  /// Update specific fields in a document
  /// Returns true if successful
  Future<bool> updateDocument({
    required String collection,
    required String documentId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      await _firestore.collection(collection).doc(documentId).update(updates);
      return true;
    } on FirebaseException catch (e) {
      print('❌ Firestore Update Error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('❌ Update Document Error: $e');
      rethrow;
    }
  }

  /// Delete document from collection
  /// Returns true if successful
  Future<bool> deleteDocument({required String collection, required String documentId}) async {
    try {
      await _firestore.collection(collection).doc(documentId).delete();
      return true;
    } on FirebaseException catch (e) {
      print('❌ Firestore Delete Error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('❌ Delete Document Error: $e');
      rethrow;
    }
  }

  /// Check if document exists
  Future<bool> documentExists({required String collection, required String documentId}) async {
    try {
      final doc = await _firestore.collection(collection).doc(documentId).get();
      return doc.exists;
    } catch (e) {
      print('❌ Document Exists Check Error: $e');
      return false;
    }
  }

  /// Query documents with filters
  /// Returns list of documents matching the query
  Future<List<Map<String, dynamic>>> queryDocuments({
    required String collection,
    String? whereField,
    dynamic whereValue,
    String? orderByField,
    bool descending = false,
    int? limit,
  }) async {
    try {
      Query query = _firestore.collection(collection);

      // Add where clause if specified
      if (whereField != null && whereValue != null) {
        query = query.where(whereField, isEqualTo: whereValue);
      }

      // Add order by if specified
      if (orderByField != null) {
        query = query.orderBy(orderByField, descending: descending);
      }

      // Add limit if specified
      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } on FirebaseException catch (e) {
      print('❌ Firestore Query Error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('❌ Query Error: $e');
      rethrow;
    }
  }

  /// Submit hub request to Firestore
  /// This is a specific method for hub registration
  Future<bool> submitHubRequest({required String userId, required Map<String, dynamic> requestData}) async {
    try {
      // Add metadata
      final dataWithMetadata = {
        ...requestData,
        'userId': userId,
        'status': RequestStatus.pending,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await _firestore.collection(FirestoreCollections.hubRequests).doc(userId).set(dataWithMetadata);

      return true;
    } on FirebaseException catch (e) {
      print('❌ Submit Hub Request Error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e) {
      print('❌ Hub Request Error: $e');
      rethrow;
    }
  }

  /// Get hub request status
  Future<String?> getHubRequestStatus(String userId) async {
    try {
      final doc = await _firestore.collection(FirestoreCollections.hubRequests).doc(userId).get();

      if (doc.exists) {
        return doc.data()?['status'] as String?;
      }
      return null;
    } catch (e) {
      print('❌ Get Hub Request Status Error: $e');
      return null;
    }
  }

  /// Stream hub request for real-time updates
  Stream<DocumentSnapshot> streamHubRequest(String userId) {
    return _firestore.collection(FirestoreCollections.hubRequests).doc(userId).snapshots();
  }
}
