# 🧭 Routing System Documentation

## Overview

This project uses a **centralized, feature-based routing system**  with named routes and BLoC for data sharing between screens.

---

## 📁 Structure

```
lib/
├── core/
│   └── routes/
│       ├── route_constants.dart      # Global route constants
│       └── app_routes.dart           # Centralized route configuration
└── features/
    └── registration/
        └── presentation/
            └── routes/
                └── registration_routes.dart  # Feature-specific routes
```

---

## 🎯 Key Principles

### 1. **Named Routes Only**
❌ **Don't do this:**
```dart
Navigator.push(context, MaterialPageRoute(builder: (_) => MyScreen()));
Navigator.pushNamed(context, '/some-route');  // Hardcoded string
```

✅ **Do this:**
```dart
Navigator.pushNamed(context, RegistrationRoutes.personalDetails);
```

### 2. **Data Sharing via BLoC, Not Arguments**
❌ **Don't do this:**
```dart
Navigator.pushNamed(context, '/next', arguments: myData);
```

✅ **Do this:**
```dart
// Update BLoC state
context.read<RegistrationBloc>().add(UpdateDataEvent(...));

// Navigate
Navigator.pushNamed(context, RegistrationRoutes.next);

// Read from BLoC in next screen
BlocBuilder<RegistrationBloc, RegistrationState>(
  builder: (context, state) {
    final data = state.someData;
    // Use data
  },
)
```

### 3. **Feature-Specific Route Constants**
Each feature manages its own route constants in its feature folder.

---

## 📋 Route Constants Organization

### Global Routes (`lib/core/routes/route_constants.dart`)
```dart
class RouteConstants {
  static const String home = '/';
  static const String splash = '/splash';
  // Add app-level routes here
}
```

### Feature Routes (`lib/features/{feature}/presentation/routes/{feature}_routes.dart`)
```dart
class RegistrationRoutes {
  static const String personalDetails = '/registration/personal-details';
  static const String businessDocuments = '/registration/business-documents';
  // Feature-specific routes
}
```

---

## 🛠️ How to Add a New Route

### Step 1: Define Route Constant

**For feature-specific route:**
```dart
// lib/features/products/presentation/routes/product_routes.dart
class ProductRoutes {
  static const String list = '/products';
  static const String details = '/products/details';
  static const String add = '/products/add';
}
```

**For app-level route:**
```dart
// lib/core/routes/route_constants.dart
class RouteConstants {
  static const String profile = '/profile';
}
```

### Step 2: Register Route in AppRoutes

```dart
// lib/core/routes/app_routes.dart
import '../../features/products/presentation/routes/product_routes.dart';
import '../../features/products/presentation/pages/product_list_screen.dart';

static Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ProductRoutes.list:
      return MaterialPageRoute(
        builder: (_) => const ProductListScreen(),
        settings: settings,
      );
    // ... other routes
  }
}
```

### Step 3: Navigate Using Constant

```dart
Navigator.pushNamed(context, ProductRoutes.list);
```

---

## 🚀 Navigation Examples

### Simple Navigation
```dart
Navigator.pushNamed(context, RegistrationRoutes.businessDocuments);
```

### Replace Current Screen
```dart
Navigator.pushReplacementNamed(context, RegistrationRoutes.success);
```

### Clear Stack and Navigate
```dart
Navigator.pushNamedAndRemoveUntil(
  context,
  RouteConstants.home,
  (route) => false, // Remove all previous routes
);
```

### Navigate Back
```dart
Navigator.pop(context);
```

---

## 📦 Data Sharing Patterns

### Pattern 1: Update BLoC Before Navigation
```dart
// Screen A - Update data in BLoC, then navigate
void _goToNextScreen() {
  context.read<RegistrationBloc>().add(
    UpdatePersonalDetailsEvent(
      ownerName: _nameController.text,
      mobileNumber: _mobileController.text,
    ),
  );
  
  Navigator.pushNamed(context, RegistrationRoutes.businessDocuments);
}
```

### Pattern 2: Read from BLoC in Destination Screen
```dart
// Screen B - Read data from BLoC
class BusinessDocumentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        // Access data from BLoC state
        final personalDetails = state.registrationData;
        
        return Scaffold(
          // Use personalDetails...
        );
      },
    );
  }
}
```

### Pattern 3: Navigate on State Change
```dart
BlocListener<RegistrationBloc, RegistrationState>(
  listener: (context, state) {
    if (state is RegistrationSuccess) {
      // Data is in state, not passed as argument
      Navigator.pushNamedAndRemoveUntil(
        context,
        RegistrationRoutes.success,
        (route) => false,
      );
    }
  },
  child: // Your widget
)
```

