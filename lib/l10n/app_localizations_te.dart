// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get loginTitle => 'లాగిన్';

  @override
  String get loginSubtitle => 'కొనసాగడానికి మీ మొబైల్ నంబర్‌ను నమోదు చేయండి';

  @override
  String get mobileNumberLabel => 'మొబైల్ నంబర్';

  @override
  String get mobileNumberRequired => 'మొబైల్ నంబర్ అవసరం';

  @override
  String get mobileNumberInvalid => 'దయచేసి సరైన మొబైల్ నంబర్‌ను నమోదు చేయండి';

  @override
  String get termsAgreement => 'కొనసాగించడం ద్వారా, మీరు మా అంగీకరిస్తున్నారు';

  @override
  String get termsOfService => 'సేవా నిబంధనలు';

  @override
  String get privacyPolicy => 'గోప్యతా విధానం';

  @override
  String get and => 'మరియు';

  @override
  String get verificationTitle => 'ధృవీకరణ';

  @override
  String get enterVerificationCode => 'ధృవీకరణ కోడ్‌ను నమోదు చేయండి';

  @override
  String verificationCodeSentTo(String phoneNumber) {
    return 'మేము $phoneNumber కి 6 అంకెల కోడ్‌ను పంపాము';
  }

  @override
  String get securityNote => 'ఈ కోడ్‌ను ఎవరితోనూ పంచుకోవద్దు.';

  @override
  String get verifyButton => 'ధృవీకరించండి';

  @override
  String get resendCode => 'కోడ్ రాలేదా? మళ్ళీ పంపండి';

  @override
  String get selectLanguage => 'భాషను ఎంచుకోండి';

  @override
  String get welcomeBack => 'మళ్ళీ స్వాగతం!';

  @override
  String get enterPhoneToContinue => 'కొనసాగడానికి మీ ఫోన్ నంబర్‌ను నమోదు చేయండి';

  @override
  String get phoneHint => '10-అంకెల మొబైల్ నంబర్‌ను నమోదు చేయండి';

  @override
  String get continueButton => 'కొనసాగించండి';

  @override
  String get newToApp => 'కిరాణా కోనుకు కొత్తవా?';

  @override
  String get registerAsPartner => 'భాగస్వామిగా నమోదు చేసుకోండి';

  @override
  String get otpInfo => 'మీ ఫోన్ నంబర్‌ను ధృవీకరించడానికి మేము వన్-టైమ్ పాస్‌వర్డ్ (OTP) పంపుతాము.';

  @override
  String get personalDetailsTitle => 'వ్యక్తిగత వివరాలు';

  @override
  String get personalDetailsHeader => 'మిమ్మల్ని తెలుసుకుందాం';

  @override
  String get personalDetailsSubHeader => 'దయచేసి మీ వ్యక్తిగత మరియు వ్యాపార వివరాలను అందించండి';

  @override
  String get ownerNameLabel => 'యజమాని పూర్తి పేరు';

  @override
  String get ownerNameHint => 'మీ పూర్తి పేరును నమోదు చేయండి';

  @override
  String get shopNameLabel => 'షాపు / హబ్ పేరు';

  @override
  String get shopNameHint => 'ఉదా. రాజు ట్రేడర్స్';

  @override
  String get businessLocationTitle => 'వ్యాపార ప్రదేశం';

  @override
  String get locationDetected => 'స్థానం గుర్తించబడింది';

  @override
  String get locationNotDetected => 'స్థానం గుర్తించబడలేదు';

  @override
  String get updateLocation => 'స్థానాన్ని నవీకరించండి';

  @override
  String get detectLocation => 'నా స్థానాన్ని గుర్తించండి';

  @override
  String get continueToDocs => 'వ్యాపార పత్రాలకు కొనసాగండి';

  @override
  String get locationPermissionBlocked => 'స్థాన అనుమతి నిరోధించబడింది';

  @override
  String get locationPermissionDeniedMessage => 'స్థాన అనుమతి శాశ్వతంగా తిరస్కరించబడింది. కొనసాగడానికి దయచేసి యాప్ సెట్టింగ్‌ల నుండి దాన్ని ప్రారంభించండి.';

  @override
  String get openSettings => 'సెట్టింగ్‌లను తెరవండి';

  @override
  String get cancel => 'రద్దు చేయండి';

  @override
  String get locationRequired => 'దయచేసి ముందుగా మీ స్థానాన్ని గుర్తించండి';

  @override
  String get locationSuccess => 'స్థానం విజయవంతంగా గుర్తించబడింది!';

  @override
  String get settings => 'సెట్టింగ్‌లు';

  @override
  String get businessDocsTitle => 'వ్యాపార పత్రాలు';

  @override
  String get businessDocsHeader => 'వ్యాపార ధృవీకరణ';

  @override
  String get businessDocsSubHeader => 'KYB ధృవీకరణ కోసం దయచేసి మీ వ్యాపార పత్రాలను అందించండి';

  @override
  String get gstinSection => 'GSTIN సర్టిఫికేట్';

  @override
  String get gstinLabel => 'GSTIN నంబర్';

  @override
  String get gstinHint => 'ఉదా. 27AAPFU0939F1ZV';

  @override
  String get uploadGstin => 'GSTIN సర్టిఫికేట్‌ను అప్‌లోడ్ చేయండి';

  @override
  String get uploadGstinHint => 'GSTIN సర్టిఫికేట్ యొక్క స్పష్టమైన చిత్రం లేదా PDFని అప్‌లోడ్ చేయండి';

  @override
  String get fssaiSection => 'FSSAI లైసెన్స్';

  @override
  String get fssaiLabel => 'FSSAI లైసెన్స్ నంబర్';

  @override
  String get fssaiHint => '14-అంకెల FSSAI నంబర్';

  @override
  String get uploadFssai => 'FSSAI లైసెన్స్‌ను అప్‌లోడ్ చేయండి';

  @override
  String get uploadFssaiHint => 'FSSAI లైసెన్స్ యొక్క స్పష్టమైన చిత్రం లేదా PDFని అప్‌లోడ్ చేయండి';

  @override
  String get panSection => 'PAN కార్డ్';

  @override
  String get panLabel => 'PAN కార్డ్ నంబర్';

  @override
  String get panHint => 'ఉదా. ABCDE1234F';

  @override
  String get uploadPan => 'PAN కార్డ్‌ను అప్‌లోడ్ చేయండి';

  @override
  String get uploadPanHint => 'PAN కార్డ్ యొక్క స్పష్టమైన చిత్రం లేదా PDFని అప్‌లోడ్ చేయండి';

  @override
  String get shopLicenseSection => 'షాపు లైసెన్స్';

  @override
  String get shopLicenseLabel => 'షాపు లైసెన్స్ నంబర్';

  @override
  String get shopLicenseHint => 'మీ షాపు లైసెన్స్ నంబర్‌ను నమోదు చేయండి';

  @override
  String get uploadShopLicense => 'షాపు లైసెన్స్‌ను అప్‌లోడ్ చేయండి';

  @override
  String get uploadShopLicenseHint => 'షాపు లైసెన్స్ యొక్క స్పష్టమైన చిత్రం లేదా PDFని అప్‌లోడ్ చేయండి';

  @override
  String get shopImageSection => 'షాపు ఫోటో';

  @override
  String get uploadShopImage => 'షాపు ఫోటోను అప్‌లోడ్ చేయండి';

  @override
  String get uploadShopImageHint => 'మీ షాపు యొక్క స్పష్టమైన ఫోటోను అప్‌లోడ్ చేయండి';

  @override
  String get bankDetailsTitle => 'బ్యాంక్ వివరాలు';

  @override
  String get financialSettlementHeader => 'ఆర్థిక పరిష్కారం';

  @override
  String get financialSettlementSubHeader => 'చెల్లింపులు స్వీకరించడానికి బ్యాంక్ వివరాలను అందించండి';

  @override
  String get accountHolderLabel => 'ఖాతాదారుని పేరు';

  @override
  String get accountHolderHint => 'బ్యాంక్ ఖాతా ప్రకారం పేరు';

  @override
  String get accountNumberLabel => 'బ్యాంక్ ఖాతా సంఖ్య';

  @override
  String get accountNumberHint => 'ఖాతా సంఖ్యను నమోదు చేయండి';

  @override
  String get confirmAccountLabel => 'ఖాతా సంఖ్యను నిర్ధారించండి';

  @override
  String get confirmAccountHint => 'ఖాతా సంఖ్యను మళ్లీ నమోదు చేయండి';

  @override
  String get ifscLabel => 'IFSC కోడ్';

  @override
  String get ifscHint => 'ఉదా. SBIN0001234';

  @override
  String get branchLabel => 'బ్రాంచ్ పేరు (ఐచ్ఛికం)';

  @override
  String get branchHint => 'అందుబాటులో ఉంటే స్వయంచాలకంగా నింపబడుతుంది';

  @override
  String get cancelledChequeSection => 'రద్దు చేసిన చెక్';

  @override
  String get uploadCheque => 'రద్దు చేసిన చెక్ / పాస్‌బుక్‌ని అప్‌లోడ్ చేయండి';

  @override
  String get uploadChequeHint => 'ఖాతా వివరాలను చూపిస్తున్న స్పష్టమైన చిత్రాన్ని అప్‌లోడ్ చేయండి';

  @override
  String get bankInfoNote => 'మీ బ్యాంక్ వివరాలు చెల్లింపులను స్వీకరించడానికి ఉపయోగించబడతాయి. దయచేసి అన్ని సమాచారం ఖచ్చితంగా ఉందని నిర్ధారించుకోండి.';

  @override
  String get backButton => 'వెనుకకు';

  @override
  String uploadSuccess(String documentType) {
    return '$documentType పత్రం విజయవంతంగా అప్‌లోడ్ చేయబడింది';
  }

  @override
  String uploadFailed(String error) {
    return 'అప్‌లోడ్ విఫలమైంది: $error';
  }

  @override
  String get reviewSubmitTitle => 'సమీక్ష & సమర్పించండి';

  @override
  String get termsPoliciesHeader => 'నిబంధనలు & విధానాలు';

  @override
  String get termsPoliciesSubHeader => 'సమర్పించే ముందు దయచేసి మా నిబంధనలను సమీక్షించి, అంగీకరించండి';

  @override
  String get commissionPolicy => 'కమిషన్ విధానం';

  @override
  String get agreeToTerms => 'నేను సేవా నిబంధనలు మరియు కమిషన్ విధానాన్ని చదివాను మరియు అంగీకరిస్తున్నాను';

  @override
  String get submitApplication => 'దరఖాస్తును సమర్పించండి';

  @override
  String get verificationPendingTitle => 'ధృవీకరణ ప్రక్రియ';

  @override
  String get verificationPendingMessage => 'మీ దరఖాస్తు 24-48 గంటల్లో సమీక్షించబడుతుంది. ఆమోదించబడిన తర్వాత మీకు నోటిఫికేషన్ వస్తుంది.';

  @override
  String submissionFailed(String error) {
    return 'సమర్పణ విఫలమైంది: $error';
  }

  @override
  String get registrationSuccessTitle => 'దరఖాస్తు సమర్పించబడింది!';

  @override
  String get registrationSuccessMessage => 'మీ నమోదు దరఖాస్తును సమర్పించినందుకు ధన్యవాదాలు. మా బృందం మీ పత్రాలను సమీక్షించి 24-48 గంటల్లో మిమ్మల్ని సంప్రదిస్తుంది.';

  @override
  String get backToLogin => 'లాగిన్‌కి తిరిగి వెళ్లు';

  @override
  String get applicationSubmitted => 'దరఖాస్తు సమర్పించబడింది!';

  @override
  String get applicationId => 'దరఖాస్తు ID';

  @override
  String get saveIdInfo => 'భవిష్యత్ సూచన కోసం ఈ IDని సేవ్ చేయండి';

  @override
  String get verificationInProgress => 'ధృవీకరణ పురోగతిలో ఉంది';

  @override
  String get verificationInProgressSub => 'మీ పత్రాలు సమీక్షించబడుతున్నాయి';

  @override
  String get notifyYou => 'మేము మీకు తెలియజేస్తాము';

  @override
  String get notifyYouSub => 'మీరు ఇమెయిల్/SMS అప్‌డేట్‌ని అందుకుంటారు';

  @override
  String get needHelp => 'సహాయం కావాలా?';

  @override
  String get contactSupport => 'support@kiranakonu.com ని సంప్రదించండి';

  @override
  String get done => 'పూర్తయింది';

  @override
  String get approvalPendingTitle => 'ఆమోదం పెండింగ్‌లో ఉంది';

  @override
  String get approvalPendingMessage => 'మీ దరఖాస్తు ప్రస్తుతం సమీక్షలో ఉంది. ఆమోదించబడిన తర్వాత మీకు తెలియజేయబడుతుంది. దీనికి సాధారణంగా 24-48 గంటలు పడుతుంది.';

  @override
  String get applicationRejectedTitle => 'దరఖాస్తు తిరస్కరించబడింది';

  @override
  String get applicationRejectedMessage => 'దురదృష్టవశాత్తు, మీ దరఖాస్తు తిరస్కరించబడింది. దయచేసి మరింత సమాచారం కోసం మద్దతును సంప్రదించండి.';

  @override
  String get ok => 'సరే';

  @override
  String get nameRequired => 'పేరు అవసరం';

  @override
  String get nameMinLength => 'పేరు కనీసం 2 అక్షరాలు ఉండాలి';

  @override
  String get nameMaxLength => 'పేరు 50 అక్షరాలకు మించకూడదు';

  @override
  String get nameAlpha => 'పేరులో అక్షరాలు మరియు ఖాళీలు మాత్రమే ఉండాలి';

  @override
  String get mobileRequired => 'మొబైల్ నంబర్ అవసరం';

  @override
  String get mobileInvalid => 'దయచేసి సరైన 10-అంకెల మొబైల్ నంబర్‌ను నమోదు చేయండి';

  @override
  String get gstinRequired => 'GSTIN అవసరం';

  @override
  String get gstinInvalid => 'దయచేసి సరైన GSTIN నమోదు చేయండి';

  @override
  String get fssaiRequired => 'FSSAI లైసెన్స్ నంబర్ అవసరం';

  @override
  String get fssaiInvalid => 'FSSAI లైసెన్స్ 14 అంకెలు ఉండాలి';

  @override
  String get panRequired => 'PAN కార్డ్ అవసరం';

  @override
  String get panInvalid => 'దయచేసి సరైన PAN నమోదు చేయండి';

  @override
  String get shopLicenseRequired => 'షాపు లైసెన్స్ నంబర్ అవసరం';

  @override
  String get shopImageRequired => 'షాపు ఫోటో అవసరం';

  @override
  String get accountRequired => 'ఖాతా సంఖ్య అవసరం';

  @override
  String get accountInvalid => 'ఖాతా సంఖ్య 9-18 అంకెలు ఉండాలి';

  @override
  String get ifscRequired => 'IFSC కోడ్ అవసరం';

  @override
  String get ifscInvalid => 'దయచేసి సరైన IFSC కోడ్ నమోదు చేయండి';

  @override
  String get shopRequired => 'షాపు/హబ్ పేరు అవసరం';

  @override
  String get shopMinLength => 'షాపు పేరు కనీసం 3 అక్షరాలు ఉండాలి';

  @override
  String get shopMaxLength => 'షాపు పేరు 100 అక్షరాలకు మించకూడదు';

  @override
  String get otpRequired => 'OTP అవసరం';

  @override
  String get otpInvalid => 'OTP 6 అంకెలు ఉండాలి';

  @override
  String get confirmAccountRequired => 'దయచేసి ఖాతా సంఖ్యను నిర్ధారించండి';

  @override
  String get accountMismatch => 'ఖాతా సంఖ్యలు సరిపోలడం లేదు';

  @override
  String get mobileAuthError => 'మొబైల్ నంబర్‌ని ధృవీకరించడం సాధ్యం కాలేదు. దయచేసి మళ్లీ లాగిన్ చేయండి.';

  @override
  String mobileDoesNotMatch(String authMobile) {
    return 'మొబైల్ నంబర్ మీ లాగిన్ నంబర్‌తో సరిపోలాలి: $authMobile';
  }

  @override
  String mobileHelperMatch(String authMobile) {
    return 'మీ లాగిన్ నంబర్‌తో సరిపోలాలి: $authMobile';
  }

  @override
  String get mobileHelperDefault => 'మీ నమోదైన మొబైల్ నంబర్‌ను నమోదు చేయండి';
}
