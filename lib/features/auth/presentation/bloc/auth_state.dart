import 'package:equatable/equatable.dart';

/// Base class for all Auth States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Checking authentication status
class AuthCheckingStatus extends AuthState {
  const AuthCheckingStatus();
}

/// User is not authenticated
class Unauthenticated extends AuthState {
  const Unauthenticated();
}

/// Sending OTP
class OtpSending extends AuthState {
  final String phoneNumber;

  const OtpSending({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

/// OTP sent successfully
class OtpSent extends AuthState {
  final String phoneNumber;
  final String verificationId;

  const OtpSent({required this.phoneNumber, required this.verificationId});

  @override
  List<Object?> get props => [phoneNumber, verificationId];
}

/// Verifying OTP
class OtpVerifying extends AuthState {
  const OtpVerifying();
}

/// OTP verification failed
class OtpVerificationFailed extends AuthState {
  final String error;

  const OtpVerificationFailed({required this.error});

  @override
  List<Object?> get props => [error];
}

/// User is authenticated - navigate to pending verification screen
class AuthenticatedPendingVerification extends AuthState {
  final String userId;
  final String phoneNumber;

  const AuthenticatedPendingVerification({required this.userId, required this.phoneNumber});

  @override
  List<Object?> get props => [userId, phoneNumber];
}

/// User is authenticated - navigate to home screen (approved)
class AuthenticatedApproved extends AuthState {
  final String userId;
  final String phoneNumber;

  const AuthenticatedApproved({required this.userId, required this.phoneNumber});

  @override
  List<Object?> get props => [userId, phoneNumber];
}

/// User is authenticated - navigate to registration screen (new user)
class AuthenticatedNewUser extends AuthState {
  final String userId;
  final String phoneNumber;

  const AuthenticatedNewUser({required this.userId, required this.phoneNumber});

  @override
  List<Object?> get props => [userId, phoneNumber];
}

/// User is authenticated (legacy - keeping for backward compatibility)
class Authenticated extends AuthState {
  final String userId;
  final String phoneNumber;
  final bool hasCompletedRegistration;

  const Authenticated({required this.userId, required this.phoneNumber, this.hasCompletedRegistration = false});

  @override
  List<Object?> get props => [userId, phoneNumber, hasCompletedRegistration];
}

/// Auth error
class AuthError extends AuthState {
  final String error;

  const AuthError({required this.error});

  @override
  List<Object?> get props => [error];
}

/// Navigate to Registration
class NavigateToRegistration extends AuthState {
  const NavigateToRegistration();
}
