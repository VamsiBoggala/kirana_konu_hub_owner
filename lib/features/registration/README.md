# Registration Feature

## Overview
The Registration feature handles the complete hub owner onboarding process, collecting business information, documents, bank details, and terms acceptance for the Kirana Konu platform.

## Architecture
This feature follows the BLoC (Business Logic Component) pattern with **zero setState calls** - all state management is handled by RegistrationBloc.

## Directory Structure
```
registration/
├── data/
│   └── models/
│       └── hub_registration_model.dart  # Registration data model
├── domain/                               # Business logic layer (TODO)
└── presentation/
    ├── bloc/
    │   ├── registration_bloc.dart        # Main registration BLoC
    │   ├── registration_event.dart       # All registration events
    │   └── registration_state.dart       # All registration states
    ├── pages/
    │   ├── personal_details_screen.dart      # Screen 1: Personal info
    │   ├── business_documents_screen.dart    # Screen 2: GSTIN, FSSAI
    │   ├── bank_details_screen.dart          # Screen 3: Bank account
    │   ├── terms_and_submit_screen.dart      # Screen 4: Terms & submit
    │   └── registration_success_screen.dart  # Success confirmation
    └── routes/
        └── registration_routes.dart      # Route constants
```

## Features

### ✅ Implemented
- 4-step registration wizard
- Personal details collection with location
- Business document uploads (GSTIN, FSSAI)
- Bank details with IFSC lookup
- Terms and conditions acceptance
- Document upload with progress tracking (mock)
- Form validation at each step
- Auto-navigation based on completion
- Application status checking
- **100% BLoC-driven** (0 setState calls)

### 🚧 TODO (Future Enhancements)
- Firebase document storage integration
- Real-time document upload progress
- Image compression before upload
- OCR for automatic field extraction
- Aadhaar verification
- Email verification
- Multi-language support
- Draft save functionality

## Registration Flow

### 4-Step Wizard
```
Step 1: Personal Details
  ├─ Full Name
  ├─ Mobile Number
  ├─ Email
  ├─ PAN Card
  ├─ Shop/Hub Name
  ├─ Shop Address
  └─ Location (GPS)
      ↓
Step 2: Business Documents
  ├─ GSTIN Number
  ├─ GSTIN Document Upload
  ├─ FSSAI License Number
  └─ FSSAI Document Upload
      ↓
Step 3: Bank Details
  ├─ Account Holder Name
  ├─ Account Number
  ├─ Confirm Account Number
  ├─ IFSC Code (auto-lookup branch)
  ├─ Branch Name (auto-filled)
  └─ Cancelled Cheque Upload
      ↓
Step 4: Terms & Submit
  ├─ Terms of Service
  ├─ Commission Policy
  ├─ Terms Acceptance Checkbox
  └─ Submit Application
      ↓
Success Screen
  ├─ Application ID
  ├─ Status: Pending/Approved/Rejected
  └─ Done Button (status check)
```

## BLoC Implementation

### Key Events (18 total)
| Event | Screen | Purpose |
|-------|--------|---------|
| `UpdatePersonalDetailsEvent` | 1 | Update personal info |
| `DetectLocationEvent` | 1 | Auto-detect GPS location |
| `UpdateLocationEvent` | 1 | Manually update location |
| `UpdateGSTINEvent` | 2 | Update GSTIN number |
| `UpdateFSSAIEvent` | 2 | Update FSSAI number |
| `UpdateGSTINFileEvent` | 2 | Select GSTIN document |
| `UpdateFSSAIFileEvent` | 2 | Select FSSAI document |
| `ValidateAndProceedToBankDetailsEvent` | 2 | Validate & navigate |
| `UpdateBankDetailsEvent` | 3 | Update bank info |
| `UpdateCancelledChequeFileEvent` | 3 | Select cheque document |
| `LookupIFSCEvent` | 3 | Auto-fetch branch name |
| `ValidateAndProceedToTermsEvent` | 3 | Validate & navigate |
| `ToggleTermsAcceptanceEvent` | 4 | Toggle terms checkbox |
| `ValidateAndSubmitRegistrationEvent` | 4 | Validate & submit |
| `AcceptTermsEvent` | 4 | Accept terms |
| `UploadDocumentEvent` | 2,3 | Upload document |
| `SubmitRegistrationEvent` | 4 | Submit to backend |
| `ResetRegistrationEvent` | Any | Reset all data |

