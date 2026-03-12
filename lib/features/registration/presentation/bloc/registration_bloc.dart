import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/services/firestore_service.dart';
import '../../../../core/constants/firestore_collections.dart';
import '../../data/models/hub_registration_model.dart';
import 'registration_event.dart';
import 'registration_state.dart';

/// Registration BLoC
/// Manages the entire registration flow state and business logic
/// Registration BLoC
/// Manages the entire registration flow state and business logic
class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final StorageService _storageService = StorageService();
  final FirestoreService _firestoreService = FirestoreService();

  RegistrationBloc() : super(RegistrationInitial(registrationData: HubRegistrationModel.empty())) {
    // Register event handlers
    on<UpdatePersonalDetailsEvent>(_onUpdatePersonalDetails);
    on<DetectLocationEvent>(_onDetectLocation);
    on<UpdateLocationEvent>(_onUpdateLocation);
    on<UpdateGSTINEvent>(_onUpdateGSTIN);
    on<UpdateFSSAIEvent>(_onUpdateFSSAI);
    on<UpdateGSTINFileEvent>(_onUpdateGSTINFile);
    on<UpdateFSSAIFileEvent>(_onUpdateFSSAIFile);
    on<UpdatePANCardFileEvent>(_onUpdatePANCardFile);
    on<UpdateShopLicenseFileEvent>(_onUpdateShopLicenseFile);
    on<UpdateShopImageFileEvent>(_onUpdateShopImageFile);
    on<ValidateAndProceedToBankDetailsEvent>(_onValidateAndProceedToBankDetails);
    on<UpdateBankDetailsEvent>(_onUpdateBankDetails);
    on<UpdateCancelledChequeFileEvent>(_onUpdateCancelledChequeFile);
    on<LookupIFSCEvent>(_onLookupIFSC);
    on<ValidateAndProceedToTermsEvent>(_onValidateAndProceedToTerms);
    on<ToggleTermsAcceptanceEvent>(_onToggleTermsAcceptance);
    on<ValidateAndSubmitRegistrationEvent>(_onValidateAndSubmitRegistration);
    on<AcceptTermsEvent>(_onAcceptTerms);
    on<UploadDocumentEvent>(_onUploadDocument);
    on<SubmitRegistrationEvent>(_onSubmitRegistration);
    on<ResetRegistrationEvent>(_onResetRegistration);
    on<UploadImagesAndSubmitEvent>(_onUploadImagesAndSubmit);
    on<RetrySubmissionEvent>(_onRetrySubmission);
  }

  /// Get current registration data
  HubRegistrationModel get currentData {
    if (state is RegistrationInitial) {
      return (state as RegistrationInitial).registrationData;
    } else if (state is RegistrationDataUpdated) {
      return (state as RegistrationDataUpdated).registrationData;
    } else if (state is RegistrationLoading) {
      return (state as RegistrationLoading).registrationData;
    } else if (state is DocumentUploadInProgress) {
      return (state as DocumentUploadInProgress).registrationData;
    } else if (state is DocumentUploadSuccess) {
      return (state as DocumentUploadSuccess).registrationData;
    } else if (state is DocumentUploadFailed) {
      return (state as DocumentUploadFailed).registrationData;
    } else if (state is LocationDetecting) {
      return (state as LocationDetecting).registrationData;
    } else if (state is LocationUpdated) {
      return (state as LocationUpdated).registrationData;
    } else if (state is LocationError) {
      return (state as LocationError).registrationData;
    } else if (state is LocationPermissionDenied) {
      return (state as LocationPermissionDenied).registrationData;
    } else if (state is LocationPermissionPermanentlyDenied) {
      return (state as LocationPermissionPermanentlyDenied).registrationData;
    } else if (state is ValidationError) {
      return (state as ValidationError).registrationData;
    } else if (state is NavigateToNextScreen) {
      return (state as NavigateToNextScreen).registrationData;
    } else if (state is IFSCLookupSuccess) {
      return (state as IFSCLookupSuccess).registrationData;
    } else if (state is RegistrationFailed) {
      return (state as RegistrationFailed).registrationData;
    } else if (state is ImagesUploading) {
      return (state as ImagesUploading).registrationData;
    } else if (state is ImagesUploadSuccess) {
      return (state as ImagesUploadSuccess).registrationData;
    } else if (state is ImagesUploadFailed) {
      return (state as ImagesUploadFailed).registrationData;
    } else if (state is SubmittingRequest) {
      return (state as SubmittingRequest).registrationData;
    } else if (state is SubmissionSuccess) {
      return (state as SubmissionSuccess).registrationData;
    } else if (state is SubmissionFailed) {
      return (state as SubmissionFailed).registrationData;
    }
    return HubRegistrationModel.empty();
  }

  /// Update Personal Details
  void _onUpdatePersonalDetails(UpdatePersonalDetailsEvent event, Emitter<RegistrationState> emit) {
    final updatedData = currentData.copyWith(
      ownerName: event.ownerName,
      mobileNumber: event.mobileNumber,
      shopName: event.shopName,
    );
    emit(RegistrationDataUpdated(registrationData: updatedData));
  }

  /// Detect Location
  Future<void> _onDetectLocation(DetectLocationEvent event, Emitter<RegistrationState> emit) async {
    emit(LocationDetecting(registrationData: currentData));

    try {
      // Check current location permission status
      PermissionStatus status = await Permission.location.status;

      // If permission is permanently denied, guide user to settings
      if (status.isPermanentlyDenied) {
        emit(LocationPermissionPermanentlyDenied(registrationData: currentData));
        return;
      }

      // Request permission - this will show system dialog if not granted
      status = await Permission.location.request();

      // Check if permission is granted after request
      if (status.isGranted) {
        // Get current position
        final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

        // Update data with location
        final updatedData = currentData.copyWith(
          latitude: position.latitude,
          longitude: position.longitude,
          address: 'Lat: ${position.latitude}, Lng: ${position.longitude}',
        );

        emit(LocationUpdated(registrationData: updatedData));
      } else if (status.isPermanentlyDenied) {
        // Permission permanently denied, guide to settings
        emit(LocationPermissionPermanentlyDenied(registrationData: currentData));
      } else {
        // Permission denied
        emit(LocationPermissionDenied(registrationData: currentData));
      }
    } catch (e) {
      emit(LocationError(registrationData: currentData, error: e.toString()));
    }
  }

  /// Update Location
  void _onUpdateLocation(UpdateLocationEvent event, Emitter<RegistrationState> emit) {
    final updatedData = currentData.copyWith(
      latitude: event.latitude,
      longitude: event.longitude,
      address: event.address,
    );
    emit(LocationUpdated(registrationData: updatedData));
  }

  /// Update GSTIN
  void _onUpdateGSTIN(UpdateGSTINEvent event, Emitter<RegistrationState> emit) {
    final updatedData = currentData.copyWith(gstinNumber: event.gstinNumber, gstinDocUrl: event.gstinDocUrl);
    emit(RegistrationDataUpdated(registrationData: updatedData));
  }

  /// Update FSSAI
  void _onUpdateFSSAI(UpdateFSSAIEvent event, Emitter<RegistrationState> emit) {
    final updatedData = currentData.copyWith(fssaiNumber: event.fssaiNumber, fssaiDocUrl: event.fssaiDocUrl);
    emit(RegistrationDataUpdated(registrationData: updatedData));
  }

  /// Update GSTIN File
  void _onUpdateGSTINFile(UpdateGSTINFileEvent event, Emitter<RegistrationState> emit) {
    var updatedData = currentData.copyWith(gstinFilePath: event.filePath);
    // Clear URL if file changes, to ensure re-upload
    if (event.filePath != null) {
      updatedData = updatedData.copyWith(gstinDocUrl: null);
    }
    emit(RegistrationDataUpdated(registrationData: updatedData));
  }

  /// Update FSSAI File
  void _onUpdateFSSAIFile(UpdateFSSAIFileEvent event, Emitter<RegistrationState> emit) {
    var updatedData = currentData.copyWith(fssaiFilePath: event.filePath);
    // Clear URL if file changes
    if (event.filePath != null) {
      updatedData = updatedData.copyWith(fssaiDocUrl: null);
    }
    emit(RegistrationDataUpdated(registrationData: updatedData));
  }

  /// Update PAN Card File
  void _onUpdatePANCardFile(UpdatePANCardFileEvent event, Emitter<RegistrationState> emit) {
    var updatedData = currentData.copyWith(panFilePath: event.filePath);
    // Clear URL if file changes
    if (event.filePath != null) {
      updatedData = updatedData.copyWith(panDocUrl: null);
    }
    emit(RegistrationDataUpdated(registrationData: updatedData));
  }

  /// Update Shop License File
  void _onUpdateShopLicenseFile(UpdateShopLicenseFileEvent event, Emitter<RegistrationState> emit) {
    var updatedData = currentData.copyWith(shopLicenseFilePath: event.filePath);
    // Clear URL if file changes
    if (event.filePath != null) {
      updatedData = updatedData.copyWith(shopLicenseDocUrl: null);
    }
    emit(RegistrationDataUpdated(registrationData: updatedData));
  }

  /// Update Shop Image File
  void _onUpdateShopImageFile(UpdateShopImageFileEvent event, Emitter<RegistrationState> emit) {
    var updatedData = currentData.copyWith(shopImageFilePath: event.filePath);
    // Clear URL if file changes
    if (event.filePath != null) {
      updatedData = updatedData.copyWith(shopImageUrl: null);
    }
    emit(RegistrationDataUpdated(registrationData: updatedData));
  }

  /// Validate Business Documents and Proceed
  void _onValidateAndProceedToBankDetails(ValidateAndProceedToBankDetailsEvent event, Emitter<RegistrationState> emit) {
    // Update all document numbers
    final updatedData = currentData.copyWith(
      gstinNumber: event.gstinNumber,
      fssaiNumber: event.fssaiNumber,
      panNumber: event.panNumber,
      shopLicenseNumber: event.shopLicenseNumber,
    );

    // Validate that required files are selected (either path or existing url)
    if ((updatedData.gstinFilePath == null || updatedData.gstinFilePath!.isEmpty) &&
        (updatedData.gstinDocUrl == null || updatedData.gstinDocUrl!.isEmpty)) {
      emit(ValidationError(registrationData: updatedData, error: 'Please upload GSTIN document'));
      return;
    }

    if ((updatedData.fssaiFilePath == null || updatedData.fssaiFilePath!.isEmpty) &&
        (updatedData.fssaiDocUrl == null || updatedData.fssaiDocUrl!.isEmpty)) {
      emit(ValidationError(registrationData: updatedData, error: 'Please upload FSSAI document'));
      return;
    }

    // Validate PAN card (required)
    if ((updatedData.panFilePath == null || updatedData.panFilePath!.isEmpty) &&
        (updatedData.panDocUrl == null || updatedData.panDocUrl!.isEmpty)) {
      emit(ValidationError(registrationData: updatedData, error: 'Please upload PAN card document'));
      return;
    }

    // Validate shop license (required)
    if ((updatedData.shopLicenseFilePath == null || updatedData.shopLicenseFilePath!.isEmpty) &&
        (updatedData.shopLicenseDocUrl == null || updatedData.shopLicenseDocUrl!.isEmpty)) {
      emit(ValidationError(registrationData: updatedData, error: 'Please upload Shop License document'));
      return;
    }

    // Validate shop image (required)
    if ((updatedData.shopImageFilePath == null || updatedData.shopImageFilePath!.isEmpty) &&
        (updatedData.shopImageUrl == null || updatedData.shopImageUrl!.isEmpty)) {
      emit(ValidationError(registrationData: updatedData, error: 'Please upload Shop Photo'));
      return;
    }

    // All validation passed, trigger navigation
    emit(RegistrationDataUpdated(registrationData: updatedData));
    emit(NavigateToNextScreen(registrationData: updatedData, routeName: '/registration/bank-details'));
  }

  /// Update Bank Details
  void _onUpdateBankDetails(UpdateBankDetailsEvent event, Emitter<RegistrationState> emit) {
    final updatedData = currentData.copyWith(
      bankAccountHolderName: event.accountHolderName,
      bankAccountNumber: event.accountNumber,
      ifscCode: event.ifscCode,
      branchName: event.branchName,
      cancelledChequeUrl: event.cancelledChequeUrl,
    );
    emit(RegistrationDataUpdated(registrationData: updatedData));
  }

  /// Update Cancelled Cheque File
  void _onUpdateCancelledChequeFile(UpdateCancelledChequeFileEvent event, Emitter<RegistrationState> emit) {
    var updatedData = currentData.copyWith(cancelledChequeFilePath: event.filePath);
    if (event.filePath != null) {
      updatedData = updatedData.copyWith(cancelledChequeUrl: null);
    }
    emit(RegistrationDataUpdated(registrationData: updatedData));
  }

  /// Lookup IFSC Code
  void _onLookupIFSC(LookupIFSCEvent event, Emitter<RegistrationState> emit) {
    // Mock IFSC lookup - in production, use an IFSC API
    if (event.ifscCode.length == 11) {
      // Simulated branch name
      final branchName = 'Branch Name (Auto-fetched for ${event.ifscCode.substring(0, 4)})';

      final updatedData = currentData.copyWith(branchName: branchName);
      emit(IFSCLookupSuccess(registrationData: updatedData, branchName: branchName));
    }
  }

  /// Validate Bank Details and Proceed
  void _onValidateAndProceedToTerms(ValidateAndProceedToTermsEvent event, Emitter<RegistrationState> emit) {
    // Update bank details
    final updatedData = currentData.copyWith(
      bankAccountHolderName: event.accountHolderName,
      bankAccountNumber: event.accountNumber,
      ifscCode: event.ifscCode,
      branchName: event.branchName,
    );

    // Validate that file is selected
    if ((updatedData.cancelledChequeFilePath == null || updatedData.cancelledChequeFilePath!.isEmpty) &&
        (updatedData.cancelledChequeUrl == null || updatedData.cancelledChequeUrl!.isEmpty)) {
      emit(ValidationError(registrationData: updatedData, error: 'Please upload cancelled cheque'));
      return;
    }

    // All validation passed, trigger navigation
    emit(RegistrationDataUpdated(registrationData: updatedData));
    emit(NavigateToNextScreen(registrationData: updatedData, routeName: '/registration/terms-and-submit'));
  }

  /// Toggle Terms Acceptance
  void _onToggleTermsAcceptance(ToggleTermsAcceptanceEvent event, Emitter<RegistrationState> emit) {
    final currentTermsAccepted = currentData.termsAccepted;
    final updatedData = currentData.copyWith(termsAccepted: !currentTermsAccepted);
    emit(RegistrationDataUpdated(registrationData: updatedData));
  }

  /// Validate and Submit Registration
  void _onValidateAndSubmitRegistration(ValidateAndSubmitRegistrationEvent event, Emitter<RegistrationState> emit) {
    // Check if terms are accepted
    if (!currentData.termsAccepted) {
      emit(ValidationError(registrationData: currentData, error: 'Please accept the terms and conditions'));
      return;
    }

    // Instead of mock submit, we are now using UploadImagesAndSubmitEvent manually from UI
    // But if this event is triggered, we can direct it there if we had UserId.
    // Since this event doesn't carry UserId, the UI should call UploadImagesAndSubmitEvent directly.
  }

  /// Accept Terms
  void _onAcceptTerms(AcceptTermsEvent event, Emitter<RegistrationState> emit) {
    final updatedData = currentData.copyWith(termsAccepted: event.accepted);
    emit(RegistrationDataUpdated(registrationData: updatedData));
  }

  /// Upload Document - Legacy Mock implementation (Can be kept or deprecated)
  Future<void> _onUploadDocument(UploadDocumentEvent event, Emitter<RegistrationState> emit) async {
    // This was the immediate mock upload. We are now moving to batch upload at the end.
    // Leaving empty or just updating state without action.
  }

  /// Submit Registration - Legacy Mock
  Future<void> _onSubmitRegistration(SubmitRegistrationEvent event, Emitter<RegistrationState> emit) async {
    // Legacy event
  }

  /// Reset Registration
  void _onResetRegistration(ResetRegistrationEvent event, Emitter<RegistrationState> emit) {
    emit(RegistrationInitial(registrationData: HubRegistrationModel.empty()));
  }

  /// Upload Images and Submit Registration (Real Implementation)
  Future<void> _onUploadImagesAndSubmit(UploadImagesAndSubmitEvent event, Emitter<RegistrationState> emit) async {
    try {
      final userId = event.userId;
      final data = currentData;

      // 1. Prepare Uploads
      final uploads = <String, String>{};

      if (data.gstinFilePath != null && data.gstinFilePath!.isNotEmpty) {
        uploads[StoragePaths.gstCertificate(userId)] = data.gstinFilePath!;
      }

      if (data.fssaiFilePath != null && data.fssaiFilePath!.isNotEmpty) {
        uploads['${StoragePaths.hubDocuments}/$userId/fssai.jpg'] = data.fssaiFilePath!;
      }

      if (data.panFilePath != null && data.panFilePath!.isNotEmpty) {
        uploads['${StoragePaths.hubDocuments}/$userId/pan.jpg'] = data.panFilePath!;
      }

      if (data.shopLicenseFilePath != null && data.shopLicenseFilePath!.isNotEmpty) {
        uploads['${StoragePaths.hubDocuments}/$userId/shop_license.jpg'] = data.shopLicenseFilePath!;
      }

      if (data.shopImageFilePath != null && data.shopImageFilePath!.isNotEmpty) {
        uploads['${StoragePaths.hubDocuments}/$userId/shop_image.jpg'] = data.shopImageFilePath!;
      }

      if (data.cancelledChequeFilePath != null && data.cancelledChequeFilePath!.isNotEmpty) {
        uploads[StoragePaths.cancelledCheque(userId)] = data.cancelledChequeFilePath!;
      }

      // If no files to upload, proceed to submit
      if (uploads.isEmpty) {
        // Proceed to submit directly
        add(const SubmitRegistrationEvent()); // Wait, SubmitRegistrationEvent is legacy mock.
        // We should call internal submit helper or just do it here.
        // Let's do it here.
        return _performSubmission(userId, data, {}, emit);
      }

      // 2. Upload Images
      emit(
        ImagesUploading(registrationData: data, current: 0, total: uploads.length, currentFile: 'Starting upload...'),
      );

      final imageUrls = await _storageService.uploadMultipleImages(
        uploads: uploads,
        onProgress: (current, total) {
          // Find current file name for display
          String currentFile = '';
          if (current > 0 && current <= uploads.length) {
            currentFile = uploads.values.elementAt(current - 1).split('/').last;
          }
          emit(
            ImagesUploading(registrationData: currentData, current: current, total: total, currentFile: currentFile),
          );
        },
      );

      // Check if all requested uploads succeeded
      if (imageUrls.length != uploads.length) {
        emit(
          ImagesUploadFailed(
            registrationData: currentData, // keep current data
            error: 'Failed to upload all images. Please try again.',
            partialUrls: imageUrls,
          ),
        );
        return;
      }

      emit(ImagesUploadSuccess(registrationData: currentData, imageUrls: imageUrls));

      // 3. Submit Data
      await _performSubmission(userId, currentData, imageUrls, emit);
    } catch (e) {
      emit(SubmissionFailed(registrationData: currentData, error: e.toString()));
    }
  }

  Future<void> _performSubmission(
    String userId,
    HubRegistrationModel data,
    Map<String, String> newImageUrls,
    Emitter<RegistrationState> emit,
  ) async {
    emit(SubmittingRequest(registrationData: data));

    try {
      // Merge new URLs into data
      // Note: We need to map storage paths back to model fields correctly.

      String? gstinUrl = newImageUrls[StoragePaths.gstCertificate(userId)] ?? data.gstinDocUrl;
      String? fssaiUrl = newImageUrls['${StoragePaths.hubDocuments}/$userId/fssai.jpg'] ?? data.fssaiDocUrl;
      String? panUrl = newImageUrls['${StoragePaths.hubDocuments}/$userId/pan.jpg'] ?? data.panDocUrl;
      String? shopLicenseUrl =
          newImageUrls['${StoragePaths.hubDocuments}/$userId/shop_license.jpg'] ?? data.shopLicenseDocUrl;
      String? shopImageUrl = newImageUrls['${StoragePaths.hubDocuments}/$userId/shop_image.jpg'] ?? data.shopImageUrl;
      String? cancelledChequeUrl = newImageUrls[StoragePaths.cancelledCheque(userId)] ?? data.cancelledChequeUrl;

      // Update model with final URLs
      final finalData = data.copyWith(
        gstinDocUrl: gstinUrl,
        fssaiDocUrl: fssaiUrl,
        panDocUrl: panUrl,
        shopLicenseDocUrl: shopLicenseUrl,
        shopImageUrl: shopImageUrl,
        cancelledChequeUrl: cancelledChequeUrl,
        ownerUid: userId,
        status: 'pending_verification',
        submittedAt: DateTime.now(),
      );

      // Convert to Firestore Map
      // Using HubRequestModel structure would be cleaner but let's use the HubRegistrationModel.toJson
      // and maybe enhance it or just map it here.
      // Let's use the toJson() for now as it matches what specific field names the app expects.
      // But we should ensure it matches the "HubRequestModel" expectations if we want to follow the previous guide.
      // The guide said "HubRequestModel" has "gstCertificateUrl", but HubRegistrationModel has "gstinDocUrl".
      // I will use HubRegistrationModel's structure which is what the app uses.

      await _firestoreService.submitHubRequest(userId: userId, requestData: finalData.toJson());

      emit(SubmissionSuccess(registrationData: finalData, requestId: userId));
    } catch (e) {
      emit(SubmissionFailed(registrationData: data, error: 'Failed to save data: ${e.toString()}'));
    }
  }

  void _onRetrySubmission(RetrySubmissionEvent event, Emitter<RegistrationState> emit) {
    add(UploadImagesAndSubmitEvent(userId: event.userId));
  }
}
