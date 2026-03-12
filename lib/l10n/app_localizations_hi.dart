// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get loginTitle => 'लॉगिन';

  @override
  String get loginSubtitle => 'जारी रखने के लिए अपना मोबाइल नंबर दर्ज करें';

  @override
  String get mobileNumberLabel => 'मोबाइल नंबर';

  @override
  String get mobileNumberRequired => 'मोबाइल नंबर आवश्यक है';

  @override
  String get mobileNumberInvalid => 'कृपया एक मान्य मोबाइल नंबर दर्ज करें';

  @override
  String get termsAgreement => 'जारी रखकर, आप हमारी सहमति देते हैं';

  @override
  String get termsOfService => 'सेवा की शर्तें';

  @override
  String get privacyPolicy => 'गोपनीता नीति';

  @override
  String get and => 'और';

  @override
  String get verificationTitle => 'सत्यापन';

  @override
  String get enterVerificationCode => 'सत्यापन कोड दर्ज करें';

  @override
  String verificationCodeSentTo(String phoneNumber) {
    return 'हमने $phoneNumber पर 6 अंकों का कोड भेजा है';
  }

  @override
  String get securityNote => 'इस कोड को किसी के साथ साझा न करें।';

  @override
  String get verifyButton => 'सत्यापित करें';

  @override
  String get resendCode => 'कोड प्राप्त नहीं हुआ? पुनः भेजें';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get welcomeBack => 'स्वागत हे!';

  @override
  String get enterPhoneToContinue => 'जारी रखने के लिए अपना फ़ोन नंबर दर्ज करें';

  @override
  String get phoneHint => '10 अंकों का मोबाइल नंबर दर्ज करें';

  @override
  String get continueButton => 'जारी रखना';

  @override
  String get newToApp => 'किराना कोनू में नए हैं?';

  @override
  String get registerAsPartner => 'पार्टनर के रूप में रजिस्टर करें';

  @override
  String get otpInfo => 'हम आपके फ़ोन नंबर को सत्यापित करने के लिए एक वन-टाइम पासवर्ड (OTP) भेजेंगे।';

  @override
  String get personalDetailsTitle => 'व्यक्तिगत विवरण';

  @override
  String get personalDetailsHeader => 'आइए आपको जानते हैं';

  @override
  String get personalDetailsSubHeader => 'कृपया अपना व्यक्तिगत और व्यावसायिक विवरण प्रदान करें';

  @override
  String get ownerNameLabel => 'मालिक का पूरा नाम';

  @override
  String get ownerNameHint => 'अपना पूरा नाम दर्ज करें';

  @override
  String get shopNameLabel => 'दुकान / हब का नाम';

  @override
  String get shopNameHint => 'उदा. राजू ट्रेडर्स';

  @override
  String get businessLocationTitle => 'व्यवसाय का स्थान';

  @override
  String get locationDetected => 'स्थान का पता चला';

  @override
  String get locationNotDetected => 'स्थान का पता नहीं चला';

  @override
  String get updateLocation => 'स्थान अपडेट करें';

  @override
  String get detectLocation => 'मेरे स्थान का पता लगाएं';

  @override
  String get continueToDocs => 'व्यावसायिक दस्तावेजों पर जारी रखें';

  @override
  String get locationPermissionBlocked => 'स्थान अनुमति अवरुद्ध';

  @override
  String get locationPermissionDeniedMessage => 'स्थान अनुमति स्थायी रूप से अस्वीकार कर दी गई है। जारी रखने के लिए कृपया ऐप सेटिंग्स से इसे सक्षम करें।';

  @override
  String get openSettings => 'सेटिंग्स खोलें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get locationRequired => 'कृपया पहले अपने स्थान का पता लगाएं';

  @override
  String get locationSuccess => 'स्थान का सफलतापूर्वक पता चला!';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get businessDocsTitle => 'व्यावसायिक दस्तावेज';

  @override
  String get businessDocsHeader => 'व्यवसाय सत्यापन';

  @override
  String get businessDocsSubHeader => 'KYB सत्यापन के लिए कृपया अपने व्यावसायिक दस्तावेज प्रदान करें';

  @override
  String get gstinSection => 'GSTIN प्रमाणपत्र';

  @override
  String get gstinLabel => 'GSTIN नंबर';

  @override
  String get gstinHint => 'उदा. 27AAPFU0939F1ZV';

  @override
  String get uploadGstin => 'GSTIN प्रमाणपत्र अपलोड करें';

  @override
  String get uploadGstinHint => 'GSTIN प्रमाणपत्र की स्पष्ट छवि या PDF अपलोड करें';

  @override
  String get fssaiSection => 'FSSAI लाइसेंस';

  @override
  String get fssaiLabel => 'FSSAI लाइसेंस नंबर';

  @override
  String get fssaiHint => '14-अंकीय FSSAI नंबर';

  @override
  String get uploadFssai => 'FSSAI लाइसेंस अपलोड करें';

  @override
  String get uploadFssaiHint => 'FSSAI लाइसेंस की स्पष्ट छवि या PDF अपलोड करें';

  @override
  String get panSection => 'PAN कार्ड';

  @override
  String get panLabel => 'PAN कार्ड नंबर';

  @override
  String get panHint => 'उदा. ABCDE1234F';

  @override
  String get uploadPan => 'PAN कार्ड अपलोड करें';

  @override
  String get uploadPanHint => 'PAN कार्ड की स्पष्ट छवि या PDF अपलोड करें';

  @override
  String get shopLicenseSection => 'दुकान लाइसेंस';

  @override
  String get shopLicenseLabel => 'दुकान लाइसेंस नंबर';

  @override
  String get shopLicenseHint => 'अपना दुकान लाइसेंस नंबर दर्ज करें';

  @override
  String get uploadShopLicense => 'दुकान लाइसेंस अपलोड करें';

  @override
  String get uploadShopLicenseHint => 'दुकान लाइसेंस की स्पष्ट छवि या PDF अपलोड करें';

  @override
  String get shopImageSection => 'दुकान की फोटो';

  @override
  String get uploadShopImage => 'दुकान की फोटो अपलोड करें';

  @override
  String get uploadShopImageHint => 'अपनी दुकान की स्पष्ट फोटो अपलोड करें';

  @override
  String get bankDetailsTitle => 'बैंक विवरण';

  @override
  String get financialSettlementHeader => 'वित्तीय निपटान';

  @override
  String get financialSettlementSubHeader => 'भुगतान प्राप्त करने के लिए बैंक विवरण प्रदान करें';

  @override
  String get accountHolderLabel => 'खाता धारक का नाम';

  @override
  String get accountHolderHint => 'बैंक खाते के अनुसार नाम';

  @override
  String get accountNumberLabel => 'बैंक खाता संख्या';

  @override
  String get accountNumberHint => 'खाता संख्या दर्ज करें';

  @override
  String get confirmAccountLabel => 'खाता संख्या की पुष्टि करें';

  @override
  String get confirmAccountHint => 'खाता संख्या पुनः दर्ज करें';

  @override
  String get ifscLabel => 'IFSC कोड';

  @override
  String get ifscHint => 'उदा. SBIN0001234';

  @override
  String get branchLabel => 'शाखा का नाम (वैकल्पिक)';

  @override
  String get branchHint => 'यदि उपलब्ध हो तो स्वतः भर जाएगा';

  @override
  String get cancelledChequeSection => 'रद्द चेक';

  @override
  String get uploadCheque => 'रद्द चेक / पासबुक अपलोड करें';

  @override
  String get uploadChequeHint => 'खाता विवरण दिखाते हुए स्पष्ट छवि अपलोड करें';

  @override
  String get bankInfoNote => 'आपके बैंक विवरण का उपयोग भुगतान प्राप्त करने के लिए किया जाएगा। कृपया सुनिश्चित करें कि सभी जानकारी सटीक है।';

  @override
  String get backButton => 'वापस';

  @override
  String uploadSuccess(String documentType) {
    return '$documentType दस्तावेज सफलतापूर्वक अपलोड किया गया';
  }

  @override
  String uploadFailed(String error) {
    return 'अपलोड विफल: $error';
  }

  @override
  String get reviewSubmitTitle => 'समीक्षा और सबमिट करें';

  @override
  String get termsPoliciesHeader => 'शर्तें और नीतियां';

  @override
  String get termsPoliciesSubHeader => 'सबमिट करने से पहले कृपया हमारी शर्तों की समीक्षा करें और स्वीकार करें';

  @override
  String get commissionPolicy => 'कमीशन नीति';

  @override
  String get agreeToTerms => 'मैने सेवा की शर्तें और कमीशन नीति को पढ़ा और स्वीकार किया है';

  @override
  String get submitApplication => 'आवेदन सबमिट करें';

  @override
  String get verificationPendingTitle => 'सत्यापन प्रक्रिया';

  @override
  String get verificationPendingMessage => 'आपके आवेदन की 24-48 घंटों के भीतर समीक्षा की जाएगी। स्वीकृत होने पर आपको एक सूचना प्राप्त होगी।';

  @override
  String submissionFailed(String error) {
    return 'सबमिशन विफल: $error';
  }

  @override
  String get registrationSuccessTitle => 'आवेदन सबमिट किया गया!';

  @override
  String get registrationSuccessMessage => 'अपना पंजीकरण आवेदन सबमिट करने के लिए धन्यवाद। हमारी टीम आपके दस्तावेजों की समीक्षा करेगी और 24-48 घंटों के भीतर आपसे संपर्क करेगी।';

  @override
  String get backToLogin => 'लॉगिन पर वापस जाएं';

  @override
  String get applicationSubmitted => 'आवेदन सबमिट किया गया!';

  @override
  String get applicationId => 'आवेदन ID';

  @override
  String get saveIdInfo => 'भविष्य के संदर्भ के लिए इस ID को सहेजें';

  @override
  String get verificationInProgress => 'सत्यापन प्रगति पर है';

  @override
  String get verificationInProgressSub => 'आपके दस्तावेजों की समीक्षा की जा रही है';

  @override
  String get notifyYou => 'हम आपको सूचित करेंगे';

  @override
  String get notifyYouSub => 'आपको एक ईमेल/SMS अपडेट प्राप्त होगा';

  @override
  String get needHelp => 'मदद चाहिए?';

  @override
  String get contactSupport => 'support@kiranakonu.com पर संपर्क करें';

  @override
  String get done => 'पूर्ण';

  @override
  String get approvalPendingTitle => 'अनुमोदन लंबित';

  @override
  String get approvalPendingMessage => 'आपका आवेदन वर्तमान में समीक्षाधीन है। स्वीकृत होने पर आपको सूचित किया जाएगा। इसमें आमतौर पर 24-48 घंटे लगते हैं।';

  @override
  String get applicationRejectedTitle => 'आवेदन अस्वीकृत';

  @override
  String get applicationRejectedMessage => 'दुर्भाग्य से, आपका आवेदन अस्वीकार कर दिया गया था। अधिक जानकारी के लिए कृपया समर्थन से संपर्क करें।';

  @override
  String get ok => 'ठीक है';

  @override
  String get nameRequired => 'नाम आवश्यक है';

  @override
  String get nameMinLength => 'नाम कम से कम 2 अक्षर का होना चाहिए';

  @override
  String get nameMaxLength => 'नाम 50 अक्षरों से अधिक नहीं होना चाहिए';

  @override
  String get nameAlpha => 'नाम में केवल अक्षर और स्थान हो सकते हैं';

  @override
  String get mobileRequired => 'मोबाइल नंबर आवश्यक है';

  @override
  String get mobileInvalid => 'कृपया एक मान्य 10-अंकीय मोबाइल नंबर दर्ज करें';

  @override
  String get gstinRequired => 'GSTIN आवश्यक है';

  @override
  String get gstinInvalid => 'कृपया एक मान्य GSTIN दर्ज करें';

  @override
  String get fssaiRequired => 'FSSAI लाइसेंस नंबर आवश्यक है';

  @override
  String get fssaiInvalid => 'FSSAI लाइसेंस 14 अंकों का होना चाहिए';

  @override
  String get panRequired => 'PAN कार्ड आवश्यक है';

  @override
  String get panInvalid => 'कृपया एक मान्य PAN दर्ज करें';

  @override
  String get shopLicenseRequired => 'दुकान लाइसेंस नंबर आवश्यक है';

  @override
  String get shopImageRequired => 'दुकान की फोटो आवश्यक है';

  @override
  String get accountRequired => 'खाता संख्या आवश्यक है';

  @override
  String get accountInvalid => 'खाता संख्या 9-18 अंकों की होनी चाहिए';

  @override
  String get ifscRequired => 'IFSC कोड आवश्यक है';

  @override
  String get ifscInvalid => 'कृपया एक मान्य IFSC कोड दर्ज करें';

  @override
  String get shopRequired => 'दुकान/हब का नाम आवश्यक है';

  @override
  String get shopMinLength => 'दुकान का नाम कम से कम 3 अक्षर का होना चाहिए';

  @override
  String get shopMaxLength => 'दुकान का नाम 100 अक्षरों से अधिक नहीं होना चाहिए';

  @override
  String get otpRequired => 'OTP आवश्यक है';

  @override
  String get otpInvalid => 'OTP 6 अंकों का होना चाहिए';

  @override
  String get confirmAccountRequired => 'कृपया खाता संख्या की पुष्टि करें';

  @override
  String get accountMismatch => 'खाता संख्या मेल नहीं खाती';

  @override
  String get mobileAuthError => 'मोबाइल नंबर सत्यापित करने में असमर्थ। कृपया फिर से लॉगिन करें।';

  @override
  String mobileDoesNotMatch(String authMobile) {
    return 'मोबाइल नंबर आपके लॉगिन नंबर से मेल खाना चाहिए: $authMobile';
  }

  @override
  String mobileHelperMatch(String authMobile) {
    return 'आपके लॉगिन नंबर से मेल खाना चाहिए: $authMobile';
  }

  @override
  String get mobileHelperDefault => 'अपना पंजीकृत मोबाइल नंबर दर्ज करें';
}
