import 'package:cloud_firestore/cloud_firestore.dart';

/// Hub Request Model
/// Represents a complete hub registration request
class HubRequestModel {
  // Identifiers
  final String userId;
  final String phoneNumber;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Personal Details (Step 1)
  final String ownerName;
  final String mobileNumber;
  final String shopName;
  final double latitude;
  final double longitude;
  final String? address;

  // Business Documents (Step 2)
  final String gstNumber;
  final String gstCertificateUrl;
  final String panNumber;
  final String panCardUrl;
  final String aadhaarNumber;
  final String aadhaarFrontUrl;
  final String aadhaarBackUrl;
  final String shopPhotoUrl;

  // Bank Details (Step 3)
  final String accountHolderName;
  final String accountNumber;
  final String ifscCode;
  final String bankName;
  final String branchName;
  final String cancelledChequeUrl;

  // Terms & Conditions (Step 4)
  final bool termsAccepted;
  final DateTime? termsAcceptedAt;

  // Optional fields for admin notes
  final String? rejectionReason;
  final String? adminNotes;

  const HubRequestModel({
    required this.userId,
    required this.phoneNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.ownerName,
    required this.mobileNumber,
    required this.shopName,
    required this.latitude,
    required this.longitude,
    this.address,
    required this.gstNumber,
    required this.gstCertificateUrl,
    required this.panNumber,
    required this.panCardUrl,
    required this.aadhaarNumber,
    required this.aadhaarFrontUrl,
    required this.aadhaarBackUrl,
    required this.shopPhotoUrl,
    required this.accountHolderName,
    required this.accountNumber,
    required this.ifscCode,
    required this.bankName,
    required this.branchName,
    required this.cancelledChequeUrl,
    required this.termsAccepted,
    this.termsAcceptedAt,
    this.rejectionReason,
    this.adminNotes,
  });

  /// Convert model to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'phoneNumber': phoneNumber,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),

      // Personal Details
      'ownerName': ownerName,
      'mobileNumber': mobileNumber,
      'shopName': shopName,
      'location': GeoPoint(latitude, longitude),
      'address': address,

      // Business Documents
      'gstNumber': gstNumber,
      'gstCertificateUrl': gstCertificateUrl,
      'panNumber': panNumber,
      'panCardUrl': panCardUrl,
      'aadhaarNumber': aadhaarNumber,
      'aadhaarFrontUrl': aadhaarFrontUrl,
      'aadhaarBackUrl': aadhaarBackUrl,
      'shopPhotoUrl': shopPhotoUrl,

      // Bank Details
      'accountHolderName': accountHolderName,
      'accountNumber': accountNumber,
      'ifscCode': ifscCode,
      'bankName': bankName,
      'branchName': branchName,
      'cancelledChequeUrl': cancelledChequeUrl,

      // Terms
      'termsAccepted': termsAccepted,
      'termsAcceptedAt': termsAcceptedAt != null ? Timestamp.fromDate(termsAcceptedAt!) : null,

      // Admin fields
      'rejectionReason': rejectionReason,
      'adminNotes': adminNotes,
    };
  }

  /// Create model from Firestore document
  factory HubRequestModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final location = data['location'] as GeoPoint;

    return HubRequestModel(
      userId: data['userId'] as String,
      phoneNumber: data['phoneNumber'] as String,
      status: data['status'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),

      // Personal Details
      ownerName: data['ownerName'] as String,
      mobileNumber: data['mobileNumber'] as String,
      shopName: data['shopName'] as String,
      latitude: location.latitude,
      longitude: location.longitude,
      address: data['address'] as String?,

      // Business Documents
      gstNumber: data['gstNumber'] as String,
      gstCertificateUrl: data['gstCertificateUrl'] as String,
      panNumber: data['panNumber'] as String,
      panCardUrl: data['panCardUrl'] as String,
      aadhaarNumber: data['aadhaarNumber'] as String,
      aadhaarFrontUrl: data['aadhaarFrontUrl'] as String,
      aadhaarBackUrl: data['aadhaarBackUrl'] as String,
      shopPhotoUrl: data['shopPhotoUrl'] as String,

      // Bank Details
      accountHolderName: data['accountHolderName'] as String,
      accountNumber: data['accountNumber'] as String,
      ifscCode: data['ifscCode'] as String,
      bankName: data['bankName'] as String,
      branchName: data['branchName'] as String,
      cancelledChequeUrl: data['cancelledChequeUrl'] as String,

      // Terms
      termsAccepted: data['termsAccepted'] as bool,
      termsAcceptedAt: data['termsAcceptedAt'] != null ? (data['termsAcceptedAt'] as Timestamp).toDate() : null,

      // Admin fields
      rejectionReason: data['rejectionReason'] as String?,
      adminNotes: data['adminNotes'] as String?,
    );
  }

  /// Create a copy with updated fields
  HubRequestModel copyWith({
    String? userId,
    String? phoneNumber,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? ownerName,
    String? mobileNumber,
    String? shopName,
    double? latitude,
    double? longitude,
    String? address,
    String? gstNumber,
    String? gstCertificateUrl,
    String? panNumber,
    String? panCardUrl,
    String? aadhaarNumber,
    String? aadhaarFrontUrl,
    String? aadhaarBackUrl,
    String? shopPhotoUrl,
    String? accountHolderName,
    String? accountNumber,
    String? ifscCode,
    String? bankName,
    String? branchName,
    String? cancelledChequeUrl,
    bool? termsAccepted,
    DateTime? termsAcceptedAt,
    String? rejectionReason,
    String? adminNotes,
  }) {
    return HubRequestModel(
      userId: userId ?? this.userId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      ownerName: ownerName ?? this.ownerName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      shopName: shopName ?? this.shopName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      gstNumber: gstNumber ?? this.gstNumber,
      gstCertificateUrl: gstCertificateUrl ?? this.gstCertificateUrl,
      panNumber: panNumber ?? this.panNumber,
      panCardUrl: panCardUrl ?? this.panCardUrl,
      aadhaarNumber: aadhaarNumber ?? this.aadhaarNumber,
      aadhaarFrontUrl: aadhaarFrontUrl ?? this.aadhaarFrontUrl,
      aadhaarBackUrl: aadhaarBackUrl ?? this.aadhaarBackUrl,
      shopPhotoUrl: shopPhotoUrl ?? this.shopPhotoUrl,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      accountNumber: accountNumber ?? this.accountNumber,
      ifscCode: ifscCode ?? this.ifscCode,
      bankName: bankName ?? this.bankName,
      branchName: branchName ?? this.branchName,
      cancelledChequeUrl: cancelledChequeUrl ?? this.cancelledChequeUrl,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      termsAcceptedAt: termsAcceptedAt ?? this.termsAcceptedAt,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      adminNotes: adminNotes ?? this.adminNotes,
    );
  }
}
