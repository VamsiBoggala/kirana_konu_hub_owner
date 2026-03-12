import 'package:equatable/equatable.dart';

/// Registration Events
/// All events that can occur during the registration process
abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object?> get props => [];
}

/// Update Personal Details (Screen 1)
class UpdatePersonalDetailsEvent extends RegistrationEvent {
  final String ownerName;
  final String mobileNumber;
  final String shopName;

  const UpdatePersonalDetailsEvent({required this.ownerName, required this.mobileNumber, required this.shopName});

  @override
  List<Object?> get props => [ownerName, mobileNumber, shopName];
}

/// Update Location (Screen 1)
class UpdateLocationEvent extends RegistrationEvent {
  final double latitude;
  final double longitude;
  final String? address;

  const UpdateLocationEvent({required this.latitude, required this.longitude, this.address});

  @override
  List<Object?> get props => [latitude, longitude, address];
}

/// Detect Location (Screen 1)
class DetectLocationEvent extends RegistrationEvent {
  const DetectLocationEvent();
}

/// Update GSTIN Details (Screen 2)
class UpdateGSTINEvent extends RegistrationEvent {
  final String gstinNumber;
  final String? gstinDocUrl;

  const UpdateGSTINEvent({required this.gstinNumber, this.gstinDocUrl});

  @override
  List<Object?> get props => [gstinNumber, gstinDocUrl];
}

/// Update FSSAI Details (Screen 2)
class UpdateFSSAIEvent extends RegistrationEvent {
  final String fssaiNumber;
  final String? fssaiDocUrl;

  const UpdateFSSAIEvent({required this.fssaiNumber, this.fssaiDocUrl});

  @override
  List<Object?> get props => [fssaiNumber, fssaiDocUrl];
}

/// Update Bank Details (Screen 3)
class UpdateBankDetailsEvent extends RegistrationEvent {
  final String accountHolderName;
  final String accountNumber;
  final String ifscCode;
  final String? branchName;
  final String? cancelledChequeUrl;

  const UpdateBankDetailsEvent({
    required this.accountHolderName,
    required this.accountNumber,
    required this.ifscCode,
    this.branchName,
    this.cancelledChequeUrl,
  });

  @override
  List<Object?> get props => [accountHolderName, accountNumber, ifscCode, branchName, cancelledChequeUrl];
}

/// Accept Terms (Screen 4)
class AcceptTermsEvent extends RegistrationEvent {
  final bool accepted;

  const AcceptTermsEvent(this.accepted);

  @override
  List<Object?> get props => [accepted];
}

/// Toggle Terms Acceptance (Screen 4)
class ToggleTermsAcceptanceEvent extends RegistrationEvent {
  const ToggleTermsAcceptanceEvent();
}

/// Validate and Submit Registration (Screen 4)
class ValidateAndSubmitRegistrationEvent extends RegistrationEvent {
  const ValidateAndSubmitRegistrationEvent();
}

/// Submit Registration
class SubmitRegistrationEvent extends RegistrationEvent {
  const SubmitRegistrationEvent();
}

/// Upload Document
class UploadDocumentEvent extends RegistrationEvent {
  final String documentType; // 'gstin', 'fssai', 'pan', 'shop_license', 'cancelled_cheque'
  final String filePath;

  const UploadDocumentEvent({required this.documentType, required this.filePath});

  @override
  List<Object?> get props => [documentType, filePath];
}

/// Update GSTIN File (Screen 2)
class UpdateGSTINFileEvent extends RegistrationEvent {
  final String? filePath;

  const UpdateGSTINFileEvent({this.filePath});

  @override
  List<Object?> get props => [filePath];
}

/// Update FSSAI File (Screen 2)
class UpdateFSSAIFileEvent extends RegistrationEvent {
  final String? filePath;

  const UpdateFSSAIFileEvent({this.filePath});

  @override
  List<Object?> get props => [filePath];
}

/// Update PAN Card File (Screen 2)
class UpdatePANCardFileEvent extends RegistrationEvent {
  final String? filePath;

  const UpdatePANCardFileEvent({this.filePath});

  @override
  List<Object?> get props => [filePath];
}

/// Update Shop License File (Screen 2)
class UpdateShopLicenseFileEvent extends RegistrationEvent {
  final String? filePath;

  const UpdateShopLicenseFileEvent({this.filePath});

  @override
  List<Object?> get props => [filePath];
}

/// Update Shop Image File (Screen 2)
class UpdateShopImageFileEvent extends RegistrationEvent {
  final String? filePath;

  const UpdateShopImageFileEvent({this.filePath});

  @override
  List<Object?> get props => [filePath];
}

/// Validate Business Documents and Proceed (Screen 2)
class ValidateAndProceedToBankDetailsEvent extends RegistrationEvent {
  final String gstinNumber;
  final String fssaiNumber;
  final String? panNumber;
  final String? shopLicenseNumber;

  const ValidateAndProceedToBankDetailsEvent({
    required this.gstinNumber,
    required this.fssaiNumber,
    this.panNumber,
    this.shopLicenseNumber,
  });

  @override
  List<Object?> get props => [gstinNumber, fssaiNumber, panNumber, shopLicenseNumber];
}

/// Update Cancelled Cheque File (Screen 3)
class UpdateCancelledChequeFileEvent extends RegistrationEvent {
  final String? filePath;

  const UpdateCancelledChequeFileEvent({this.filePath});

  @override
  List<Object?> get props => [filePath];
}

/// Lookup IFSC Code (Screen 3)
class LookupIFSCEvent extends RegistrationEvent {
  final String ifscCode;

  const LookupIFSCEvent({required this.ifscCode});

  @override
  List<Object?> get props => [ifscCode];
}

/// Validate Bank Details and Proceed (Screen 3)
class ValidateAndProceedToTermsEvent extends RegistrationEvent {
  final String accountHolderName;
  final String accountNumber;
  final String ifscCode;
  final String? branchName;

  const ValidateAndProceedToTermsEvent({
    required this.accountHolderName,
    required this.accountNumber,
    required this.ifscCode,
    this.branchName,
  });

  @override
  List<Object?> get props => [accountHolderName, accountNumber, ifscCode, branchName];
}

/// Reset Registration
class ResetRegistrationEvent extends RegistrationEvent {
  const ResetRegistrationEvent();
}

/// Upload Images and Submit Registration
class UploadImagesAndSubmitEvent extends RegistrationEvent {
  final String userId;

  const UploadImagesAndSubmitEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

/// Retry Submission
class RetrySubmissionEvent extends RegistrationEvent {
  final String userId;

  const RetrySubmissionEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}
