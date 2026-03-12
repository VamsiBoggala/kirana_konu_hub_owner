/// Firestore Collection Constants
/// Central location for all Firestore collection names
class FirestoreCollections {
  // Private constructor to prevent instantiation
  FirestoreCollections._();

  /// Hub Requests Collection
  /// Stores all hub owner registration requests
  /// Document ID: User's Firebase Auth UID
  static const String hubRequests = 'hub_requests';

  /// Approved Hubs Collection
  /// Stores approved hub details for active operations
  /// Document ID: User's Firebase Auth UID
  static const String approvedHubs = 'approved_hubs';

  /// Users Collection
  /// Stores user profile and preferences
  /// Document ID: User's Firebase Auth UID
  static const String users = 'users';

  /// Orders Collection
  /// Stores all orders placed through hubs
  /// Sub-collection under hubs
  static const String orders = 'orders';

  /// Products Collection
  /// Stores product catalog
  static const String products = 'products';

  /// Categories Collection
  /// Stores product categories
  static const String categories = 'categories';

  /// Notifications Collection
  /// Stores user notifications
  /// Sub-collection under users
  static const String notifications = 'notifications';

  /// Admin Collection
  /// Stores admin users and settings
  static const String admins = 'admins';
}

/// Firebase Storage Paths
/// Central location for all Firebase Storage folder paths
class StoragePaths {
  // Private constructor
  StoragePaths._();

  /// Base path for hub documents
  /// Path: hub_documents/{userId}/
  static const String hubDocuments = 'hub_documents';

  /// GST Certificate path
  /// Path: hub_documents/{userId}/gst_certificate.jpg
  static String gstCertificate(String userId) => '$hubDocuments/$userId/gst_certificate.jpg';

  /// PAN Card path
  /// Path: hub_documents/{userId}/pan_card.jpg
  static String panCard(String userId) => '$hubDocuments/$userId/pan_card.jpg';

  /// Aadhaar Front path
  /// Path: hub_documents/{userId}/aadhaar_front.jpg
  static String aadhaarFront(String userId) => '$hubDocuments/$userId/aadhaar_front.jpg';

  /// Aadhaar Back path
  /// Path: hub_documents/{userId}/aadhaar_back.jpg
  static String aadhaarBack(String userId) => '$hubDocuments/$userId/aadhaar_back.jpg';

  /// Shop Photo path
  /// Path: hub_documents/{userId}/shop_photo.jpg
  static String shopPhoto(String userId) => '$hubDocuments/$userId/shop_photo.jpg';

  /// Cancelled Cheque path
  /// Path: hub_documents/{userId}/cancelled_cheque.jpg
  static String cancelledCheque(String userId) => '$hubDocuments/$userId/cancelled_cheque.jpg';

  /// Product images base path
  /// Path: products/{productId}/
  static const String products = 'products';

  /// Hub profile images
  /// Path: hub_profiles/{userId}/profile.jpg
  static String hubProfile(String userId) => 'hub_profiles/$userId/profile.jpg';
}

/// Request Status Constants
class RequestStatus {
  RequestStatus._();

  /// Request is pending admin approval
  static const String pending = 'pending';

  /// Request has been approved
  static const String approved = 'approved';

  /// Request has been rejected
  static const String rejected = 'rejected';

  /// Request needs more information
  static const String needsInfo = 'needs_info';

  /// Request is under review
  static const String underReview = 'under_review';
}
