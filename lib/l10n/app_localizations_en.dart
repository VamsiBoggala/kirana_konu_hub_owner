// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginTitle => 'Login';

  @override
  String get loginSubtitle => 'Enter your mobile number to continue';

  @override
  String get mobileNumberLabel => 'Mobile Number';

  @override
  String get mobileNumberRequired => 'Mobile number is required';

  @override
  String get mobileNumberInvalid => 'Please enter a valid mobile number';

  @override
  String get termsAgreement => 'By continuing, you agree to our';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get and => 'and';

  @override
  String get verificationTitle => 'Verification';

  @override
  String get enterVerificationCode => 'Enter Verification Code';

  @override
  String verificationCodeSentTo(String phoneNumber) {
    return 'We have sent a 6-digit code to $phoneNumber';
  }

  @override
  String get securityNote => 'Do not share this code with anyone.';

  @override
  String get verifyButton => 'Verify';

  @override
  String get resendCode => 'Didn\'t receive code? Resend';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get enterPhoneToContinue => 'Enter your phone number to continue';

  @override
  String get phoneHint => 'Enter 10-digit mobile number';

  @override
  String get continueButton => 'Continue';

  @override
  String get newToApp => 'New to Kirana Konu?';

  @override
  String get registerAsPartner => 'Register as Partner';

  @override
  String get otpInfo => 'We will send you a one-time password (OTP) to verify your phone number.';

  @override
  String get personalDetailsTitle => 'Personal Details';

  @override
  String get personalDetailsHeader => 'Let\'s get to know you';

  @override
  String get personalDetailsSubHeader => 'Please provide your personal and business details';

  @override
  String get ownerNameLabel => 'Owner Full Name';

  @override
  String get ownerNameHint => 'Enter your full name';

  @override
  String get shopNameLabel => 'Shop/Hub Name';

  @override
  String get shopNameHint => 'e.g., Raju Traders';

  @override
  String get businessLocationTitle => 'Business Location';

  @override
  String get locationDetected => 'Location Detected';

  @override
  String get locationNotDetected => 'Location Not Detected';

  @override
  String get updateLocation => 'Update Location';

  @override
  String get detectLocation => 'Detect My Location';

  @override
  String get continueToDocs => 'Continue to Business Documents';

  @override
  String get locationPermissionBlocked => 'Location Permission Blocked';

  @override
  String get locationPermissionDeniedMessage => 'Location permission has been permanently denied. Please enable it from app settings to continue.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get cancel => 'Cancel';

  @override
  String get locationRequired => 'Please detect your location first';

  @override
  String get locationSuccess => 'Location detected successfully!';

  @override
  String get settings => 'Settings';

  @override
  String get businessDocsTitle => 'Business Documents';

  @override
  String get businessDocsHeader => 'Business Verification';

  @override
  String get businessDocsSubHeader => 'Please provide your business documents for KYB verification';

  @override
  String get gstinSection => 'GSTIN Certificate';

  @override
  String get gstinLabel => 'GSTIN Number';

  @override
  String get gstinHint => 'e.g., 27AAPFU0939F1ZV';

  @override
  String get uploadGstin => 'Upload GSTIN Certificate';

  @override
  String get uploadGstinHint => 'Upload clear image or PDF of GSTIN Certificate';

  @override
  String get fssaiSection => 'FSSAI License';

  @override
  String get fssaiLabel => 'FSSAI License Number';

  @override
  String get fssaiHint => '14-digit FSSAI number';

  @override
  String get uploadFssai => 'Upload FSSAI License';

  @override
  String get uploadFssaiHint => 'Upload clear image or PDF of FSSAI License';

  @override
  String get panSection => 'PAN Card';

  @override
  String get panLabel => 'PAN Card Number';

  @override
  String get panHint => 'e.g., ABCDE1234F';

  @override
  String get uploadPan => 'Upload PAN Card';

  @override
  String get uploadPanHint => 'Upload clear image or PDF of PAN Card';

  @override
  String get shopLicenseSection => 'Shop License';

  @override
  String get shopLicenseLabel => 'Shop License Number';

  @override
  String get shopLicenseHint => 'Enter your shop license number';

  @override
  String get uploadShopLicense => 'Upload Shop License';

  @override
  String get uploadShopLicenseHint => 'Upload clear image or PDF of Shop License';

  @override
  String get shopImageSection => 'Shop Photo';

  @override
  String get uploadShopImage => 'Upload Shop Photo';

  @override
  String get uploadShopImageHint => 'Upload a clear photo of your shop';

  @override
  String get bankDetailsTitle => 'Bank Details';

  @override
  String get financialSettlementHeader => 'Financial Settlement';

  @override
  String get financialSettlementSubHeader => 'Provide bank details for receiving payouts';

  @override
  String get accountHolderLabel => 'Account Holder Name';

  @override
  String get accountHolderHint => 'Name as per bank account';

  @override
  String get accountNumberLabel => 'Bank Account Number';

  @override
  String get accountNumberHint => 'Enter account number';

  @override
  String get confirmAccountLabel => 'Confirm Account Number';

  @override
  String get confirmAccountHint => 'Re-enter account number';

  @override
  String get ifscLabel => 'IFSC Code';

  @override
  String get ifscHint => 'e.g., SBIN0001234';

  @override
  String get branchLabel => 'Branch Name (Optional)';

  @override
  String get branchHint => 'Will be auto-filled if available';

  @override
  String get cancelledChequeSection => 'Cancelled Cheque';

  @override
  String get uploadCheque => 'Upload Cancelled Cheque/Passbook';

  @override
  String get uploadChequeHint => 'Upload clear image showing account details';

  @override
  String get bankInfoNote => 'Your bank details will be used for receiving payments. Please ensure all information is accurate.';

  @override
  String get backButton => 'Back';

  @override
  String uploadSuccess(String documentType) {
    return '$documentType document uploaded successfully';
  }

  @override
  String uploadFailed(String error) {
    return 'Upload failed: $error';
  }

  @override
  String get reviewSubmitTitle => 'Review & Submit';

  @override
  String get termsPoliciesHeader => 'Terms & Policies';

  @override
  String get termsPoliciesSubHeader => 'Please review and accept our terms before submitting';

  @override
  String get commissionPolicy => 'Commission Policy';

  @override
  String get agreeToTerms => 'I have read and agree to the Terms of Service and Commission Policy';

  @override
  String get submitApplication => 'Submit Application';

  @override
  String get verificationPendingTitle => 'Verification Process';

  @override
  String get verificationPendingMessage => 'Your application will be reviewed within 24-48 hours. You will receive a notification once approved.';

  @override
  String submissionFailed(String error) {
    return 'Submission failed: $error';
  }

  @override
  String get registrationSuccessTitle => 'Application Submitted!';

  @override
  String get registrationSuccessMessage => 'Thank you for submitting your registration application. Our team will review your documents and get back to you within 24-48 hours.';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get applicationSubmitted => 'Application Submitted!';

  @override
  String get applicationId => 'Application ID';

  @override
  String get saveIdInfo => 'Save this ID for future reference';

  @override
  String get verificationInProgress => 'Verification in Progress';

  @override
  String get verificationInProgressSub => 'Your documents are being reviewed';

  @override
  String get notifyYou => 'We\'ll Notify You';

  @override
  String get notifyYouSub => 'You\'ll receive an email/SMS update';

  @override
  String get needHelp => 'Need Help?';

  @override
  String get contactSupport => 'Contact support@kiranakonu.com';

  @override
  String get done => 'Done';

  @override
  String get approvalPendingTitle => 'Approval Pending';

  @override
  String get approvalPendingMessage => 'Your application is currently under review. You will be notified once it is approved. This typically takes 24-48 hours.';

  @override
  String get applicationRejectedTitle => 'Application Rejected';

  @override
  String get applicationRejectedMessage => 'Unfortunately, your application was rejected. Please contact support for more information.';

  @override
  String get ok => 'OK';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get nameMinLength => 'Name must be at least 2 characters';

  @override
  String get nameMaxLength => 'Name must not exceed 50 characters';

  @override
  String get nameAlpha => 'Name can only contain letters and spaces';

  @override
  String get mobileRequired => 'Mobile number is required';

  @override
  String get mobileInvalid => 'Please enter a valid 10-digit mobile number';

  @override
  String get gstinRequired => 'GSTIN is required';

  @override
  String get gstinInvalid => 'Please enter a valid GSTIN (e.g., 27AAPFU0939F1ZV)';

  @override
  String get fssaiRequired => 'FSSAI License Number is required';

  @override
  String get fssaiInvalid => 'FSSAI License must be 14 digits';

  @override
  String get panRequired => 'PAN Card is required';

  @override
  String get panInvalid => 'Please enter a valid PAN (e.g., ABCDE1234F)';

  @override
  String get shopLicenseRequired => 'Shop License Number is required';

  @override
  String get shopImageRequired => 'Shop photo is required';

  @override
  String get accountRequired => 'Account number is required';

  @override
  String get accountInvalid => 'Account number must be 9-18 digits';

  @override
  String get ifscRequired => 'IFSC Code is required';

  @override
  String get ifscInvalid => 'Please enter a valid IFSC Code (e.g., SBIN0001234)';

  @override
  String get shopRequired => 'Shop/Hub name is required';

  @override
  String get shopMinLength => 'Shop name must be at least 3 characters';

  @override
  String get shopMaxLength => 'Shop name must not exceed 100 characters';

  @override
  String get otpRequired => 'OTP is required';

  @override
  String get otpInvalid => 'OTP must be 6 digits';

  @override
  String get confirmAccountRequired => 'Please confirm account number';

  @override
  String get accountMismatch => 'Account numbers do not match';

  @override
  String get mobileAuthError => 'Unable to verify mobile number. Please login again.';

  @override
  String mobileDoesNotMatch(String authMobile) {
    return 'Mobile number must match your login number: $authMobile';
  }

  @override
  String mobileHelperMatch(String authMobile) {
    return 'Must match your login number: $authMobile';
  }

  @override
  String get mobileHelperDefault => 'Enter your registered mobile number';
}
