# Authentication Feature

## Overview
The Authentication feature handles user login, phone verification, and session management for the Kirana Konu Hub Owner application.

## Architecture
This feature follows the BLoC (Business Logic Component) pattern for state management.

## Directory Structure
```
auth/
├── data/
│   └── models/              # Data models (TODO)
├── domain/                  # Business logic layer (TODO)
└── presentation/
    ├── bloc/
    │   ├── auth_bloc.dart   # Main authentication BLoC
    │   ├── auth_event.dart  # Authentication events
    │   └── auth_state.dart  # Authentication states
    ├── pages/
    │   └── login_screen.dart # Phone login UI
    └── routes/
        └── auth_routes.dart  # Route constants
```

## Features

### ✅ Implemented
- Phone number-based authentication (mock)
- OTP verification (mock)
- Login screen with validation
- Auto-routing based on registration status
- Session state management via BLoC

### 🚧 TODO (Future Enhancements)
- Firebase Phone Authentication integration
- Real OTP verification
- Session persistence (SharedPreferences/SecureStorage)
- Biometric authentication
- Remember me functionality
- Logout functionality
- Password recovery flow

## BLoC Implementation

### Events
| Event | Description | Parameters |
|-------|-------------|------------|
| `CheckAuthStatusEvent` | Check if user is logged in | None |
| `LoginWithPhoneEvent` | Initiate phone login (send OTP) | `phoneNumber` |
| `VerifyOtpEvent` | Verify OTP code | `otp`, `verificationId` |
| `ResendOtpEvent` | Resend OTP | `phoneNumber` |
| `LogoutEvent` | Logout user | None |
| `NavigateToRegistrationEvent` | Trigger navigation to registration | None |

### States
| State | Description | Data |
|-------|-------------|------|
| `AuthInitial` | Initial state | None |
| `AuthCheckingStatus` | Checking authentication status | None |
| `Unauthenticated` | User not logged in | None |
| `OtpSending` | Sending OTP to phone | `phoneNumber` |
| `OtpSent` | OTP sent successfully | `phoneNumber`, `verificationId` |
| `OtpVerifying` | Verifying OTP | None |
| `OtpVerificationFailed` | Invalid OTP | `error` |
| `Authenticated` | User successfully authenticated | `userId`, `phoneNumber`, `hasCompletedRegistration` |
| `AuthError` | Error occurred | `error` |
| `NavigateToRegistration` | Navigate to registration flow | None |

## User Flow

### Login Flow
```
1. User opens app
   ↓
2. Login Screen displayed
   ↓
3. User enters 10-digit phone number
   ↓
4. Validates phone number
   ↓
5. Dispatches LoginWithPhoneEvent
   ↓
6. BLoC sends OTP (mock: 2 second delay)
   ↓
7. OtpSent state emitted
   ↓
8. OTP Dialog appears
   ↓
9. User enters 6-digit OTP
   ↓
10. Dispatches VerifyOtpEvent
    ↓
11. BLoC verifies OTP (mock: accepts any 6-digit code)
    ↓
12. Authenticated state emitted
    ↓
13. Navigate based on registration status:
    - If hasCompletedRegistration = false → Personal Details Screen
    - If hasCompletedRegistration = true → Home Screen
```

## Screens

### Login Screen (`login_screen.dart`)

**Features:**
- Custom app logo (Kirana Konu branding)
- Phone number input field (10 digits)
- Indian phone number validation (starts with 6-9)
- Auto-formatting
- Loading states
- Error handling with SnackBars
- OTP verification dialog
- Responsive to BLoC state changes

**Widgets:**
- `Image.asset` displaying custom logo (`AppImages.appLogo`)
- `CustomTextField` for phone input
- `CustomButton` for submit
- `AlertDialog` for OTP entry
- Info card explaining OTP process

**Validation:**
- Required field
- Exactly 10 digits
- Must start with 6, 7, 8, or 9 (Indian mobile)
- Only numeric input allowed

## Routes

### Available Routes
- `/auth/login` - Main login screen
- `/auth/signup` - Signup screen (TODO)
- `/auth/forgot-password` - Password recovery (TODO)
- `/auth/otp-verification` - OTP screen (TODO - currently dialog)

### Current Initial Route
`/auth/login` - App opens directly to login screen

