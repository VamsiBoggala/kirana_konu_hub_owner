/// App Image Asset Constants
/// Centralized management of all image assets used in the application
class AppImages {
  // Private constructor to prevent instantiation
  AppImages._();

  /// Base paths
  static const String _basePath = 'assets/images';
  static const String _logoPath = '$_basePath/logo';

  /// Logo Assets
  static const String appLogo = '$_logoPath/app_logo.png';

  /// Future Image Assets
  // Add more images here as needed, for example:
  // static const String onboardingImage1 = '$_basePath/onboarding_1.png';
  // static const String placeholderImage = '$_basePath/placeholder.png';
  // static const String emptyStateIllustration = '$_basePath/empty_state.png';
}
