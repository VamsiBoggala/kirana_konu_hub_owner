import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// Authentication BLoC
/// Handles user authentication, OTP verification, and session management
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _verificationId;

  AuthBloc() : super(const AuthInitial()) {
    // Register event handlers
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<LoginWithPhoneEvent>(_onLoginWithPhone);
    on<LoginFailedEvent>(_onLoginFailed);
    on<OtpCodeSentEvent>(_onOtpCodeSent);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ResendOtpEvent>(_onResendOtp);
    on<LogoutEvent>(_onLogout);
    on<NavigateToRegistrationEvent>(_onNavigateToRegistration);
  }

  /// Check current authentication status
  Future<void> _onCheckAuthStatus(CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    emit(const AuthCheckingStatus());

    try {
      final currentUser = _auth.currentUser;

      if (currentUser != null) {
        // User is logged in, check their registration status
        final phoneNumber = currentUser.phoneNumber ?? '';
        await _checkRegistrationStatus(currentUser.uid, phoneNumber, emit);
      } else {
        emit(const Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  /// Login with phone number (send OTP)
  Future<void> _onLoginWithPhone(LoginWithPhoneEvent event, Emitter<AuthState> emit) async {
    print('📱 Starting OTP send process for: ${event.phoneNumber}');
    emit(OtpSending(phoneNumber: event.phoneNumber));

    try {
      print('🔄 Calling Firebase verifyPhoneNumber...');
      await _auth.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification (Android only)
          print('✅ Auto-verification completed (Android only)');
          try {
            final userCredential = await _auth.signInWithCredential(credential);
            if (userCredential.user != null) {
              print('✅ User signed in automatically with UID: ${userCredential.user!.uid}');
              // Note: We can't emit here as the event handler has completed
              // The user will be redirected through CheckAuthStatus when they reopen the app
              // Or we can add a new event to handle this
              add(const CheckAuthStatusEvent());
            }
          } catch (e) {
            print('❌ Auto-verification error: $e');
            // Can't emit here, so we'll just log
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print('❌ Firebase verification failed!');
          print('   Error code: ${e.code}');
          print('   Error message: ${e.message}');

          String errorMessage = 'Verification failed';
          if (e.code == 'invalid-phone-number') {
            errorMessage = 'The phone number is invalid. Please check and try again.';
          } else if (e.code == 'too-many-requests') {
            errorMessage = 'Too many verification attempts. Please try again after a few hours.';
          } else if (e.code == 'app-not-authorized') {
            errorMessage = 'App not configured properly. Please contact support.';
          } else if (e.code == 'quota-exceeded') {
            errorMessage = 'Daily SMS quota exceeded. Please try again tomorrow.';
          } else if (e.message != null) {
            errorMessage = e.message!;
          }

          // Add new event to handle the error instead of emitting directly
          add(LoginFailedEvent(error: errorMessage));
        },
        codeSent: (String verificationId, int? resendToken) {
          print('✅ OTP Code sent successfully!');
          print('   Verification ID: $verificationId');
          print('   Resend token: $resendToken');

          // Add event instead of emitting directly to avoid emit.isDone issues
          _verificationId = verificationId;
          add(OtpCodeSentEvent(phoneNumber: event.phoneNumber, verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('⏱️ Code auto-retrieval timeout');
          print('   Verification ID: $verificationId');
          _verificationId = verificationId;
        },
        timeout: const Duration(seconds: 60),
      );
      print('✅ Firebase verifyPhoneNumber call completed');
    } catch (e) {
      print('❌ Exception during OTP send: $e');
      if (!emit.isDone) {
        emit(AuthError(error: 'Failed to send OTP: ${e.toString()}'));
      }
    }
  }

  /// Handle login failed event (from async Firebase callbacks)
  void _onLoginFailed(LoginFailedEvent event, Emitter<AuthState> emit) {
    emit(AuthError(error: event.error));
  }

  /// Handle OTP code sent event (from async Firebase callbacks)
  void _onOtpCodeSent(OtpCodeSentEvent event, Emitter<AuthState> emit) {
    print('📤 Emitting OtpSent state with phone: ${event.phoneNumber}');
    emit(OtpSent(phoneNumber: event.phoneNumber, verificationId: event.verificationId));
  }

  /// Verify OTP
  Future<void> _onVerifyOtp(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(const OtpVerifying());

    try {
      if (_verificationId == null) {
        emit(const OtpVerificationFailed(error: 'Verification ID not found. Please request OTP again.'));
        return;
      }

      // Create credential with verification ID and OTP
      final credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: event.otp);

      // Sign in with credential
      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        final user = userCredential.user!;
        await _checkRegistrationStatus(user.uid, user.phoneNumber ?? '', emit);
      } else {
        emit(const OtpVerificationFailed(error: 'Sign-in failed. Please try again.'));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'OTP verification failed';
      if (e.code == 'invalid-verification-code') {
        errorMessage = 'Invalid OTP. Please try again.';
      } else if (e.code == 'session-expired') {
        errorMessage = 'OTP has expired. Please request a new one.';
      }
      emit(OtpVerificationFailed(error: errorMessage));
    } catch (e) {
      print(e);
      emit(OtpVerificationFailed(error: e.toString()));
    }
  }

  /// Check registration status in Firestore
  Future<void> _checkRegistrationStatus(String uid, String phoneNumber, Emitter<AuthState> emit) async {
    try {
      // Check if document exists in hub_requests collection
      final doc = await _firestore.collection('hub_requests').doc(uid).get();

      if (doc.exists) {
        final data = doc.data();
        final status = data?['status'] as String?;

        if (status == 'pending') {
          // User has submitted registration but not yet approved
          emit(AuthenticatedPendingVerification(userId: uid, phoneNumber: phoneNumber));
        } else if (status == 'approved') {
          // User is approved, go to home
          emit(AuthenticatedApproved(userId: uid, phoneNumber: phoneNumber));
        } else {
          // Unknown status, treat as new user
          emit(AuthenticatedNewUser(userId: uid, phoneNumber: phoneNumber));
        }
      } else {
        // No document exists, new user needs to register
        emit(AuthenticatedNewUser(userId: uid, phoneNumber: phoneNumber));
      }
    } catch (e) {
      emit(AuthError(error: 'Failed to check registration status: ${e.toString()}'));
    }
  }

  /// Resend OTP
  Future<void> _onResendOtp(ResendOtpEvent event, Emitter<AuthState> emit) async {
    // Reuse login logic
    add(LoginWithPhoneEvent(phoneNumber: event.phoneNumber));
  }

  /// Logout
  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await _auth.signOut();
      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  /// Navigate to registration
  void _onNavigateToRegistration(NavigateToRegistrationEvent event, Emitter<AuthState> emit) {
    emit(const NavigateToRegistration());
  }
}
