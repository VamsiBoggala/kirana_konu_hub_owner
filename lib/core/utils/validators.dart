import 'package:hub_owner/l10n/app_localizations.dart';

/// Validators for Registration Form Fields
class Validators {
  // Private constructor to prevent instantiation
  Validators._();

  /// Validate full name (2-50 characters, letters and spaces only)
  static String? validateName(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.nameRequired;
    }
    if (value.trim().length < 2) {
      return l10n.nameMinLength;
    }
    if (value.trim().length > 50) {
      return l10n.nameMaxLength;
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return l10n.nameAlpha;
    }
    return null;
  }

  /// Validate mobile number (10 digits, Indian format)
  static String? validateMobile(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.mobileRequired;
    }
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value.trim())) {
      return l10n.mobileInvalid;
    }
    return null;
  }

  /// Validate mobile number matches the authenticated user's mobile number
  static String? validateMobileMatchesAuth(String? value, AppLocalizations l10n, String? authMobile) {
    // First do basic mobile validation
    final basicValidation = validateMobile(value, l10n);
    if (basicValidation != null) {
      return basicValidation;
    }

    // Check if auth mobile is available
    if (authMobile == null || authMobile.isEmpty) {
      return l10n.mobileAuthError;
    }

    // Extract last 10 digits from auth mobile (in case it has country code)
    final authMobileLast10 = authMobile.length >= 10 ? authMobile.substring(authMobile.length - 10) : authMobile;

    // Compare with entered mobile
    if (value!.trim() != authMobileLast10) {
      return l10n.mobileDoesNotMatch(authMobileLast10);
    }

    return null;
  }

  /// Alias for validateMobile
  static String? validatePhone(String? value, AppLocalizations l10n) => validateMobile(value, l10n);

  /// Validate GSTIN (15 characters, specific format)
  /// Format: 2 digits + 5 letters + 4 digits + 1 letter + 1 letter/digit + Z + 1 letter/digit
  static String? validateGSTIN(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.gstinRequired;
    }
    final gstin = value.trim().toUpperCase();
    if (!RegExp(r'^\d{2}[A-Z]{5}\d{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$').hasMatch(gstin)) {
      return l10n.gstinInvalid;
    }
    return null;
  }

  /// Validate FSSAI License Number (14 digits)
  static String? validateFSSAI(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.fssaiRequired;
    }
    if (!RegExp(r'^\d{14}$').hasMatch(value.trim())) {
      return l10n.fssaiInvalid;
    }
    return null;
  }

  /// Validate PAN Card (10 characters: 5 letters + 4 digits + 1 letter)
  static String? validatePAN(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.panRequired;
    }
    final pan = value.trim().toUpperCase();
    if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$').hasMatch(pan)) {
      return l10n.panInvalid;
    }
    return null;
  }

  /// Validate Bank Account Number (9-18 digits)
  static String? validateAccountNumber(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.accountRequired;
    }
    if (!RegExp(r'^\d{9,18}$').hasMatch(value.trim())) {
      return l10n.accountInvalid;
    }
    return null;
  }

  /// Validate IFSC Code (11 characters: 4 letters + 0 + 6 alphanumeric)
  static String? validateIFSC(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.ifscRequired;
    }
    final ifsc = value.trim().toUpperCase();
    if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(ifsc)) {
      return l10n.ifscInvalid;
    }
    return null;
  }

  /// Validate Shop/Hub Name (3-100 characters)
  static String? validateShopName(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.shopRequired;
    }
    if (value.trim().length < 3) {
      return l10n.shopMinLength;
    }
    if (value.trim().length > 100) {
      return l10n.shopMaxLength;
    }
    return null;
  }

  /// Validate OTP (6 digits)
  static String? validateOTP(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.otpRequired;
    }
    if (!RegExp(r'^\d{6}$').hasMatch(value.trim())) {
      return l10n.otpInvalid;
    }
    return null;
  }

  /// Validate License Number (alphanumeric, 5-20 characters)
  static String? validateLicenseNumber(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return 'License number is required';
    }
    if (value.trim().length < 5 || value.trim().length > 20) {
      return 'License number must be 5-20 characters';
    }
    if (!RegExp(r'^[A-Z0-9]+$').hasMatch(value.trim().toUpperCase())) {
      return 'License number can only contain letters and numbers';
    }
    return null;
  }
}
