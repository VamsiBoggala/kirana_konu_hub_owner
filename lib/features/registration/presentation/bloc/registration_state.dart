import 'package:equatable/equatable.dart';
import '../../data/models/hub_registration_model.dart';

/// Registration States
/// All possible states during the registration process
abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object?> get props => [];
}

/// Initial State
class RegistrationInitial extends RegistrationState {
  final HubRegistrationModel registrationData;

  const RegistrationInitial({required this.registrationData});

  @override
  List<Object?> get props => [registrationData];
}

/// Loading State (for async operations)
class RegistrationLoading extends RegistrationState {
  final HubRegistrationModel registrationData;
  final String? message;

  const RegistrationLoading({required this.registrationData, this.message});

  @override
  List<Object?> get props => [registrationData, message];
}

/// Data Updated State
class RegistrationDataUpdated extends RegistrationState {
  final HubRegistrationModel registrationData;

  const RegistrationDataUpdated({required this.registrationData});

  @override
  List<Object?> get props => [registrationData];
}

/// Document Upload Progress
class DocumentUploadInProgress extends RegistrationState {
  final HubRegistrationModel registrationData;
  final String documentType;
  final double progress; // 0.0 to 1.0

  const DocumentUploadInProgress({required this.registrationData, required this.documentType, required this.progress});

  @override
  List<Object?> get props => [registrationData, documentType, progress];
}

/// Document Upload Success
class DocumentUploadSuccess extends RegistrationState {
  final HubRegistrationModel registrationData;
  final String documentType;
  final String documentUrl;

  const DocumentUploadSuccess({required this.registrationData, required this.documentType, required this.documentUrl});

  @override
  List<Object?> get props => [registrationData, documentType, documentUrl];
}

/// Document Upload Failed
class DocumentUploadFailed extends RegistrationState {
  final HubRegistrationModel registrationData;
  final String documentType;
  final String error;

  const DocumentUploadFailed({required this.registrationData, required this.documentType, required this.error});

  @override
  List<Object?> get props => [registrationData, documentType, error];
}

/// Location Updated
class LocationUpdated extends RegistrationState {
  final HubRegistrationModel registrationData;

  const LocationUpdated({required this.registrationData});

  @override
  List<Object?> get props => [registrationData];
}

/// Location Error
class LocationError extends RegistrationState {
  final HubRegistrationModel registrationData;
  final String error;

  const LocationError({required this.registrationData, required this.error});

  @override
  List<Object?> get props => [registrationData, error];
}

/// Location Detecting
class LocationDetecting extends RegistrationState {
  final HubRegistrationModel registrationData;

  const LocationDetecting({required this.registrationData});

  @override
  List<Object?> get props => [registrationData];
}

/// Location Permission Denied
class LocationPermissionDenied extends RegistrationState {
  final HubRegistrationModel registrationData;

  const LocationPermissionDenied({required this.registrationData});

  @override
  List<Object?> get props => [registrationData];
}

/// Location Permission Permanently Denied
class LocationPermissionPermanentlyDenied extends RegistrationState {
  final HubRegistrationModel registrationData;

  const LocationPermissionPermanentlyDenied({required this.registrationData});

  @override
  List<Object?> get props => [registrationData];
}

/// Registration Submitting
class RegistrationSubmitting extends RegistrationState {
  final HubRegistrationModel registrationData;

  const RegistrationSubmitting({required this.registrationData});

  @override
  List<Object?> get props => [registrationData];
}

/// Registration Success
class RegistrationSuccess extends RegistrationState {
  final HubRegistrationModel registrationData;
  final String applicationId;

  const RegistrationSuccess({required this.registrationData, required this.applicationId});

  @override
  List<Object?> get props => [registrationData, applicationId];
}

/// Registration Failed
class RegistrationFailed extends RegistrationState {
  final HubRegistrationModel registrationData;
  final String error;

  const RegistrationFailed({required this.registrationData, required this.error});

  @override
  List<Object?> get props => [registrationData, error];
}

/// Validation Error
class ValidationError extends RegistrationState {
  final HubRegistrationModel registrationData;
  final String error;

  const ValidationError({required this.registrationData, required this.error});

  @override
  List<Object?> get props => [registrationData, error];
}

/// Navigate to Next Screen
class NavigateToNextScreen extends RegistrationState {
  final HubRegistrationModel registrationData;
  final String routeName;

  const NavigateToNextScreen({required this.registrationData, required this.routeName});

  @override
  List<Object?> get props => [registrationData, routeName];
}

/// IFSC Lookup Success
class IFSCLookupSuccess extends RegistrationState {
  final HubRegistrationModel registrationData;
  final String branchName;

  const IFSCLookupSuccess({required this.registrationData, required this.branchName});

  @override
  List<Object?> get props => [registrationData, branchName];
}

/// Images Uploading State
class ImagesUploading extends RegistrationState {
  final HubRegistrationModel registrationData;
  final int current;
  final int total;
  final String currentFile;

  const ImagesUploading({
    required this.registrationData,
    required this.current,
    required this.total,
    required this.currentFile,
  });

  @override
  List<Object?> get props => [registrationData, current, total, currentFile];
}

/// Images Upload Success State
class ImagesUploadSuccess extends RegistrationState {
  final HubRegistrationModel registrationData;
  final Map<String, String> imageUrls;

  const ImagesUploadSuccess({required this.registrationData, required this.imageUrls});

  @override
  List<Object?> get props => [registrationData, imageUrls];
}

/// Images Upload Failed State
class ImagesUploadFailed extends RegistrationState {
  final HubRegistrationModel registrationData;
  final String error;
  final Map<String, String> partialUrls;

  const ImagesUploadFailed({required this.registrationData, required this.error, required this.partialUrls});

  @override
  List<Object?> get props => [registrationData, error, partialUrls];
}

/// Submitting Request State
class SubmittingRequest extends RegistrationState {
  final HubRegistrationModel registrationData;

  const SubmittingRequest({required this.registrationData});

  @override
  List<Object?> get props => [registrationData];
}

/// Submission Success State
class SubmissionSuccess extends RegistrationState {
  final HubRegistrationModel registrationData;
  final String requestId;

  const SubmissionSuccess({required this.registrationData, required this.requestId});

  @override
  List<Object?> get props => [registrationData, requestId];
}

/// Submission Failed State
class SubmissionFailed extends RegistrationState {
  final HubRegistrationModel registrationData;
  final String error;
  final bool canRetry;

  const SubmissionFailed({required this.registrationData, required this.error, this.canRetry = true});

  @override
  List<Object?> get props => [registrationData, error, canRetry];
}