### Key States (14 total)
| State | Description | Usage |
|-------|-------------|-------|
| `RegistrationInitial` | Initial empty state | App start |
| `RegistrationLoading` | Processing | Async operations |
| `RegistrationDataUpdated` | Data updated | After any field change |
| `DocumentUploadInProgress` | Uploading | During upload |
| `DocumentUploadSuccess` | Upload complete | After upload |
| `DocumentUploadFailed` | Upload error | Upload failed |
| `LocationDetecting` | Detecting GPS | Location fetching |
| `LocationUpdated` | Location set | GPS success |
| `LocationError` | Location failed | GPS error |
| `LocationPermissionDenied` | No permission | Permission denied |
| `LocationPermissionPermanentlyDenied` | Blocked | Permanently blocked |
| `ValidationError` | Validation failed | Form errors |
| `NavigateToNextScreen` | Navigate | Screen transition |
| `IFSCLookupSuccess` | IFSC found | Branch auto-filled |
| `RegistrationSubmitting` | Submitting | Final submission |
| `RegistrationSuccess` | Submitted | Success |
| `RegistrationFailed` | Failed | Error |

## Data Model

### HubRegistrationModel
```dart
class HubRegistrationModel {
  // Personal Details
  final String fullName;
  final String mobileNumber;
  final String email;
  final String panCard;
  final String shopName;
  final String shopAddress;
  final double? latitude;
  final double? longitude;
  
  // Business Documents
  final String gstinNumber;
  final String? gstinDocUrl;
  final String? gstinFilePath;      // Local file path
  final String fssaiNumber;
  final String? fssaiDocUrl;
  final String? fssaiFilePath;      // Local file path
  
  // Bank Details
  final String bankAccountHolderName;
  final String bankAccountNumber;
  final String ifscCode;
  final String? branchName;
  final String? cancelledChequeUrl;
  final String? cancelledChequeFilePath;  // Local file path
  
  // Terms & Status
  final bool termsAccepted;
  final String status;              // 'pending', 'approved', 'rejected'
  final DateTime? submittedAt;
  final String? ownerUid;
  final String? tempId;
}
```

## Screens

### 1. Personal Details Screen

**Fields:**
- Full Name (2-50 characters, letters only)
- Mobile Number (10 digits, 6-9 prefix)
- Email (valid email format)
- PAN Card (ABCDE1234F format)
- Shop/Hub Name (3-100 characters)
- Shop Address (multiline, max 200 chars)
- Location (GPS with manual fallback)

**Features:**
- Auto-detect location button
- Location permission handling
- Real-time validation
- Back button to login
- Progress indicator (1/4)

**BLoC Integration:**
- Dispatches `UpdatePersonalDetailsEvent` on save
- Listens to `DocumentsNavigateToNextScreen` for navigation

### 2. Business Documents Screen

**Fields:**
- GSTIN Number (15 chars, specific format)
- GSTIN Document Upload
- FSSAI License Number (14 digits)
- FSSAI Document Upload

**Features:**
- Document upload with preview
- Upload progress tracking
- File validation
- Section headers with icons
- Progress indicator (2/4)

**BLoC Integration:**
- Dispatches `UpdateGSTINFileEvent`/`UpdateFSSAIFileEvent` on file selection
- Dispatches `ValidateAndProceedToBankDetailsEvent` on continue
- Listens to `DocumentUploadInProgress`/`Success`/`Failed`
- Auto-triggers `UploadDocumentEvent` after file selection

**Zero setState:**
- File state from `data.gstinFilePath`/`data.fssaiFilePath`
- Loading state from `state is DocumentUploadInProgress`
- All managed by BLoC ✅

### 3. Bank Details Screen

**Fields:**
- Account Holder Name
- Account Number (9-18 digits)
- Confirm Account Number (must match)
- IFSC Code (11 chars, specific format)
- Branch Name (auto-filled)
- Cancelled Cheque Upload

**Features:**
- IFSC auto-lookup (mock)
- Account number confirmation
- Cheque upload with preview
- Info card explaining requirements
- Progress indicator (3/4)

