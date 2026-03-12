import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../routes/auth_routes.dart';

/// Pending Verification Screen
/// Shown when user has submitted registration but waiting for approval
class PendingVerificationScreen extends StatelessWidget {
  const PendingVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Submitted'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(const LogoutEvent());
              Navigator.of(context).pushNamedAndRemoveUntil(AuthRoutes.login, (route) => false);
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Pending icon
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: Colors.orange.shade50, shape: BoxShape.circle),
                child: Icon(Icons.schedule, size: 80, color: Colors.orange.shade700),
              ),
              const SizedBox(height: 32),

              // Title
              Text(
                'Application Under Review',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Message
              Text(
                'Thank you for submitting your registration application. Our team is reviewing your documents.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // Timeline info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'What happens next?',
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.blue.shade900),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildTimelineItem(context, '1. Our team reviews your documents', true),
                    _buildTimelineItem(context, '2. Verification process (24-48 hours)', true),
                    _buildTimelineItem(context, '3. You\'ll receive approval notification', false),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Contact support
              TextButton.icon(
                onPressed: () {
                  // TODO: Add support contact functionality
                },
                icon: const Icon(Icons.support_agent),
                label: const Text('Contact Support'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem(BuildContext context, String text, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8),
      child: Row(
        children: [
          Icon(
            isActive ? Icons.check_circle : Icons.circle_outlined,
            size: 16,
            color: isActive ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blue.shade900)),
          ),
        ],
      ),
    );
  }
}
