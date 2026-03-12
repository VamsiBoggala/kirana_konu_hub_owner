# REGISTRATION FLOW - BLOC ARCHITECTURE DOCUMENTATION

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── app_colors.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── theme_provider.dart
│   ├── utils/
│   │   └── validators.dart          # Form validation logic
│   └── widgets/
│       ├── custom_text_field.dart   # Reusable text input
│       ├── custom_button.dart       # Reusable button
│       └── document_upload_widget.dart  # File upload widget
│
├── features/
│   └── registration/
│       ├── data/
│       │   └── models/
│       │       └── hub_registration_model.dart  # Data model with JSON serialization
│       ├── domain/
│       │   ├── entities/            # (Future: Business entities)
│       │   └── repositories/        # (Future: Repository interfaces)
│       └── presentation/
│           ├── bloc/
│           │   ├── registration_bloc.dart    # Main BLoC logic
│           │   ├── registration_event.dart   # All events
│           │   └── registration_state.dart   # All states
│           ├── pages/
│           │   ├── personal_details_screen.dart        # Screen 1
│           │   ├── business_documents_screen.dart      # Screen 2
│           │   ├── bank_details_screen.dart            # Screen 3
│           │   ├── terms_and_submit_screen.dart        # Screen 4
│           │   └── registration_success_screen.dart    # Success
│           └── widgets/             # (Future: Screen-specific widgets)
│
└── main.dart
```

## 🏗️ BLoC Architecture Pattern

### What is BLoC?
**BLoC (Business Logic Component)** separates business logic from UI, making code:
- ✅ Testable
- ✅ Reusable
- ✅ Maintainable
- ✅ Reactive (responds to events)

### Flow Diagram
```
User Action → Event → BLoC → State → UI Update
```

### Example Flow:
1. User enters name → `UpdatePersonalDetailsEvent`
2. BLoC processes → Updates `HubRegistrationModel`
3. Emits `RegistrationDataUpdated` state
4. UI rebuilds with new data

## 📦 Components Breakdown

### 1. **Models** (`data/models/`)
- `HubRegistrationModel`: Contains all registration data
- Includes JSON serialization for Firestore
- Uses Equatable for state comparison

### 2. **BLoC** (`presentation/bloc/`)

#### Events (`registration_event.dart`)
| Event | Purpose |
|-------|---------|
| `UpdatePersonalDetailsEvent` | Update name, mobile, shop name |
| `UpdateLocationEvent` | Update GPS coordinates |
| `UpdateGSTINEvent` | Update GSTIN number & doc |
| `UpdateFSSAIEvent` | Update FSSAI number & doc |
| `UpdateBankDetailsEvent` | Update bank account info |
| `AcceptTermsEvent` | Accept T&C |
| `UploadDocumentEvent` | Upload file to Firebase Storage |
| `SubmitRegistrationEvent` | Submit to Firestore |

#### States (`registration_state.dart`)
| State | When |
|-------|------|
| `RegistrationInitial` | App starts |
| `RegistrationLoading` | Processing |
| `RegistrationDataUpdated` | Data changed |
| `DocumentUploadInProgress` | File uploading (with progress) |
| `DocumentUploadSuccess` | File uploaded |
| `DocumentUploadFailed` | Upload error |
| `LocationUpdated` | GPS captured |
| `RegistrationSubmitting` | Submitting to Firestore |
| `RegistrationSuccess` | Submission complete |
| `RegistrationFailed` | Submission error |
| `ValidationError` | Form validation failed |

#### BLoC (`registration_bloc.dart`)
- Handles all events
- Manages state transitions
- Integrates with Firebase (Storage, Firestore, Auth)
- Validates data before submission

### 3. **Screens** (`presentation/pages/`)

#### Screen 1: Personal Details
- Collects: Owner name, mobile, shop name
- GPS location detection with permission handling
- Progress: 25% (1/4)

#### Screen 2: Business Documents
- GSTIN: Number validation + document upload
- FSSAI: Number validation + document upload
- Upload progress indicators
- Progress: 50% (2/4)

#### Screen 3: Bank Details
- Bank account info with confirmation
- IFSC code with auto-branch lookup
- Cancelled cheque upload
- Progress: 75% (3/4)

#### Screen 4: Terms & Submit
- Scrollable Terms of Service
- Commission Policy
- Checkbox acceptance
- Final submission
- Progress: 100% (4/4)

#### Success Screen
- Shows application ID
- Next steps information
- Navigation to home

### 4. **Common Widgets** (`core/widgets/`)

#### `CustomTextField`
Reusable text input with:
- Label styling
- Validation
- Prefix/suffix icons
- Character limits
- Input formatters

#### `CustomButton`
Reusable button with:
- Loading state
- Optional icon
- Full-width option
- Consistent styling

#### `DocumentUploadWidget`
File upload widget with:
- Drag/tap to upload
- Image/PDF preview
- File type validation
- Remove functionality

### 5. **Validators** (`core/utils/`)
Validation functions for:
- ✅ Name (2-50 chars, letters only)
- ✅ Mobile (10 digits, Indian format)
- ✅ GSTIN (15 chars, specific regex)
- ✅ FSSAI (14 digits)
- ✅ PAN (10 chars)
- ✅ Bank Account (9-18 digits)
- ✅ IFSC (11 chars)

## 🔥 Firebase Integration

### Firestore Structure
```json
{
  "hubs_pending": {
    "application_xyz": {
      "owner_name": "John Doe",
      "mobile_number": "9876543210",
      "shop_name": "Raju Traders",
      "location": {
        "latitude": 12.9716,
        "longitude": 77.5946,
        "address": "..."
      },
      "documents": {
        "gstin": {
          "number": "27AAPFU0939F1ZV",
          "document_url": "https://..."
        },
        "fssai": {
          "number": "12345678901234",
          "document_url": "https://..."
        }
      },
      "bank_details": {
        "account_holder_name": "John Doe",
        "account_number": "1234567890",
        "ifsc_code": "SBIN0001234",
        "branch_name": "Main Branch",
        "cancelled_cheque_url": "https://..."
      },
      "status": "pending_verification",
      "submitted_at": "2024-01-15T10:30:00Z",
      "owner_uid": "firebase_auth_uid",
      "temp_id": "application_xyz"
    }
  }
}
```

### Storage Structure
```
hub_registrations/
├── gstin/
│   └── 1705318200000_gstin.pdf
├── fssai/
│   └── 1705318200000_fssai.pdf
└── cancelled_cheque/
    └── 1705318200000_cancelled_cheque.jpg
