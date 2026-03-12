# 🚀 REGISTRATION FLOW - QUICK START GUIDE

## ✅ What's Been Created

### 📁 **17 Files Created**

#### **Core Widgets** (Reusable across app)
1. `lib/core/widgets/custom_text_field.dart` - Text input widget
2. `lib/core/widgets/custom_button.dart` - Button widget
3. `lib/core/widgets/document_upload_widget.dart` - File upload widget

#### **Core Utilities**
4. `lib/core/utils/validators.dart` - Form validation logic

#### **Data Layer**
5. `lib/features/registration/data/models/hub_registration_model.dart` - Data model

#### **BLoC Layer** (State Management)
6. `lib/features/registration/presentation/bloc/registration_bloc.dart` - Main logic
7. `lib/features/registration/presentation/bloc/registration_event.dart` - All events
8. `lib/features/registration/presentation/bloc/registration_state.dart` - All states

#### **Presentation Layer** (Screens)
9. `lib/features/registration/presentation/pages/personal_details_screen.dart` - Screen 1
10. `lib/features/registration/presentation/pages/business_documents_screen.dart` - Screen 2
11. `lib/features/registration/presentation/pages/bank_details_screen.dart` - Screen 3
12. `lib/features/registration/presentation/pages/terms_and_submit_screen.dart` - Screen 4
13. `lib/features/registration/presentation/pages/registration_success_screen.dart` - Success

#### **Documentation**
14. `REGISTRATION_ARCHITECTURE.md` - Full architecture documentation
15. `QUICK_START.md` - This file

## 📦 Dependencies Added

```yaml
# State Management
flutter_bloc: ^8.1.6
equatable: ^2.0.5

# Firebase
firebase_core: ^3.9.0
firebase_auth: ^5.3.4
cloud_firestore: ^5.5.2
firebase_storage: ^12.3.8

# File Handling
image_picker: ^1.1.2
file_picker: ^8.1.4

# Location
geolocator: ^13.0.2
permission_handler: ^11.3.1

# Utilities
intl: ^0.19.0
```

## 🔧 Setup Steps

### Step 1: Firebase Setup (Required)

1. **Create Firebase Project**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Create new project
   - Add Android/iOS app

2. **Download Config Files**
   - Android: Download `google-services.json` → Place in `android/app/`
   - iOS: Download `GoogleService-Info.plist` → Place in `ios/Runner/`

3. **Run FlutterFire Configure**
   ```bash
   flutterfire configure
   ```

### Step 2: Permissions Setup

#### Android (`android/app/src/main/AndroidManifest.xml`)
Add inside `<manifest>`:
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.CAMERA"/>
```

#### iOS (`ios/Runner/Info.plist`)
Add inside `<dict>`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to verify your business address</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to upload business documents</string>
<key>NSCameraUsageDescription</key>
<string>We need camera access to capture documents</string>
```

### Step 3: Update `main.dart`

Replace your `main.dart` with:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/registration/presentation/bloc/registration_bloc.dart';
import 'features/registration/presentation/pages/personal_details_screen.dart';
import 'features/registration/presentation/pages/business_documents_screen.dart';
import 'features/registration/presentation/pages/bank_details_screen.dart';
import 'features/registration/presentation/pages/terms_and_submit_screen.dart';
import 'features/registration/presentation/pages/registration_success_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Theme Provider
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        
        // Registration BLoC
        BlocProvider(create: (_) => RegistrationBloc()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Kirana Konu - Hub Owner',
            debugShowCheckedModeBanner: false,
            
            // Theme
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            
            // Routes
            initialRoute: '/registration/personal-details',
            routes: {
              '/registration/personal-details': (context) =>
                  const PersonalDetailsScreen(),
              '/registration/business-documents': (context) =>
                  const BusinessDocumentsScreen(),
              '/registration/bank-details': (context) =>
                  const BankDetailsScreen(),
              '/registration/terms': (context) =>
                  const TermsAndSubmitScreen(),
              '/registration/success': (context) {
                final args = ModalRoute.of(context)?.settings.arguments as String?;
                return RegistrationSuccessScreen(applicationId: args);
              },
            },
          );
        },
      ),
    );
  }
}
```

### Step 4: Run the App

```bash
# Get dependencies
flutter pub get

