import 'package:flutter/material.dart';
import 'package:hub_owner/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/constants/app_content.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';
import '../bloc/registration_state.dart';
import '../routes/registration_routes.dart';
import '../widgets/upload_progress_dialog.dart';
import '../widgets/submission_error_dialog.dart';

/// Screen 4: Terms & Submit
/// Final screen showing terms and submission
class TermsAndSubmitScreen extends StatelessWidget {
  const TermsAndSubmitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.reviewSubmitTitle), centerTitle: true),
      body: BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          // Handle validation errors
          if (state is ValidationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.orange,
                duration: const Duration(seconds: 4),
              ),
            );
          }
          // Handle Images Uploading - Show Progress Dialog
          else if (state is ImagesUploading) {
            showDialog(context: context, barrierDismissible: false, builder: (context) => const UploadProgressDialog());
          }
          // Handle Images Upload Success - Dialog usually stays open or updates for submission
          // (Handled by BlocBuilder in dialog)
          // Handle Images Upload Fail
          else if (state is ImagesUploadFailed) {
            // Close progress dialog safely
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }

            showDialog(
              context: context,
              builder: (dialogContext) => SubmissionErrorDialog(
                error: state.error,
                onRetry: () {
                  final userId = FirebaseAuth.instance.currentUser?.uid;
                  if (userId != null) {
                    context.read<RegistrationBloc>().add(RetrySubmissionEvent(userId: userId));
                  }
                },
                onCancel: () {
                  // Close all dialog routes to ensure the progress dialog is also removed
                  Navigator.of(dialogContext).popUntil((route) => route is! DialogRoute);
                },
              ),
            );
          }
          // Handle Submission Success
          else if (state is SubmissionSuccess) {
            // Close progress dialog if open
            // We can try popping only if we know it's open, but popping safely is hard.
            // Assuming the dialog is the top route.
            Navigator.of(context).pop();

            // Navigate to success screen using route constant
            Navigator.pushNamedAndRemoveUntil(context, RegistrationRoutes.success, (route) => false);
          }
          // Handle Submission Failed
          else if (state is SubmissionFailed) {
            // Close progress dialog safely
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }

            showDialog(
              context: context,
              builder: (dialogContext) => SubmissionErrorDialog(
                error: state.error,
                onRetry: () {
                  final userId = FirebaseAuth.instance.currentUser?.uid;
                  if (userId != null) {
                    context.read<RegistrationBloc>().add(RetrySubmissionEvent(userId: userId));
                  }
                },
                onCancel: () {
                  // Close all dialog routes to ensure the progress dialog is also removed
                  Navigator.of(dialogContext).popUntil((route) => route is! DialogRoute);
                },
              ),
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<RegistrationBloc>();
          final data = bloc.currentData;
          // Check for any loading state
          final isSubmitting =
              state is RegistrationSubmitting || state is ImagesUploading || state is SubmittingRequest;
          final termsAccepted = data.termsAccepted;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Indicator
                  _buildProgressIndicator(context, 4),
                  const SizedBox(height: 32),

                  // Header
                  Text(l10n.termsPoliciesHeader, style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 8),
                  Text(
                    l10n.termsPoliciesSubHeader,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                  ),
                  const SizedBox(height: 32),

                  // Terms of Service Card
                  _buildTermsCard(context, l10n.termsOfService, Icons.description_outlined, AppContent.termsOfService),
                  const SizedBox(height: 16),

                  // Commission Policy Card
                  _buildTermsCard(
                    context,
                    l10n.commissionPolicy,
                    Icons.account_balance_wallet_outlined,
                    AppContent.commissionPolicy,
                  ),
                  const SizedBox(height: 32),

                  // Acceptance Checkbox
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Theme.of(context).colorScheme.outline),
                    ),
                    child: CheckboxListTile(
                      value: termsAccepted,
                      onChanged: isSubmitting
                          ? null
                          : (value) {
                              bloc.add(const ToggleTermsAcceptanceEvent());
                            },
                      title: Text(
                        l10n.agreeToTerms,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Important Notice
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber.shade300),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline, color: Colors.amber.shade900, size: 24),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.verificationPendingTitle,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.amber.shade900,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                l10n.verificationPendingMessage,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.amber.shade900),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Navigation Buttons
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: l10n.backButton,
                          onPressed: isSubmitting ? null : () => Navigator.pop(context),
                          backgroundColor: Theme.of(context).colorScheme.surface,
                          textColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: CustomButton(
                          text: l10n.submitApplication,
                          onPressed: isSubmitting
                              ? null
                              : () {
                                  if (!termsAccepted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Please agree to terms and conditions')),
                                    );
                                    return;
                                  }
                                  // Get User ID and submit
                                  final userId = FirebaseAuth.instance.currentUser?.uid;
                                  if (userId != null) {
                                    bloc.add(UploadImagesAndSubmitEvent(userId: userId));
                                  } else {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(const SnackBar(content: Text('User not authenticated')));
                                  }
                                },
                          isLoading: isSubmitting,
                          icon: Icons.check_circle_outline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context, int currentStep) {
    return Row(
      children: List.generate(4, (index) {
        final stepNumber = index + 1;
        final isActive = stepNumber <= currentStep;

        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: isActive
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              if (index < 3) const SizedBox(width: 4),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTermsCard(BuildContext context, String title, IconData icon, String content) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          // Content
          Container(
            padding: const EdgeInsets.all(16),
            constraints: const BoxConstraints(maxHeight: 200),
            child: SingleChildScrollView(
              child: Text(
                content,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  height: 1.6,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
