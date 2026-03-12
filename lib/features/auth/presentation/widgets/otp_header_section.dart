import 'package:flutter/material.dart';
import 'package:hub_owner/l10n/app_localizations.dart';

class OtpHeaderSection extends StatelessWidget {
  final String phoneNumber;

  const OtpHeaderSection({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          l10n.enterVerificationCode,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          l10n.verificationCodeSentTo(phoneNumber),
          style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        // Security Note
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.shade200),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.security, size: 16, color: Colors.orange.shade800),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.securityNote,
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.orange.shade900),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