**BLoC Integration:**
- Dispatches `LookupIFSCEvent` when IFSC entered
- Dispatches `UpdateCancelledChequeFileEvent` on file selection
- Dispatches `ValidateAndProceedToTermsEvent` on continue
- Listens to `IFSCLookupSuccess` to update branch field

**Zero setState:**
- File state from `data.cancelledChequeFilePath`
- Branch name updated via `IFSCLookupSuccess` state
- All managed by BLoC ✅

### 4. Terms & Submit Screen

**Content:**
- Terms of Service (from `AppContent`)
- Commission Policy (from `AppContent`)
- Acceptance checkbox
- Important verification notice

**Features:**
- Scrollable terms cards
- Terms acceptance tracking
- Submission with validation
- Progress indicator (4/4)

**BLoC Integration:**
- Dispatches `ToggleTermsAcceptanceEvent` on checkbox
- Dispatches `ValidateAndSubmitRegistrationEvent` on submit
- Terms state from `data.termsAccepted`
- Content from `AppContent` constants

**Zero setState:**
- Terms acceptance from `data.termsAccepted`
- Changed from StatefulWidget to StatelessWidget
- All managed by BLoC ✅

### 5. Success Screen

**Display:**
- Success icon and message
- Application ID (from BLoC state)
- Info cards (verification, notification, support)
- Done button with status check

**Features:**
- Application status checking
- Status dialog (Pending/Approved/Rejected)
- Navigation based on status
- Support contact info

**Status Check:**
- Currently hardcoded as 'pending'
- Shows warning dialog before home navigation
- TODO: Query real status from backend

## Validation Rules

### Personal Details
- **Name:** 2-50 chars, letters and spaces only
- **Mobile:** 10 digits, starts with 6-9
- **Email:** Valid email format
- **PAN:** 5 letters + 4 digits + 1 letter (uppercase)
- **Shop Name:** 3-100 characters
- **Address:** Required, max 200 chars

### Business Documents
- **GSTIN:** 15 chars, format: `\d{2}[A-Z]{5}\d{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}`
- **FSSAI:** Exactly 14 digits
- **Documents:** Required files

### Bank Details
- **Account Number:** 9-18 digits
- **IFSC:** 11 chars, format: `[A-Z]{4}0[A-Z0-9]{6}`
- **Cheque:** Required file

### Terms
- **Acceptance:** Must be checked

## Routes

### Available Routes
- `/registration/personal-details` - Step 1
- `/registration/business-documents` - Step 2
- `/registration/bank-details` - Step 3
- `/registration/terms-and-submit` - Step 4
- `/registration/success` - Success screen

### Navigation Flow
```
Login (Auth) 
    ↓
Personal Details (can go ← back to login)
    ↓
Business Documents
    ↓
Bank Details
    ↓
Terms & Submit
    ↓
Success (status check on Done)
```

## State Management Philosophy

### Why Zero setState?
1. **Single Source of Truth:** All data in BLoC state
2. **Testability:** Business logic separate from UI
3. **Predictability:** State changes explicit via events
4. **Maintainability:** Clear separation of concerns
5. **Reusability:** Logic not tied to widgets
6. **Persistence:** State survives rebuilds

### Architecture Pattern
```
User Interaction
    ↓
Dispatch Event
    ↓
BLoC Event Handler
    ↓
Update State / Emit New State
    ↓
UI Rebuilds
    ↓
Display Updated State
```

## Document Upload

### Current Implementation (Mock)
```dart
// Simulates upload with progress
for (double progress = 0.0; progress <= 1.0; progress += 0.25) {
  await Future.delayed(Duration(milliseconds: 200));
  emit(DocumentUploadInProgress(..., progress: progress));
}

// Mock URL
final url = 'mock://storage/{documentType}/{timestamp}';
```

### Future Implementation (Firebase)
```dart
// TODO: Real Firebase upload
final ref = FirebaseStorage.instance
    .ref()
    .child('documents/${userId}/${documentType}');

final task = ref.putFile(file);

task.snapshotEvents.listen((snapshot) {
  final progress = snapshot.bytesTransferred / snapshot.totalBytes;
  emit(DocumentUploadInProgress(..., progress: progress));
});

final downloadUrl = await task.snapshot.ref.getDownloadURL();
```

