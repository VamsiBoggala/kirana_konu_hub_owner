import 'package:flutter/material.dart';
import 'package:hub_owner/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_button.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_state.dart';

/// Success Screen
/// Shown after successful registration submission
/// Gets application ID from BLoC state, not from route arguments
class RegistrationSuccessScreen extends StatelessWidget {
  const RegistrationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        // Get application ID from BLoC state
        String? applicationId;
        if (state is RegistrationSuccess) {
          applicationId = state.applicationId;
        }

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Success Icon
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                    child: Icon(Icons.check_circle, size: 80, color: Colors.green.shade600),
                  ),
                  const SizedBox(height: 32),

                  // Title
                  Text(
                    l10n.applicationSubmitted,
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Message
                  Text(
                    l10n.registrationSuccessMessage,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Application ID Card
                  if (applicationId != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                      ),
                      child: Column(
                        children: [
                          Text(
                            l10n.applicationId,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            applicationId,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            l10n.saveIdInfo,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 32),

                  // Information Cards
                  _buildInfoCard(
                    context,
                    Icons.hourglass_empty,
                    l10n.verificationInProgress,
                    l10n.verificationInProgressSub,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoCard(context, Icons.notifications_active_outlined, l10n.notifyYou, l10n.notifyYouSub),
                  const SizedBox(height: 12),
                  _buildInfoCard(context, Icons.contact_support_outlined, l10n.needHelp, l10n.contactSupport),
                  const Spacer(),

                  // Done Button
                  CustomButton(
                    text: l10n.done,
                    onPressed: () {
                      // Check application status before navigating
                      _checkApplicationStatus(context, l10n);
                    },
                    icon: Icons.home_outlined,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(BuildContext context, IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Check application status before navigating to home
  void _checkApplicationStatus(BuildContext context, AppLocalizations l10n) {
    // TODO: In future,query actual application status from backend/Firebase
    // For now, show warning message that approval is pending
    final applicationStatus = 'pending'; // Can be: 'pending', 'approved', 'rejected'

    if (applicationStatus == 'approved') {
      // Navigate to home
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else if (applicationStatus == 'rejected') {
      // Show rejection message
      _showStatusDialog(
        context,
        l10n.applicationRejectedTitle,
        l10n.applicationRejectedMessage,
        Colors.red,
        Icons.cancel_outlined,
        l10n,
      );
    } else {
      // Show pending message (default)
      _showStatusDialog(
        context,
        l10n.approvalPendingTitle,
        l10n.approvalPendingMessage,
        Colors.orange,
        Icons.pending_outlined,
        l10n,
      );
    }
  }

  /// Show status dialog
  void _showStatusDialog(
    BuildContext context,
    String title,
    String message,
    Color color,
    IconData icon,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(icon, size: 60, color: color),
        title: Text(title),
        content: Text(message),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.ok))],
      ),
    );
  }
}