## Integration

### Provider Setup (main.dart)
```dart
BlocProvider(
  create: (_) => AuthBloc(),
)
```

### Usage in Screens
```dart
// Dispatch login event
context.read<AuthBloc>().add(
  LoginWithPhoneEvent(phoneNumber: '+919876543210')
);

// Listen to auth state
BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is Authenticated) {
      // Navigate based on registration status
    }
  },
  builder: (context, state) {
    // Build UI based on state
  },
)
```

## Dependencies
- `flutter_bloc`: State management
- `equatable`: Value equality for events/states
- Custom widgets from `core/widgets/`
- Validators from `core/utils/validators.dart`

## Mock Implementations

### Current Mock Behavior
1. **Phone Authentication:**
   - Accepts any 10-digit phone number
   - Always succeeds after 2-second delay
   - Generates mock `verificationId`

2. **OTP Verification:**
   - Accepts any 6-digit code
   - Always succeeds after 2-second delay
   - Returns mock `userId`

3. **User Data:**
   - `hasCompletedRegistration` always set to `false`
   - Routes new users to registration flow

### Future Real Implementation
```dart
// TODO: Replace with Firebase Phone Auth
Future<void> _onLoginWithPhone() async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: event.phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException e) {},
    codeSent: (String verificationId, int? resendToken) {},
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}
```

## Testing

### Manual Testing
1. Enter phone: `9876543210`
2. Click Continue
3. Wait for OTP dialog (2 seconds)
4. Enter any 6-digit OTP: `123456`
5. Click Verify
6. Should navigate to Personal Details screen

### Test Cases to Implement
- [ ] Valid phone number formats
- [ ] Invalid phone number formats
- [ ] OTP resend functionality
- [ ] OTP timeout
- [ ] Network error handling
- [ ] Session persistence
- [ ] Logout flow

## Error Handling

### Current Error Messages
- "Mobile number is required"
- "Please enter a valid 10-digit mobile number"
- "Failed to send OTP: {error}"
- "Invalid OTP. Please try again."

### Error States
All errors are emitted as `AuthError` or `OtpVerificationFailed` states and displayed via SnackBars.

## Performance Considerations
- BLoC instances provided at app level (single instance)
- States are immutable (Equatable)
- Only rebuilds when state actually changes
- Async operations handled with proper loading states

## Security Notes
⚠️ **Current Implementation is Mock Only**
- No real authentication
- No session encryption
- No secure storage
- **DO NOT USE IN PRODUCTION**

### Production Security TODO
- [ ] Implement Firebase Phone Auth
- [ ] Use FlutterSecureStorage for tokens
- [ ] Implement token refresh
- [ ] Add rate limiting for OTP requests
- [ ] Implement biometric authentication
- [ ] Add SSL pinning
- [ ] Encrypt sensitive data

## Changelog

### v1.0.0 (Current)
- ✅ Created auth feature structure
- ✅ Implemented AuthBloc with events and states
- ✅ Created login screen with phone input
- ✅ Added custom app logo (assets infrastructure)
- ✅ Added OTP verification dialog
- ✅ Mock phone authentication
- ✅ Mock OTP verification
- ✅ Auto-routing based on registration status
- ✅ Integration with app routes
- ✅ Added to main.dart providers

## Related Features
- **Registration Feature**: `/features/registration/` - Handles user registration after authentication
- **Core**: `/core/` - Shared widgets, utils, constants

## API Integration (TODO)

### Endpoints Needed
```
POST /auth/send-otp
  Request: { phoneNumber: string }
  Response: { verificationId: string, expiresIn: number }

POST /auth/verify-otp
  Request: { phoneNumber: string, otp: string, verificationId: string }
  Response: { token: string, userId: string, hasCompletedRegistration: boolean }

POST /auth/resend-otp
  Request: { phoneNumber: string }
  Response: { verificationId: string, expiresIn: number }

GET /auth/session
  Headers: { Authorization: Bearer {token} }
  Response: { userId: string, phoneNumber: string, status: string }
```

## Notes
- Phone numbers are Indian format (+91 prefix)
- OTP valid for 5 minutes (to be implemented)
- Maximum 3 OTP attempts (to be implemented)
- Auto-navigation prevents manual route changes