---

## 🏗️ Current Route Map

### App-Level Routes
| Constant | Path | Screen |
|----------|------|---------|
| `RouteConstants.home` | `/` | Home Screen (placeholder) |

### Registration Routes
| Constant | Path | Screen |
|----------|------|---------|
| `RegistrationRoutes.personalDetails` | `/registration/personal-details` | Personal Details |
| `RegistrationRoutes.businessDocuments` | `/registration/business-documents` | Business Documents |
| `RegistrationRoutes.bankDetails` | `/registration/bank-details` | Bank Details |
| `RegistrationRoutes.termsAndSubmit` | `/registration/terms-and-submit` | Terms & Submit |
| `RegistrationRoutes.success` | `/registration/success` | Success Screen |

---

## ⚙️ Configuration in main.dart

```dart
MaterialApp(
  // Use centralized routing
  initialRoute: AppRoutes.getInitialRoute(),
  onGenerateRoute: AppRoutes.onGenerateRoute,
  onUnknownRoute: (settings) {
    // 404 handler
  },
)
```

---

## ✅ Benefits of This Approach

### 1. **Type Safety**
- No typos in route strings
- IDE autocomplete for route names
- Compile-time error if route doesn't exist

### 2. **Centralized Management**
- All routes defined in one place
- Easy to see all app routes
- Easy to refactor route paths

### 3. **Feature Isolation**
- Each feature manages its own routes
- No cross-feature route dependencies
- Easy to add/remove features

### 4. **Data Consistency**
- Single source of truth (BLoC)
- No data loss on navigation
- Easy to debug data flow

### 5. **Testability**
- Mock navigation easily
- Test route logic separately
- Test data flow through BLoC

---

## 🔍 Debugging Tips

### Check Current Route
```dart
String? currentRoute = ModalRoute.of(context)?.settings.name;
print('Current route: $currentRoute');
```

### Monitor Route Changes
```dart
MaterialApp(
  onGenerateRoute: (settings) {
    print('Navigating to: ${settings.name}');
    return AppRoutes.onGenerateRoute(settings);
  },
)
```

### Check BLoC State
```dart
context.read<RegistrationBloc>().stream.listen((state) {
  print('BLoC State: $state');
});
```

---

## 🚨 Common Mistakes to Avoid

### ❌ Mistake 1: Hardcoded Strings
```dart
Navigator.pushNamed(context, '/registration/personal-details');  // DON'T
```

### ✅ Solution:
```dart
Navigator.pushNamed(context, RegistrationRoutes.personalDetails);  // DO
```

---

### ❌ Mistake 2: Passing Data via Arguments
```dart
Navigator.pushNamed(context, '/next', arguments: myData);  // DON'T
final data = ModalRoute.of(context)!.settings.arguments;  // DON'T
```

### ✅ Solution:
```dart
// Update BLoC
context.read<MyBloc>().add(UpdateEvent(myData));
// Navigate
Navigator.pushNamed(context, MyRoutes.next);
// Read in next screen
BlocBuilder<MyBloc, MyState>(...)
```

---

### ❌ Mistake 3: Multiple BLoC Providers
```dart
// Don't create new BLoC instance per screen
BlocProvider(
  create: (_) => RegistrationBloc(),  // DON'T
  child: MyScreen(),
)
```

### ✅ Solution:
```dart
// Provide BLoC once in main.dart
// Access it anywhere with context.read<RegistrationBloc>()
```

---

## 📚 Future Enhancements

1. **Deep Linking**: Add URI pattern matching
2. **Route Guards**: Add authentication checks
3. **Analytics**: Track route navigation
4. **Transitions**: Custom route animations
5. **Web Support**: Handle browser URL changes

---

## 🎯 Quick Reference

### Navigate Forward
```dart
Navigator.pushNamed(context, FeatureRoutes.screen);
```

### Navigate Back
```dart
Navigator.pop(context);
```

### Replace Current
```dart
Navigator.pushReplacementNamed(context, FeatureRoutes.screen);
```

### Clear Stack
```dart
Navigator.pushNamedAndRemoveUntil(context, RouteConstants.home, (route) => false);
```

### Update BLoC
```dart
context.read<MyBloc>().add(MyEvent(...));
```

### Read BLoC
```dart
BlocBuilder<MyBloc, MyState>(
  builder: (context, state) => ...
)
```

---

**Remember: Routes for navigation, BLoC for data!** 🎯
