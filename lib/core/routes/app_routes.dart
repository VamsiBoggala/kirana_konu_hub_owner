import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/otp_verification_screen.dart';
import '../../features/auth/presentation/pages/auth_check_screen.dart';
import '../../features/auth/presentation/pages/pending_verification_screen.dart';
import '../../features/auth/presentation/routes/auth_routes.dart';
import '../../features/registration/presentation/pages/personal_details_screen.dart';
import '../../features/registration/presentation/pages/business_documents_screen.dart';
import '../../features/registration/presentation/pages/bank_details_screen.dart';
import '../../features/registration/presentation/pages/terms_and_submit_screen.dart';
import '../../features/registration/presentation/pages/registration_success_screen.dart';
import '../../features/registration/presentation/routes/registration_routes.dart';
import 'route_constants.dart';

/// App Routes Configuration
/// Centralized route management for the entire application
class AppRoutes {
  // Private constructor to prevent instantiation
  AppRoutes._();

  /// Generate routes based on route settings
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Root/Home (placeholder for now)
      case RouteConstants.home:
      case '/home':
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text('Home Screen - To be implemented'))),
          settings: settings,
        );

      // Pending Verification Screen
      case '/pending-verification':
        return MaterialPageRoute(builder: (_) => const PendingVerificationScreen(), settings: settings);

      // Registration Entry Point (Personal Details)
      case '/registration':
        return MaterialPageRoute(
          builder: (_) => PersonalDetailsScreen(key: UniqueKey()),
          settings: settings,
        );

      // Auth Routes
      case AuthRoutes.authCheck:
        return MaterialPageRoute(builder: (_) => const AuthCheckScreen(), settings: settings);

      case AuthRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen(), settings: settings);

      case AuthRoutes.otpVerification:
        final args = settings.arguments as OtpVerificationArgs;
        return MaterialPageRoute(
          builder: (_) => OtpVerificationScreen(args: args),
          settings: settings,
        );

      // Registration Flow Routes
      case RegistrationRoutes.personalDetails:
        return MaterialPageRoute(
          builder: (_) => PersonalDetailsScreen(key: UniqueKey()),
          settings: settings,
        );

      case RegistrationRoutes.businessDocuments:
        return MaterialPageRoute(builder: (_) => const BusinessDocumentsScreen(), settings: settings);

      case RegistrationRoutes.bankDetails:
        return MaterialPageRoute(builder: (_) => const BankDetailsScreen(), settings: settings);

      case RegistrationRoutes.termsAndSubmit:
        return MaterialPageRoute(builder: (_) => const TermsAndSubmitScreen(), settings: settings);

      case RegistrationRoutes.success:
        // Get application ID from BLoC state, not from arguments
        // The RegistrationBloc will hold this data
        return MaterialPageRoute(builder: (_) => const RegistrationSuccessScreen(), settings: settings);

      // Unknown route
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
          settings: settings,
        );
    }
  }

  /// Get initial route based on app state
  /// Starts with auth check screen which determines where to navigate
  static String getInitialRoute() {
    // Start with auth check screen for session management
    return AuthRoutes.authCheck;
  }

  /// Get all routes as a map (alternative approach for simple apps)
  /// Not used currently, but available if needed
  static Map<String, WidgetBuilder> get routes => {
    RouteConstants.home: (_) => const Scaffold(body: Center(child: Text('Home Screen'))),
    AuthRoutes.login: (_) => const LoginScreen(),
    RegistrationRoutes.personalDetails: (_) => const PersonalDetailsScreen(),
    RegistrationRoutes.businessDocuments: (_) => const BusinessDocumentsScreen(),
    RegistrationRoutes.bankDetails: (_) => const BankDetailsScreen(),
    RegistrationRoutes.termsAndSubmit: (_) => const TermsAndSubmitScreen(),
    RegistrationRoutes.success: (_) => const RegistrationSuccessScreen(),
  };
}
