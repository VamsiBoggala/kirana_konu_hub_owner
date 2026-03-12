import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpInputSection extends StatelessWidget {
  final TextEditingController controller;
  final bool isVerifying;
  final Function(String) onCompleted;

  const OtpInputSection({super.key, required this.controller, required this.isVerifying, required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    // Default theme for Pinput
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Theme.of(context).primaryColor, width: 2),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(color: const Color.fromRGBO(234, 239, 243, 1)),
    );

    return Pinput(
      length: 6,
      controller: controller,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: onCompleted,
      enabled: !isVerifying,
    );
  }
}
