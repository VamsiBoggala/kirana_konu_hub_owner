import 'package:equatable/equatable.dart';

/// Base class for all Auth Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Login with Phone Number
class LoginWithPhoneEvent extends AuthEvent {
  final String phoneNumber;

  const LoginWithPhoneEvent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

/// Login Failed (for async errors from Firebase callbacks)
class LoginFailedEvent extends AuthEvent {
  final String error;

  const LoginFailedEvent({required this.error});

  @override
  List<Object?> get props => [error];
}

/// Verify OTP
class VerifyOtpEvent extends AuthEvent {
  final String otp;
  final String verificationId;

  const VerifyOtpEvent({required this.otp, required this.verificationId});

  @override
  List<Object?> get props => [otp, verificationId];
}

/// Resend OTP
class ResendOtpEvent extends AuthEvent {
  final String phoneNumber;

  const ResendOtpEvent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

/// Check Auth Status
class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}

/// Logout
class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

/// Navigate to Registration
class NavigateToRegistrationEvent extends AuthEvent {
  const NavigateToRegistrationEvent();
}

/// OTP Code Sent (for async callback from Firebase)
class OtpCodeSentEvent extends AuthEvent {
  final String phoneNumber;
  final String verificationId;

  const OtpCodeSentEvent({required this.phoneNumber, required this.verificationId});

  @override
  List<Object?> get props => [phoneNumber, verificationId];
}
