/// Authentication Route Constants
class AuthRoutes {
  // Private constructor to prevent instantiation
  AuthRoutes._();

  /// Base route for auth feature
  static const String base = '/auth';

  /// Auth check/splash screen - checks if user is logged in
  static const String authCheck = '/auth/check';

  /// Login screen
  static const String login = '/auth/login';

  /// Signup/Register screen
  static const String signup = '/auth/signup';

  /// Forgot password screen
  static const String forgotPassword = '/auth/forgot-password';

  /// OTP verification screen
  static const String otpVerification = '/auth/otp-verification';
}
