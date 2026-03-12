/// Registration Feature Route Constants
/// Contains all route names for the registration flow
class RegistrationRoutes {
  // Private constructor to prevent instantiation
  RegistrationRoutes._();

  // Base route
  static const String base = '/registration';

  // Registration Flow Screens
  static const String personalDetails = '/registration/personal-details';
  static const String businessDocuments = '/registration/business-documents';
  static const String bankDetails = '/registration/bank-details';
  static const String termsAndSubmit = '/registration/terms-and-submit';
  static const String success = '/registration/success';

  // Helper method to get all registration routes as a list
  static List<String> get allRoutes => [personalDetails, businessDocuments, bankDetails, termsAndSubmit, success];
}
