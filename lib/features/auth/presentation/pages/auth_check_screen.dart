import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../routes/auth_routes.dart';

/// Auth Check Screen
/// This screen is shown when the app starts
/// It checks the authentication status and navigates to the appropriate screen
class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({super.key});

  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  @override
  void initState() {
    super.initState();
    // Dispatch check auth status event when screen loads
    context.read<AuthBloc>().add(const CheckAuthStatusEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // Navigate based on authentication state
        if (state is Unauthenticated) {
          // User not logged in - go to login
          Navigator.of(context).pushNamedAndRemoveUntil(AuthRoutes.login, (route) => false);
        } else if (state is AuthenticatedPendingVerification) {
          // User logged in, registration pending approval
          Navigator.of(context).pushNamedAndRemoveUntil('/pending-verification', (route) => false);
        } else if (state is AuthenticatedApproved) {
          // User logged in and approved - go to home
          Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
        } else if (state is AuthenticatedNewUser) {
          // User logged in but needs to complete registration
          Navigator.of(context).pushNamedAndRemoveUntil('/registration', (route) => false);
        } else if (state is Authenticated) {
          // Legacy state - go to home
          Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
        } else if (state is AuthError) {
          // If there's an error, go to login screen
          Navigator.of(context).pushNamedAndRemoveUntil(AuthRoutes.login, (route) => false);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo
              Image.asset('assets/images/logo/app_logo.png', width: 120, height: 120),
              const SizedBox(height: 32),
              // Loading indicator
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Kirana Konu',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Loading...', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600)),
            ],
          ),
        ),
      ),
    );
  }
}
