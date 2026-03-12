import 'package:flutter/material.dart';

class SubmissionErrorDialog extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;
  final VoidCallback? onCancel;

  const SubmissionErrorDialog({super.key, required this.error, required this.onRetry, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red),
          SizedBox(width: 8),
          Text('Submission Failed'),
        ],
      ),
      content: Text(error),
      actions: [
        TextButton(
          onPressed: () {
            onCancel?.call();
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
            onRetry();
          },
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
