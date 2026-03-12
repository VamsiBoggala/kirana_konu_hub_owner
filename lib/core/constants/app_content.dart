/// App Content - Terms, Policies, and Static Content
/// Contains all static text content used throughout the app
class AppContent {
  // Private constructor to prevent instantiation
  AppContent._();

  /// Terms of Service Content
  static const String termsOfService = '''
1. ACCEPTANCE OF TERMS
By using Kirana Konu platform, you agree to these terms and conditions.

2. BUSINESS REQUIREMENTS
- You must have valid GSTIN and FSSAI licenses
- All business information must be accurate and current
- You are responsible for maintaining product quality

3. PLATFORM USAGE
- You will use the platform only for lawful business purposes
- You will not engage in any fraudulent activities
- You will maintain accurate inventory information

4. ACCOUNT SECURITY
- Keep your account credentials secure
- Notify us immediately of any unauthorized access
- You are responsible for all activities under your account

5. INTELLECTUAL PROPERTY
- All platform content is owned by Kirana Konu
- You may not copy or redistribute platform materials

6. TERMINATION
We reserve the right to suspend or terminate accounts that violate these terms.

7. DISPUTE RESOLUTION
Any disputes will be resolved through arbitration in accordance with Indian law.
''';

  /// Commission Policy Content
  static const String commissionPolicy = '''
1. COMMISSION STRUCTURE
- Platform commission: 5% per successful order
- Payment processing fee: 2% per transaction
- No hidden charges or setup fees

2. PAYMENT TERMS
- Payments are processed weekly
- Settlements are made to your registered bank account
- Minimum payout threshold: ₹500

3. PRICING CONTROL
- You set your own product prices
- Commission is calculated on your sale price
- You can offer discounts at your discretion

4. REFUNDS & CANCELLATIONS
- Refunds are deducted from your next settlement
- Cancellation fees may apply for order cancellations
- Commission is not charged on cancelled orders

5. INVOICING
- Tax invoices will be generated for all transactions
- You are responsible for GST compliance
- Monthly statements available in your dashboard

6. POLICY CHANGES
We reserve the right to modify commission rates with 30 days notice.
''';

  /// Privacy Policy Content
  static const String privacyPolicy = '''
1. INFORMATION COLLECTION
We collect business information necessary for providing our services.

2. DATA USAGE
Your information is used solely for platform operations and improvement.

3. DATA SECURITY
We implement industry-standard security measures to protect your data.

4. THIRD-PARTY SHARING
We do not sell or share your data with third parties without consent.

5. YOUR RIGHTS
You have the right to access, modify, or delete your personal information.
''';

  /// Support Contact Information
  static const String supportEmail = 'support@kiranakonu.com';
  static const String supportPhone = '+91 1800-123-4567';

  /// App Information
  static const String appName = 'Kirana Konu';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Your Trusted B2B Partner';

  /// Verification Messages
  static const String verificationPendingTitle = 'Verification Process';
  static const String verificationPendingMessage =
      'Your application will be reviewed within 24-48 hours. You will receive a notification once approved.';

  /// Success Messages
  static const String registrationSuccessTitle = 'Application Submitted!';
  static const String registrationSuccessMessage =
      'Thank you for submitting your registration application. Our team will review your documents and get back to you within 24-48 hours.';

  /// Error Messages
  static const String termsNotAcceptedError = 'Please accept the terms and conditions';
  static const String networkError = 'Network error. Please check your connection and try again.';
  static const String unknownError = 'An unexpected error occurred. Please try again.';
}
