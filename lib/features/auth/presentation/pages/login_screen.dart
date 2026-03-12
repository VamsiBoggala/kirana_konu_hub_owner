import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/constants/app_content.dart';
import '../../../../core/constants/app_images.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../pages/otp_verification_screen.dart';
import '../routes/auth_routes.dart';
import 'package:hub_owner/l10n/app_localizations.dart';
import '../../../../core/localization/bloc/language_cubit.dart';

/// Login Screen
/// Phone number based authentication
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Widget _buildLanguageSelector(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: locale.languageCode,
                icon: const Icon(Icons.language, size: 20),
                isDense: true,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    context.read<LanguageCubit>().changeLanguage(newValue);
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text('English', style: TextStyle(fontSize: 14)),
                  ),
                  DropdownMenuItem(
                    value: 'te',
                    child: Text('తెలుగు', style: TextStyle(fontSize: 14)),
                  ),
                  DropdownMenuItem(
                    value: 'hi',
                    child: Text('हिंदी', style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // Handle OTP sent
          if (state is OtpSent) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('OTP sent successfully!'), backgroundColor: Colors.green));

            // Navigate to OTP Verification Screen
            Navigator.pushNamed(
              context,
              AuthRoutes.otpVerification,
              arguments: OtpVerificationArgs(
                phoneNumber: '+91${_phoneController.text.trim()}',
                verificationId: state.verificationId,
              ),
            );
          }
          // Handle errors
          else if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error), backgroundColor: Colors.red));
          }
          // Handle authentication - pending verification
          else if (state is AuthenticatedPendingVerification) {
            Navigator.pushNamedAndRemoveUntil(context, '/pending-verification', (route) => false);
          }
          // Handle authentication - approved (go to home)
          else if (state is AuthenticatedApproved) {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          }
          // Handle authentication - new user (go to registration)
          else if (state is AuthenticatedNewUser) {
            Navigator.pushNamedAndRemoveUntil(context, '/registration', (route) => false);
          }
          // Handle legacy authenticated state
          else if (state is Authenticated) {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          }
        },
        builder: (context, state) {
          final isLoading = state is OtpSending || state is OtpVerifying;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLanguageSelector(context),
                    const SizedBox(height: 20),

                    // App Logo
                    Image.asset(AppImages.appLogo, width: 160, height: 160),
                    const SizedBox(height: 24),

                    // App Name
                    Text(
                      AppContent.appName,
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),

                    // Tagline
                    Text(
                      AppContent.appTagline,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 60),

                    // Welcome Text
                    Text(l10n.welcomeBack, style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 8),
                    Text(
                      l10n.enterPhoneToContinue,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                    ),
                    const SizedBox(height: 32),

                    // Phone Number Field
                    CustomTextField(
                      label: l10n.mobileNumberLabel,
                      hint: l10n.phoneHint,
                      controller: _phoneController,
                      validator: (value) => Validators.validatePhone(value, l10n),
                      prefixIcon: const Icon(Icons.phone_android),
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: 32),

                    // Login Button
                    CustomButton(
                      text: l10n.continueButton,
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                final phoneNumber = '+91${_phoneController.text.trim()}';
                                context.read<AuthBloc>().add(LoginWithPhoneEvent(phoneNumber: phoneNumber));
                              }
                            },
                      isLoading: isLoading,
                      icon: Icons.arrow_forward,
                    ),

                    const SizedBox(height: 40),

                    // Info Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              l10n.otpInfo,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.blue.shade900),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
