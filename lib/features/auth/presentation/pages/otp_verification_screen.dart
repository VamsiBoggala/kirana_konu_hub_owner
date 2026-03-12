import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_button.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/otp_header_section.dart';
import '../widgets/otp_input_section.dart';
import '../widgets/otp_resend_section.dart';
import 'package:hub_owner/l10n/app_localizations.dart';

class OtpVerificationArgs {
  final String phoneNumber;
  final String verificationId;

  OtpVerificationArgs({required this.phoneNumber, required this.verificationId});
}

class OtpVerificationScreen extends StatefulWidget {
  final OtpVerificationArgs args;

  const OtpVerificationScreen({super.key, required this.args});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    if (_otpController.text.length == 6) {
      context.read<AuthBloc>().add(
        VerifyOtpEvent(otp: _otpController.text, verificationId: widget.args.verificationId),
      );
    }
  }

  void _onResend() {
    // Trigger resend event if available
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Resend feature to be implemented')));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.verificationTitle), centerTitle: true),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // Handle authentication - pending verification
          if (state is AuthenticatedPendingVerification) {
            Navigator.of(context).pushNamedAndRemoveUntil('/pending-verification', (route) => false);
          }
          // Handle authentication - approved (go to home)
          else if (state is AuthenticatedApproved) {
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
          }
          // Handle authentication - new user (go to registration)
          else if (state is AuthenticatedNewUser) {
            Navigator.of(context).pushNamedAndRemoveUntil('/registration', (route) => false);
          }
          // Handle legacy authenticated state
          else if (state is Authenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
          }
          // Handle OTP verification failure
          else if (state is OtpVerificationFailed) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error), backgroundColor: Colors.red));
          }
        },
        builder: (context, state) {
          final isVerifying = state is OtpVerifying;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OtpHeaderSection(phoneNumber: widget.args.phoneNumber),
                  const SizedBox(height: 32),
                  OtpInputSection(
                    controller: _otpController,
                    isVerifying: isVerifying,
                    onCompleted: (_) => _verifyOtp(),
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    text: l10n.verifyButton,
                    onPressed: isVerifying ? null : _verifyOtp,
                    isLoading: isVerifying,
                  ),
                  const SizedBox(height: 24),
                  OtpResendSection(isVerifying: isVerifying, onResend: _onResend),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
