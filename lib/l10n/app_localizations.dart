import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('te')
  ];

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your mobile number to continue'**
  String get loginSubtitle;

  /// No description provided for @mobileNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumberLabel;

  /// No description provided for @mobileNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Mobile number is required'**
  String get mobileNumberRequired;

  /// No description provided for @mobileNumberInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid mobile number'**
  String get mobileNumberInvalid;

  /// No description provided for @termsAgreement.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our'**
  String get termsAgreement;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @verificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verificationTitle;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get enterVerificationCode;

  /// No description provided for @verificationCodeSentTo.
  ///
  /// In en, this message translates to:
  /// **'We have sent a 6-digit code to {phoneNumber}'**
  String verificationCodeSentTo(String phoneNumber);

  /// No description provided for @securityNote.
  ///
  /// In en, this message translates to:
  /// **'Do not share this code with anyone.'**
  String get securityNote;

  /// No description provided for @verifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verifyButton;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code? Resend'**
  String get resendCode;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// No description provided for @enterPhoneToContinue.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number to continue'**
  String get enterPhoneToContinue;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'Enter 10-digit mobile number'**
  String get phoneHint;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @newToApp.
  ///
  /// In en, this message translates to:
  /// **'New to Kirana Konu?'**
  String get newToApp;

  /// No description provided for @registerAsPartner.
  ///
  /// In en, this message translates to:
  /// **'Register as Partner'**
  String get registerAsPartner;

  /// No description provided for @otpInfo.
  ///
  /// In en, this message translates to:
  /// **'We will send you a one-time password (OTP) to verify your phone number.'**
  String get otpInfo;

  /// No description provided for @personalDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Details'**
  String get personalDetailsTitle;

  /// No description provided for @personalDetailsHeader.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get to know you'**
  String get personalDetailsHeader;

  /// No description provided for @personalDetailsSubHeader.
  ///
  /// In en, this message translates to:
  /// **'Please provide your personal and business details'**
  String get personalDetailsSubHeader;

  /// No description provided for @ownerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Owner Full Name'**
  String get ownerNameLabel;

  /// No description provided for @ownerNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get ownerNameHint;

  /// No description provided for @shopNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Shop/Hub Name'**
  String get shopNameLabel;

  /// No description provided for @shopNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Raju Traders'**
  String get shopNameHint;

  /// No description provided for @businessLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Business Location'**
  String get businessLocationTitle;

  /// No description provided for @locationDetected.
  ///
  /// In en, this message translates to:
  /// **'Location Detected'**
  String get locationDetected;

  /// No description provided for @locationNotDetected.
  ///
  /// In en, this message translates to:
  /// **'Location Not Detected'**
  String get locationNotDetected;

  /// No description provided for @updateLocation.
  ///
  /// In en, this message translates to:
  /// **'Update Location'**
  String get updateLocation;

  /// No description provided for @detectLocation.
  ///
  /// In en, this message translates to:
  /// **'Detect My Location'**
  String get detectLocation;

  /// No description provided for @continueToDocs.
  ///
  /// In en, this message translates to:
  /// **'Continue to Business Documents'**
  String get continueToDocs;

  /// No description provided for @locationPermissionBlocked.
  ///
  /// In en, this message translates to:
  /// **'Location Permission Blocked'**
  String get locationPermissionBlocked;

  /// No description provided for @locationPermissionDeniedMessage.
  ///
  /// In en, this message translates to:
  /// **'Location permission has been permanently denied. Please enable it from app settings to continue.'**
  String get locationPermissionDeniedMessage;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @locationRequired.
  ///
  /// In en, this message translates to:
  /// **'Please detect your location first'**
  String get locationRequired;

  /// No description provided for @locationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Location detected successfully!'**
  String get locationSuccess;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @businessDocsTitle.
  ///
  /// In en, this message translates to:
  /// **'Business Documents'**
  String get businessDocsTitle;

  /// No description provided for @businessDocsHeader.
  ///
  /// In en, this message translates to:
  /// **'Business Verification'**
  String get businessDocsHeader;

  /// No description provided for @businessDocsSubHeader.
  ///
  /// In en, this message translates to:
  /// **'Please provide your business documents for KYB verification'**
  String get businessDocsSubHeader;

  /// No description provided for @gstinSection.
  ///
  /// In en, this message translates to:
  /// **'GSTIN Certificate'**
  String get gstinSection;

  /// No description provided for @gstinLabel.
  ///
  /// In en, this message translates to:
  /// **'GSTIN Number'**
  String get gstinLabel;

  /// No description provided for @gstinHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., 27AAPFU0939F1ZV'**
  String get gstinHint;

  /// No description provided for @uploadGstin.
  ///
  /// In en, this message translates to:
  /// **'Upload GSTIN Certificate'**
  String get uploadGstin;

  /// No description provided for @uploadGstinHint.
  ///
  /// In en, this message translates to:
  /// **'Upload clear image or PDF of GSTIN Certificate'**
  String get uploadGstinHint;

  /// No description provided for @fssaiSection.
  ///
  /// In en, this message translates to:
  /// **'FSSAI License'**
  String get fssaiSection;

  /// No description provided for @fssaiLabel.
  ///
  /// In en, this message translates to:
  /// **'FSSAI License Number'**
  String get fssaiLabel;

  /// No description provided for @fssaiHint.
  ///
  /// In en, this message translates to:
  /// **'14-digit FSSAI number'**
  String get fssaiHint;

  /// No description provided for @uploadFssai.
  ///
  /// In en, this message translates to:
  /// **'Upload FSSAI License'**
  String get uploadFssai;

  /// No description provided for @uploadFssaiHint.
  ///
  /// In en, this message translates to:
  /// **'Upload clear image or PDF of FSSAI License'**
  String get uploadFssaiHint;

  /// No description provided for @panSection.
  ///
  /// In en, this message translates to:
  /// **'PAN Card'**
  String get panSection;

  /// No description provided for @panLabel.
  ///
  /// In en, this message translates to:
  /// **'PAN Card Number'**
  String get panLabel;

  /// No description provided for @panHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., ABCDE1234F'**
  String get panHint;

  /// No description provided for @uploadPan.
  ///
  /// In en, this message translates to:
  /// **'Upload PAN Card'**
  String get uploadPan;

  /// No description provided for @uploadPanHint.
  ///
  /// In en, this message translates to:
  /// **'Upload clear image or PDF of PAN Card'**
  String get uploadPanHint;

  /// No description provided for @shopLicenseSection.
  ///
  /// In en, this message translates to:
  /// **'Shop License'**
  String get shopLicenseSection;

  /// No description provided for @shopLicenseLabel.
  ///
  /// In en, this message translates to:
  /// **'Shop License Number'**
  String get shopLicenseLabel;

  /// No description provided for @shopLicenseHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your shop license number'**
  String get shopLicenseHint;

  /// No description provided for @uploadShopLicense.
  ///
  /// In en, this message translates to:
  /// **'Upload Shop License'**
  String get uploadShopLicense;

  /// No description provided for @uploadShopLicenseHint.
  ///
  /// In en, this message translates to:
  /// **'Upload clear image or PDF of Shop License'**
  String get uploadShopLicenseHint;

  /// No description provided for @shopImageSection.
  ///
  /// In en, this message translates to:
  /// **'Shop Photo'**
  String get shopImageSection;

  /// No description provided for @uploadShopImage.
  ///
  /// In en, this message translates to:
  /// **'Upload Shop Photo'**
  String get uploadShopImage;

  /// No description provided for @uploadShopImageHint.
  ///
  /// In en, this message translates to:
  /// **'Upload a clear photo of your shop'**
  String get uploadShopImageHint;

  /// No description provided for @bankDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Bank Details'**
  String get bankDetailsTitle;

  /// No description provided for @financialSettlementHeader.
  ///
  /// In en, this message translates to:
  /// **'Financial Settlement'**
  String get financialSettlementHeader;

  /// No description provided for @financialSettlementSubHeader.
  ///
  /// In en, this message translates to:
  /// **'Provide bank details for receiving payouts'**
  String get financialSettlementSubHeader;

  /// No description provided for @accountHolderLabel.
  ///
  /// In en, this message translates to:
  /// **'Account Holder Name'**
  String get accountHolderLabel;

  /// No description provided for @accountHolderHint.
  ///
  /// In en, this message translates to:
  /// **'Name as per bank account'**
  String get accountHolderHint;

  /// No description provided for @accountNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Bank Account Number'**
  String get accountNumberLabel;

  /// No description provided for @accountNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter account number'**
  String get accountNumberHint;

  /// No description provided for @confirmAccountLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Account Number'**
  String get confirmAccountLabel;

  /// No description provided for @confirmAccountHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter account number'**
  String get confirmAccountHint;

  /// No description provided for @ifscLabel.
  ///
  /// In en, this message translates to:
  /// **'IFSC Code'**
  String get ifscLabel;

  /// No description provided for @ifscHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., SBIN0001234'**
  String get ifscHint;

  /// No description provided for @branchLabel.
  ///
  /// In en, this message translates to:
  /// **'Branch Name (Optional)'**
  String get branchLabel;

  /// No description provided for @branchHint.
  ///
  /// In en, this message translates to:
  /// **'Will be auto-filled if available'**
  String get branchHint;

  /// No description provided for @cancelledChequeSection.
  ///
  /// In en, this message translates to:
  /// **'Cancelled Cheque'**
  String get cancelledChequeSection;

  /// No description provided for @uploadCheque.
  ///
  /// In en, this message translates to:
  /// **'Upload Cancelled Cheque/Passbook'**
  String get uploadCheque;

  /// No description provided for @uploadChequeHint.
  ///
  /// In en, this message translates to:
  /// **'Upload clear image showing account details'**
  String get uploadChequeHint;

  /// No description provided for @bankInfoNote.
  ///
  /// In en, this message translates to:
  /// **'Your bank details will be used for receiving payments. Please ensure all information is accurate.'**
  String get bankInfoNote;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// No description provided for @uploadSuccess.
  ///
  /// In en, this message translates to:
  /// **'{documentType} document uploaded successfully'**
  String uploadSuccess(String documentType);

  /// No description provided for @uploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Upload failed: {error}'**
  String uploadFailed(String error);

  /// No description provided for @reviewSubmitTitle.
  ///
  /// In en, this message translates to:
  /// **'Review & Submit'**
  String get reviewSubmitTitle;

  /// No description provided for @termsPoliciesHeader.
  ///
  /// In en, this message translates to:
  /// **'Terms & Policies'**
  String get termsPoliciesHeader;

  /// No description provided for @termsPoliciesSubHeader.
  ///
  /// In en, this message translates to:
  /// **'Please review and accept our terms before submitting'**
  String get termsPoliciesSubHeader;

  /// No description provided for @commissionPolicy.
  ///
  /// In en, this message translates to:
  /// **'Commission Policy'**
  String get commissionPolicy;

  /// No description provided for @agreeToTerms.
  ///
  /// In en, this message translates to:
  /// **'I have read and agree to the Terms of Service and Commission Policy'**
  String get agreeToTerms;

  /// No description provided for @submitApplication.
  ///
  /// In en, this message translates to:
  /// **'Submit Application'**
  String get submitApplication;

  /// No description provided for @verificationPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification Process'**
  String get verificationPendingTitle;

  /// No description provided for @verificationPendingMessage.
  ///
  /// In en, this message translates to:
  /// **'Your application will be reviewed within 24-48 hours. You will receive a notification once approved.'**
  String get verificationPendingMessage;

  /// No description provided for @submissionFailed.
  ///
  /// In en, this message translates to:
  /// **'Submission failed: {error}'**
  String submissionFailed(String error);

  /// No description provided for @registrationSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Application Submitted!'**
  String get registrationSuccessTitle;

  /// No description provided for @registrationSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Thank you for submitting your registration application. Our team will review your documents and get back to you within 24-48 hours.'**
  String get registrationSuccessMessage;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @applicationSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Application Submitted!'**
  String get applicationSubmitted;

  /// No description provided for @applicationId.
  ///
  /// In en, this message translates to:
  /// **'Application ID'**
  String get applicationId;

  /// No description provided for @saveIdInfo.
  ///
  /// In en, this message translates to:
  /// **'Save this ID for future reference'**
  String get saveIdInfo;

  /// No description provided for @verificationInProgress.
  ///
  /// In en, this message translates to:
  /// **'Verification in Progress'**
  String get verificationInProgress;

  /// No description provided for @verificationInProgressSub.
  ///
  /// In en, this message translates to:
  /// **'Your documents are being reviewed'**
  String get verificationInProgressSub;

  /// No description provided for @notifyYou.
  ///
  /// In en, this message translates to:
  /// **'We\'ll Notify You'**
  String get notifyYou;

  /// No description provided for @notifyYouSub.
  ///
  /// In en, this message translates to:
  /// **'You\'ll receive an email/SMS update'**
  String get notifyYouSub;

  /// No description provided for @needHelp.
  ///
  /// In en, this message translates to:
  /// **'Need Help?'**
  String get needHelp;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact support@kiranakonu.com'**
  String get contactSupport;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @approvalPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Approval Pending'**
  String get approvalPendingTitle;

  /// No description provided for @approvalPendingMessage.
  ///
  /// In en, this message translates to:
  /// **'Your application is currently under review. You will be notified once it is approved. This typically takes 24-48 hours.'**
  String get approvalPendingMessage;

  /// No description provided for @applicationRejectedTitle.
  ///
  /// In en, this message translates to:
  /// **'Application Rejected'**
  String get applicationRejectedTitle;

  /// No description provided for @applicationRejectedMessage.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately, your application was rejected. Please contact support for more information.'**
  String get applicationRejectedMessage;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// No description provided for @nameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 2 characters'**
  String get nameMinLength;

  /// No description provided for @nameMaxLength.
  ///
  /// In en, this message translates to:
  /// **'Name must not exceed 50 characters'**
  String get nameMaxLength;

  /// No description provided for @nameAlpha.
  ///
  /// In en, this message translates to:
  /// **'Name can only contain letters and spaces'**
  String get nameAlpha;

  /// No description provided for @mobileRequired.
  ///
  /// In en, this message translates to:
  /// **'Mobile number is required'**
  String get mobileRequired;

  /// No description provided for @mobileInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid 10-digit mobile number'**
  String get mobileInvalid;

  /// No description provided for @gstinRequired.
  ///
  /// In en, this message translates to:
  /// **'GSTIN is required'**
  String get gstinRequired;

  /// No description provided for @gstinInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid GSTIN (e.g., 27AAPFU0939F1ZV)'**
  String get gstinInvalid;

  /// No description provided for @fssaiRequired.
  ///
  /// In en, this message translates to:
  /// **'FSSAI License Number is required'**
  String get fssaiRequired;

  /// No description provided for @fssaiInvalid.
  ///
  /// In en, this message translates to:
  /// **'FSSAI License must be 14 digits'**
  String get fssaiInvalid;

  /// No description provided for @panRequired.
  ///
  /// In en, this message translates to:
  /// **'PAN Card is required'**
  String get panRequired;

  /// No description provided for @panInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid PAN (e.g., ABCDE1234F)'**
  String get panInvalid;

  /// No description provided for @shopLicenseRequired.
  ///
  /// In en, this message translates to:
  /// **'Shop License Number is required'**
  String get shopLicenseRequired;

  /// No description provided for @shopImageRequired.
  ///
  /// In en, this message translates to:
  /// **'Shop photo is required'**
  String get shopImageRequired;

  /// No description provided for @accountRequired.
  ///
  /// In en, this message translates to:
  /// **'Account number is required'**
  String get accountRequired;

  /// No description provided for @accountInvalid.
  ///
  /// In en, this message translates to:
  /// **'Account number must be 9-18 digits'**
  String get accountInvalid;

  /// No description provided for @ifscRequired.
  ///
  /// In en, this message translates to:
  /// **'IFSC Code is required'**
  String get ifscRequired;

  /// No description provided for @ifscInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid IFSC Code (e.g., SBIN0001234)'**
  String get ifscInvalid;

  /// No description provided for @shopRequired.
  ///
  /// In en, this message translates to:
  /// **'Shop/Hub name is required'**
  String get shopRequired;

  /// No description provided for @shopMinLength.
  ///
  /// In en, this message translates to:
  /// **'Shop name must be at least 3 characters'**
  String get shopMinLength;

  /// No description provided for @shopMaxLength.
  ///
  /// In en, this message translates to:
  /// **'Shop name must not exceed 100 characters'**
  String get shopMaxLength;

  /// No description provided for @otpRequired.
  ///
  /// In en, this message translates to:
  /// **'OTP is required'**
  String get otpRequired;

  /// No description provided for @otpInvalid.
  ///
  /// In en, this message translates to:
  /// **'OTP must be 6 digits'**
  String get otpInvalid;

  /// No description provided for @confirmAccountRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm account number'**
  String get confirmAccountRequired;

  /// No description provided for @accountMismatch.
  ///
  /// In en, this message translates to:
  /// **'Account numbers do not match'**
  String get accountMismatch;

  /// No description provided for @mobileAuthError.
  ///
  /// In en, this message translates to:
  /// **'Unable to verify mobile number. Please login again.'**
  String get mobileAuthError;

  /// No description provided for @mobileDoesNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Mobile number must match your login number: {authMobile}'**
  String mobileDoesNotMatch(String authMobile);

  /// No description provided for @mobileHelperMatch.
  ///
  /// In en, this message translates to:
  /// **'Must match your login number: {authMobile}'**
  String mobileHelperMatch(String authMobile);

  /// No description provided for @mobileHelperDefault.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered mobile number'**
  String get mobileHelperDefault;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'hi', 'te'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'hi': return AppLocalizationsHi();
    case 'te': return AppLocalizationsTe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
