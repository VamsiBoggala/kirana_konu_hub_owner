# Theme System Documentation

## Overview
The Kirana Konu Hub Owner app has a comprehensive theme system that supports both **Light** and **Dark** modes, following the design specifications from ARCHITECTURE.md.

## Features
- ✅ Light & Dark theme support
- ✅ System theme detection (follows device settings)
- ✅ Persistent theme preference (saved locally)
- ✅ Royal Blue (#1565C0) primary color
- ✅ Poppins font for headings
- ✅ Roboto font for body text
- ✅ Material 3 design system

## File Structure
```
lib/
├── core/
│   ├── constants/
│   │   └── app_colors.dart      # All color constants
│   └── theme/
│       ├── app_theme.dart       # Light & Dark theme definitions
│       └── theme_provider.dart  # State management for theme
└── main.dart                    # App entry point with theme setup
```

## Color System

### Primary Colors
- **Primary Blue**: #1565C0 (Royal Blue)
- **Primary Blue Dark**: #0D47A1
- **Primary Blue Light**: #1976D2

### Light Theme
- **Background**: #F5F5F5
- **Card**: #FFFFFF
- **Text**: #212121
- **Text Secondary**: #757575

### Dark Theme
- **Background**: #121212
- **Card**: #1E1E1E
- **Text**: #E0E0E0
- **Text Secondary**: #B0B0B0

### Semantic Colors
- **Success/Credit Good**: #4CAF50 (Green)
- **Error/Credit Bad**: #F44336 (Red)
- **Warning**: #FF9800
- **Info**: #2196F3

### Stock Status
- **In Stock**: #4CAF50 (Green)
- **Out of Stock**: #9E9E9E (Grey)

## Usage

### 1. Switching Themes Programmatically

```dart
import 'package:provider/provider.dart';
import 'core/theme/theme_provider.dart';

// In your widget
final themeProvider = Provider.of<ThemeProvider>(context);

// Set light theme
themeProvider.setLightTheme();

// Set dark theme
themeProvider.setDarkTheme();

// Set system theme (follows device settings)
themeProvider.setSystemTheme();

// Toggle between themes
themeProvider.toggleTheme();
```

### 2. Using Theme Colors in Widgets

```dart
// Get current theme
final theme = Theme.of(context);

// Use theme colors
Container(
  color: theme.colorScheme.primary,
  child: Text(
    'Hello',
    style: theme.textTheme.titleLarge,
  ),
)
```

### 3. Using Predefined Colors

```dart
import 'package:hub_owner/core/constants/app_colors.dart';

// Use specific colors
Container(
  color: AppColors.primaryBlue,
  child: Text(
    'Status',
    style: TextStyle(color: AppColors.creditGood),
  ),
)
```

### 4. Text Styles

The theme includes predefined text styles:

```dart
// Headings (Poppins)
Text('Title', style: theme.textTheme.displayLarge)    // 32px, Bold
Text('Title', style: theme.textTheme.displayMedium)   // 28px, Bold
Text('Title', style: theme.textTheme.displaySmall)    // 24px, SemiBold
Text('Title', style: theme.textTheme.headlineLarge)   // 22px, SemiBold
Text('Title', style: theme.textTheme.headlineMedium)  // 20px, SemiBold
Text('Title', style: theme.textTheme.headlineSmall)   // 18px, SemiBold

// Body text (Roboto)
Text('Body', style: theme.textTheme.bodyLarge)        // 16px, Normal
Text('Body', style: theme.textTheme.bodyMedium)       // 14px, Normal
Text('Body', style: theme.textTheme.bodySmall)        // 12px, Normal
```

## Testing the Theme

Run the app to see the theme system in action:

```bash
flutter run
```

The demo home screen includes:
- Theme toggle button in the app bar
- Theme mode selector buttons (Light/Dark/System)
- Sample cards showing the theme styling
- Floating action button with theme info dialog

## Theme Persistence

The app automatically saves the user's theme preference using `SharedPreferences`. When the app reopens, it will restore the last selected theme mode.

## Business Rule Integration

The color system includes specific colors for business rules:

### Credit System
```dart
// Green: Balance < Limit (Allow Order)
color: AppColors.creditGood

// Red: Balance > Limit (Block Order)
color: AppColors.creditBad
```

### Inventory Status
```dart
// In Stock
color: AppColors.inStock

// Out of Stock
color: AppColors.outOfStock
```

## Next Steps

Now that the theme system is set up, you can:
1. Build the login screen with themed components
2. Create product management screens
3. Implement retailer approval lists
4. All new screens will automatically support both themes!
