import 'package:equatable/equatable.dart';

/// Hub Registration Model
/// Contains all data collected during the KYB registration process
class HubRegistrationModel extends Equatable {
  // Personal Details
  final String ownerName;
  final String mobileNumber;
  final String shopName;

  // Location Details
  final double? latitude;
  final double? longitude;
  final String? address;

  // Business Documents
  final String gstinNumber;
  final String? gstinDocUrl;
  final String? gstinFilePath; // Local file path before upload

  final String fssaiNumber;
  final String? fssaiDocUrl;
  final String? fssaiFilePath; // Local file path before upload

  final String? panNumber;
  final String? panDocUrl;
  final String? panFilePath; // Local file path before upload

  final String? shopLicenseNumber;
  final String? shopLicenseDocUrl;
  final String? shopLicenseFilePath; // Local file path before upload

  final String? shopImageUrl;
  final String? shopImageFilePath; // Local file path before upload

  // Bank Details
  final String bankAccountHolderName;
  final String bankAccountNumber;
  final String ifscCode;
  final String? branchName;
  final String? cancelledChequeUrl;
  final String? cancelledChequeFilePath; // Local file path before upload

  // Terms & Status
  final bool termsAccepted;
  final String status; // pending_verification, approved, rejected
  final DateTime? submittedAt;
  final String? ownerUid;
  final String? tempId;

  const HubRegistrationModel({
    required this.ownerName,
    required this.mobileNumber,
    required this.shopName,
    this.latitude,
    this.longitude,
    this.address,
    required this.gstinNumber,
    this.gstinDocUrl,
    this.gstinFilePath,
    required this.fssaiNumber,
    this.fssaiDocUrl,
    this.fssaiFilePath,
    this.panNumber,
    this.panDocUrl,
    this.panFilePath,
    this.shopLicenseNumber,
    this.shopLicenseDocUrl,
    this.shopLicenseFilePath,
    this.shopImageUrl,
    this.shopImageFilePath,
    required this.bankAccountHolderName,
    required this.bankAccountNumber,
    required this.ifscCode,
    this.branchName,
    this.cancelledChequeUrl,
    this.cancelledChequeFilePath,
    this.termsAccepted = false,
    this.status = 'pending_verification',
    this.submittedAt,
    this.ownerUid,
    this.tempId,
  });

  /// Create empty model for initial state
  factory HubRegistrationModel.empty() {
    return const HubRegistrationModel(
      ownerName: '',
      mobileNumber: '',
      shopName: '',
      gstinNumber: '',
      fssaiNumber: '',
      bankAccountHolderName: '',
      bankAccountNumber: '',
      ifscCode: '',
    );
  }

  /// Copy with method for updating specific fields
  HubRegistrationModel copyWith({
    String? ownerName,
    String? mobileNumber,
    String? shopName,
    double? latitude,
    double? longitude,
    String? address,
    String? gstinNumber,
    String? gstinDocUrl,
    String? gstinFilePath,
    String? fssaiNumber,
    String? fssaiDocUrl,
    String? fssaiFilePath,
    String? panNumber,
    String? panDocUrl,
    String? panFilePath,
    String? shopLicenseNumber,
    String? shopLicenseDocUrl,
    String? shopLicenseFilePath,
    String? shopImageUrl,
    String? shopImageFilePath,
    String? bankAccountHolderName,
    String? bankAccountNumber,
    String? ifscCode,
    String? branchName,
    String? cancelledChequeUrl,
    String? cancelledChequeFilePath,
    bool? termsAccepted,
    String? status,
    DateTime? submittedAt,
    String? ownerUid,
    String? tempId,
  }) {
    return HubRegistrationModel(
      ownerName: ownerName ?? this.ownerName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      shopName: shopName ?? this.shopName,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      gstinNumber: gstinNumber ?? this.gstinNumber,
      gstinDocUrl: gstinDocUrl ?? this.gstinDocUrl,
      gstinFilePath: gstinFilePath ?? this.gstinFilePath,
      fssaiNumber: fssaiNumber ?? this.fssaiNumber,
      fssaiDocUrl: fssaiDocUrl ?? this.fssaiDocUrl,
      fssaiFilePath: fssaiFilePath ?? this.fssaiFilePath,
      panNumber: panNumber ?? this.panNumber,
      panDocUrl: panDocUrl ?? this.panDocUrl,
      panFilePath: panFilePath ?? this.panFilePath,
      shopLicenseNumber: shopLicenseNumber ?? this.shopLicenseNumber,
      shopLicenseDocUrl: shopLicenseDocUrl ?? this.shopLicenseDocUrl,
      shopLicenseFilePath: shopLicenseFilePath ?? this.shopLicenseFilePath,
      shopImageUrl: shopImageUrl ?? this.shopImageUrl,
      shopImageFilePath: shopImageFilePath ?? this.shopImageFilePath,
      bankAccountHolderName: bankAccountHolderName ?? this.bankAccountHolderName,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      ifscCode: ifscCode ?? this.ifscCode,
      branchName: branchName ?? this.branchName,
      cancelledChequeUrl: cancelledChequeUrl ?? this.cancelledChequeUrl,
      cancelledChequeFilePath: cancelledChequeFilePath ?? this.cancelledChequeFilePath,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      status: status ?? this.status,
      submittedAt: submittedAt ?? this.submittedAt,
      ownerUid: ownerUid ?? this.ownerUid,
      tempId: tempId ?? this.tempId,
    );
  }