# Run on your device
flutter run
```

## 🎯 Testing the Flow

### Manual Test Checklist

#### Screen 1: Personal Details
- [ ] Enter valid name (letters only)
- [ ] Enter 10-digit mobile (starts with 6-9)
- [ ] Enter shop name
- [ ] Click "Detect My Location"
- [ ] Grant location permission
- [ ] Verify location shows coordinates
- [ ] Click "Continue"

#### Screen 2: Business Documents
- [ ] Enter valid GSTIN (15 chars, e.g., 27AAPFU0939F1ZV)
- [ ] Upload GSTIN document (JPG/PNG/PDF)
- [ ] Wait for upload progress
- [ ] Enter 14-digit FSSAI number
- [ ] Upload FSSAI document
- [ ] Click "Continue"

#### Screen 3: Bank Details
- [ ] Enter account holder name
- [ ] Enter account number
- [ ] Confirm account number (must match)
- [ ] Enter 11-character IFSC (e.g., SBIN0001234)
- [ ] Upload cancelled cheque
- [ ] Click "Continue"

#### Screen 4: Terms & Submit
- [ ] Read Terms of Service
- [ ] Read Commission Policy
- [ ] Check "I agree" checkbox
- [ ] Click "Submit Application"
- [ ] Verify success screen shows
- [ ] Note application ID

## 🔥 Firestore Data Verification

After submission, check Firebase Console:

1. Go to **Firestore Database**
2. Look for `hubs_pending` collection
3. Find your application document
4. Verify all fields are populated

## 📱 Common Issues & Solutions

### Issue: "Firebase not initialized"
**Solution**: Make sure `firebase_core` is initialized in `main.dart`

### Issue: "Permission denied for location"
**Solution**: 
- Check permissions in manifest/Info.plist
- Run: `flutter clean && flutter pub get`

### Issue: "File upload fails"
**Solution**:
- Check Firebase Storage rules
- Ensure internet connection
- Check file size (<10MB recommended)

### Issue: "GSTIN validation fails"
**Solution**: 
- Format: 2 digits + 5 letters + 4 digits + 1 letter + 1 char + Z + 1 char
- Example: `27AAPFU0939F1ZV`

### Issue: "Navigation not working"
**Solution**: Ensure all routes are defined in `main.dart`

## 🎨 Customization

### Change Primary Color
Edit `lib/core/constants/app_colors.dart`:
```dart
static const Color primaryBlue = Color(0xFF1565C0); // Change this
```

### Add More Validation
Edit `lib/core/utils/validators.dart`:
```dart
static String? validateMyField(String? value) {
  // Your validation logic
}
```

### Add New Document Type
1. Add to `UploadDocumentEvent` in `registration_event.dart`
2. Handle in `_onUploadDocument` in `registration_bloc.dart`
3. Add to model in `hub_registration_model.dart`

## 📊 Architecture Overview

```
User Action → Event → BLoC → State → UI
```

### Example Flow:
1. User enters name → `UpdatePersonalDetailsEvent`
2. BLoC updates `HubRegistrationModel`
3. Emits `RegistrationDataUpdated` state
4. UI rebuilds with new data

## 🚀 Next Steps

### Immediate
1. ✅ Setup Firebase project
2. ✅ Add config files
3. ✅ Update `main.dart`
4. ✅ Test registration flow

### Short-term
- [ ] Add OTP verification for mobile
- [ ] Add image compression before upload
- [ ] Add offline support
- [ ] Add better error messages

### Long-term
- [ ] Add admin approval dashboard
- [ ] Add email notifications
- [ ] Add document verification logic
- [ ] Add analytics tracking

## 💡 Tips

1. **Use DevTools**: Enable Flutter DevTools to inspect BLoC states
2. **Test Validators**: Test edge cases in forms
3. **Monitor Uploads**: Check Firebase Storage for uploaded files
4. **Check Logs**: Use `debugPrint()` for debugging
5. **Hot Reload**: Use `r` in terminal for quick UI changes

## 📚 Learn More

- [BLoC Pattern](https://bloclibrary.dev/)
- [Firebase Flutter](https://firebase.flutter.dev/)
- [Flutter Docs](https://docs.flutter.dev/)

## 🎉 You're All Set!

The registration flow is ready to test. Follow the setup steps above, and you'll have a fully functional KYB registration system!

---

**Need Help?** Check `REGISTRATION_ARCHITECTURE.md` for detailed documentation.
