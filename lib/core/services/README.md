# Core Services

This directory contains reusable services for Firebase operations.

## Services

### 1. `storage_service.dart`
Firebase Storage service for image/file uploads.

**Features:**
- Single image upload with progress tracking
- Batch image upload
- File size validation (5MB limit)
- Image deletion
- Download URL retrieval
- Error handling

**Usage:**
```dart
final storageService = StorageService();

// Upload single image
final url = await storageService.uploadImage(
  filePath: '/path/to/image.jpg',
  storagePath: 'hub_documents/userId/gst_certificate.jpg',
  onProgress: (progress) => print('Upload: ${(progress * 100).toInt()}%'),
);

// Upload multiple images
final uploads = {
  'path/in/storage1.jpg': '/local/path1.jpg',
  'path/in/storage2.jpg': '/local/path2.jpg',
};

final urls = await storageService.uploadMultipleImages(
  uploads: uploads,
  onProgress: (current, total) => print('$current/$total uploaded'),
);
```

### 2. `firestore_service.dart`
Firebase Firestore service for database operations.

**Features:**
- CRUD operations (Create, Read, Update, Delete)
- Document queries with filters
- Hub request submission
- Real-time streams
- Error handling

**Usage:**
```dart
final firestoreService = FirestoreService();

// Submit hub request
final success = await firestoreService.submitHubRequest(
  userId: 'user123',
  requestData: hubRequest.toFirestore(),
);

// Get document
final data = await firestoreService.getDocument(
  collection: 'hub_requests',
  documentId: 'user123',
);

// Query documents
final results = await firestoreService.queryDocuments(
  collection: 'hub_requests',
  whereField: 'status',
  whereValue: 'pending',
  orderByField: 'createdAt',
  descending: true,
);
```

---

## Error Handling

Both services throw exceptions that should be caught:

```dart
try {
  final url = await storageService.uploadImage(...);
} on FirebaseException catch (e) {
  print('Firebase error: ${e.code} - ${e.message}');
} catch (e) {
  print('General error: $e');
}
```

---

## Constants

Use constants from `lib/core/constants/firestore_collections.dart`:

```dart
import 'package:hub_owner/core/constants/firestore_collections.dart';

// Collection names
FirestoreCollections.hubRequests
FirestoreCollections.approvedHubs

// Storage paths
StoragePaths.gstCertificate(userId)
StoragePaths.panCard(userId)

// Status constants
RequestStatus.pending
RequestStatus.approved
```

---

## Best Practices

1. **Always handle errors** - Use try-catch blocks
2. **Validate before upload** - Check file exists and size
3. **Use constants** - Don't hardcode collection/path names
4. **Track progress** - Provide feedback to users
5. **Enable offline persistence** (optional):
   ```dart
   FirebaseFirestore.instance.settings = const Settings(
     persistenceEnabled: true,
   );
   ```

---

**See**: `~/.gemini/hub_request_submission_guide.md` for complete implementation guide