  /// Convert to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'owner_name': ownerName,
      'mobile_number': mobileNumber,
      'shop_name': shopName,
      'location': {'latitude': latitude, 'longitude': longitude, 'address': address},
      'documents': {
        'gstin': {'number': gstinNumber, 'document_url': gstinDocUrl},
        'fssai': {'number': fssaiNumber, 'document_url': fssaiDocUrl},
        'pan': {'number': panNumber, 'document_url': panDocUrl},
        'shop_license': {'number': shopLicenseNumber, 'document_url': shopLicenseDocUrl},
        'shop_image': {'image_url': shopImageUrl},
      },
      'bank_details': {
        'account_holder_name': bankAccountHolderName,
        'account_number': bankAccountNumber,
        'ifsc_code': ifscCode,
        'branch_name': branchName,
        'cancelled_cheque_url': cancelledChequeUrl,
      },
      'terms_accepted': termsAccepted,
      'status': status,
      'submitted_at': submittedAt?.toIso8601String(),
      'owner_uid': ownerUid,
      'temp_id': tempId,
    };
  }

  /// Create from JSON (Firestore)
  factory HubRegistrationModel.fromJson(Map<String, dynamic> json) {
    return HubRegistrationModel(
      ownerName: json['owner_name'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      shopName: json['shop_name'] ?? '',
      latitude: json['location']?['latitude']?.toDouble(),
      longitude: json['location']?['longitude']?.toDouble(),
      address: json['location']?['address'],
      gstinNumber: json['documents']?['gstin']?['number'] ?? '',
      gstinDocUrl: json['documents']?['gstin']?['document_url'],
      fssaiNumber: json['documents']?['fssai']?['number'] ?? '',
      fssaiDocUrl: json['documents']?['fssai']?['document_url'],
      panNumber: json['documents']?['pan']?['number'],
      panDocUrl: json['documents']?['pan']?['document_url'],
      shopLicenseNumber: json['documents']?['shop_license']?['number'],
      shopLicenseDocUrl: json['documents']?['shop_license']?['document_url'],
      shopImageUrl: json['documents']?['shop_image']?['image_url'],
      bankAccountHolderName: json['bank_details']?['account_holder_name'] ?? '',
      bankAccountNumber: json['bank_details']?['account_number'] ?? '',
      ifscCode: json['bank_details']?['ifsc_code'] ?? '',
      branchName: json['bank_details']?['branch_name'],
      cancelledChequeUrl: json['bank_details']?['cancelled_cheque_url'],
      termsAccepted: json['terms_accepted'] ?? false,
      status: json['status'] ?? 'pending_verification',
      submittedAt: json['submitted_at'] != null ? DateTime.parse(json['submitted_at']) : null,
      ownerUid: json['owner_uid'],
      tempId: json['temp_id'],
    );
  }

  @override
  List<Object?> get props => [
    ownerName,
    mobileNumber,
    shopName,
    latitude,
    longitude,
    address,
    gstinNumber,
    gstinDocUrl,
    gstinFilePath,
    fssaiNumber,
    fssaiDocUrl,
    fssaiFilePath,
    panNumber,
    panDocUrl,
    panFilePath,
    shopLicenseNumber,
    shopLicenseDocUrl,
    shopLicenseFilePath,
    shopImageUrl,
    shopImageFilePath,
    bankAccountHolderName,
    bankAccountNumber,
    ifscCode,
    branchName,
    cancelledChequeUrl,
    cancelledChequeFilePath,
    termsAccepted,
    status,
    submittedAt,
    ownerUid,
    tempId,
  ];
}
