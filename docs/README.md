# 📚 Documentation Index

## Project Documentation

### Main Architecture
- **[ARCHITECTURE.md](../ARCHITECTURE.md)** - Overall project architecture and business rules
- **[THEME_SETUP.md](../THEME_SETUP.md)** - Theme configuration guide

---

## Feature Documentation

### Registration Flow
All registration-related documentation is in `docs/registration/`:

1. **[QUICK_START.md](registration/QUICK_START.md)** - Quick setup guide
   - Firebase setup
   - Permissions configuration
   - Running the app
   - Testing checklist

2. **[REGISTRATION_ARCHITECTURE.md](registration/REGISTRATION_ARCHITECTURE.md)** - Deep technical dive
   - BLoC pattern explanation
   - Project structure
   - Components breakdown
   - Firebase integration
   - Validation flow

3. **[IMPLEMENTATION_SUMMARY.md](registration/IMPLEMENTATION_SUMMARY.md)** - Visual summary
   - What was built
   - Metrics and achievements
   - Feature checklist

4. **[HUB_REGISTRATION.md](../lib/features/registration/HUB_REGISTRATION.md)** - Original requirements
   - KYB requirements
   - UI flow specs
   - Backend logic

---

## Quick Links

### Getting Started
1. Read [ARCHITECTURE.md](../ARCHITECTURE.md) for project overview
2. Follow [docs/registration/QUICK_START.md](registration/QUICK_START.md) for registration setup
3. Check [THEME_SETUP.md](../THEME_SETUP.md) for theming

### Development
- **Registration BLoC**: `lib/features/registration/presentation/bloc/`
- **Reusable Widgets**: `lib/core/widgets/`
- **Validators**: `lib/core/utils/validators.dart`

---

## Folder Structure

```
hub_owner/
├── docs/                           # 📚 All documentation
│   ├── README.md                   # This file
│   └── registration/               # Registration feature docs
│       ├── QUICK_START.md
│       ├── REGISTRATION_ARCHITECTURE.md
│       └── IMPLEMENTATION_SUMMARY.md
│
├── lib/
│   ├── core/                       # Shared across app
│   │   ├── constants/
│   │   ├── theme/
│   │   ├── utils/
│   │   └── widgets/
│   │
│   └── features/                   # Feature-first architecture
│       └── registration/
│           ├── HUB_REGISTRATION.md # Feature requirements
│           ├── data/
│           ├── domain/
│           └── presentation/
│
├── ARCHITECTURE.md                 # Main project architecture
├── THEME_SETUP.md                  # Theme docs
└── pubspec.yaml
```

---

**Note:** This structure follows **Feature-First Architecture** where each feature (`registration`, future: `products`, `orders`) contains its own data, domain, and presentation layers.