```

## 🚀 Usage Guide

### 1. Setup in `main.dart`
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/registration/presentation/bloc/registration_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(
    BlocProvider(
      create: (context) => RegistrationBloc(),
      child: MyApp(),
    ),
  );
}
```

### 2. Navigation Routes
Add to your router:
```dart
'/registration/personal-details': (context) => PersonalDetailsScreen(),
'/registration/business-documents': (context) => BusinessDocumentsScreen(),
'/registration/bank-details': (context) => BankDetailsScreen(),
'/registration/terms': (context) => TermsAndSubmitScreen(),
'/registration/success': (context) => RegistrationSuccessScreen(),
```

### 3. Starting Registration
```dart
Navigator.pushNamed(context, '/registration/personal-details');
```

## 🎨 Theme Integration

All widgets use the Poppins font from `app_theme.dart`:
- **Headers**: Poppins Bold
- **Body**: Poppins Regular
- **Buttons**: Poppins SemiBold

Colors follow `app_colors.dart` with:
- Primary: Royal Blue (#1565C0)
- Surface: Light/Dark mode compatible

## ✅ Validation Flow

1. **Client-side** (Immediate feedback)
   - Validators in form fields
   - Character limits
   - Regex patterns

2. **BLoC-level** (Before submission)
   - `_validateRegistrationData()` in BLoC
   - Checks all required fields
   - Emits `ValidationError` if fails

3. **Server-side** (Future)
   - Firebase Security Rules
   - Cloud Functions validation

## 📱 Permissions Required

Add to `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

Add to `Info.plist` (iOS):
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to verify your business address</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to upload business documents</string>
```

## 🔒 Security Considerations

1. **Data Validation**: All inputs validated before submission
2. **File Upload**: Limited to specific formats (JPG, PNG, PDF)
3. **Authentication**: Links to Firebase Auth UID
4. **Storage Rules**: Implement Firebase Security Rules
5. **Firestore Rules**: Restrict write access

## 🧪 Testing

### Unit Tests (Future)
- Test validators
- Test BLoC events/states
- Test model serialization

### Widget Tests (Future)
- Test form validation
- Test navigation flow
- Test error states

### Integration Tests (Future)
- Test full registration flow
- Test Firebase integration

## 🚀 Next Steps

1. ✅ Basic structure created
2. ⬜ Add Firebase initialization
3. ⬜ Add proper error handling
4. ⬜ Add retry logic for uploads
5. ⬜ Add offline support
6. ⬜ Add analytics tracking
7. ⬜ Add unit tests
8. ⬜ Add OTP verification for mobile

## 📝 Notes

- **BLoC Pattern**: Clean separation of concerns
- **Reusable Widgets**: DRY principle applied
- **Type Safety**: Strong typing throughout
- **Scalability**: Easy to add new screens/fields
- **Maintainability**: Clear structure, well-documented

## 🎯 Key Features

✅ 4-screen registration flow
✅ GPS location detection
✅ Document upload with progress
✅ Real-time form validation
✅ Firebase integration ready
✅ Poppins font throughout
✅ Dark/Light theme support
✅ Error handling
✅ Loading states
✅ Success feedback

---

**Built with ❤️ following BLoC architecture principles**
