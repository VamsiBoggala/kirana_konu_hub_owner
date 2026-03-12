import 'package:flutter/material.dart';
import 'package:hub_owner/l10n/app_localizations.dart';

class OtpResendSection extends StatelessWidget {
  final bool isVerifying;
  final VoidCallback onResend;

  const OtpResendSection({super.key, required this.isVerifying, required this.onResend});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: isVerifying ? null : onResend,
        child: Text(
          AppLocalizations.of(context)!.resendCode,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