## Integration

### Provider Setup (main.dart)
```dart
BlocProvider(
  create: (_) => RegistrationBloc(),
)
```

### Usage in Screens
```dart
// Dispatch event
context.read<RegistrationBloc>().add(
  UpdatePersonalDetailsEvent(...)
);

// Listen and build
BlocConsumer<RegistrationBloc, RegistrationState>(
  listener: (context, state) {
    if (state is NavigateToNextScreen) {
      Navigator.pushNamed(context, state.routeName);
    }
  },
  builder: (context, state) {
    final data = context.read<RegistrationBloc>().currentData;
    // Build UI with data
  },
)
```

## Dependencies
- `flutter_bloc`: State management
- `equatable`: Value equality
- `geolocator`: Location services
- `permission_handler`: Permission management
- `image_picker`: Document selection (TODO)
- Custom widgets from `core/widgets/`

## Content Management

### Static Content
All static text moved to `/core/constants/app_content.dart`:
- Terms of Service
- Commission Policy
- Verification messages
- Support contact info
- App metadata

**Benefits:**
- Centralized content management
- Easy to update
- Ready for localization
- No hardcoded strings in UI

## Refactoring History

### All Screens Refactored to BLoC
| Screen | setState Before | setState After | Status |
|--------|----------------|----------------|--------|
| Personal Details | - | 0 | ✅ Never had setState |
| Business Documents | 6 | 0 | ✅ Refactored |
| Bank Details | 5 | 0 | ✅ Refactored |
| Terms & Submit | 1 | 0 | ✅ Refactored |
| **TOTAL** | **12** | **0** | **✅ 100% BLoC** |

## Error Handling

### Validation Errors
- Displayed via `ValidationError` state
- SnackBars for user feedback
- Form-level validation
- Field-level validation

### Upload Errors
- `DocumentUploadFailed` state
- Error message in SnackBar
- Retry capability

### Location Errors
- Permission denied → Show settings dialog
- Location unavailable → Manual entry
- Timeout → Fallback to manual

## Performance Considerations
- Single BLoC instance for entire flow
- Immutable states (Equatable)
- Only rebuilds on state change
- Form controllers properly disposed
- Async operations with loading states

## Testing

### Manual Testing Workflow
1. Login with any phone
2. Complete Step 1 (Personal Details)
3. Upload GSTIN and FSSAI docs (Step 2)
4. Enter bank details and upload cheque (Step 3)
5. Accept terms and submit (Step 4)
6. View success screen
7. Click Done → See "Approval Pending" dialog

### Test Cases to Implement
- [ ] Valid/invalid form inputs
- [ ] Document upload success/failure
- [ ] Location permission flows
- [ ] IFSC lookup  
- [ ] Terms acceptance validation
- [ ] Navigation flows
- [ ] State persistence
- [ ] Error recovery

## Changelog

### v1.0.0 (Current)
- ✅ Created 4-step registration wizard
- ✅ Implemented RegistrationBloc with 18 events, 14 states
- ✅ Personal details with GPS location
- ✅ Business document uploads (mock)
- ✅ Bank details with IFSC lookup (mock)
- ✅ Terms acceptance from centralized content
- ✅ Success screen with status checking
- ✅ **Refactored all screens to BLoC (0 setState)**
- ✅ Added back button to personal details
- ✅ Application status check before home navigation

## Related Features
- **Auth Feature**: `/features/auth/` - Handles login before registration
- **Core**: `/core/` - Shared widgets, utils, constants

## API Integration (TODO)

### Endpoints Needed
```
POST /registration/create
  Request: HubRegistrationModel
  Response: { applicationId: string, status: string }

POST /documents/upload
  Request: FormData (file)
  Response: { url: string }

GET /registration/status/{applicationId}
  Response: { status: 'pending'|'approved'|'rejected', message: string }

POST /location/verify
  Request: { latitude: number, longitude: number }
  Response: { address: string, city: string, state: string }

GET /ifsc/{code}
  Response: { bank: string, branch: string, address: string }
```

## Notes
- All phone numbers Indian format (+91)
- Documents: PDF/JPEG/PNG (max 5MB each)
- Location permission required for verification
- Application reviewed within 24-48 hours
- Commission: 5% per order, 2% payment processing
