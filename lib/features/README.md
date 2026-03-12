# Features Directory

This directory contains all feature modules for the Kirana Konu Hub Owner application. Each feature is organized following Clean Architecture principles with separation between presentation, domain, and data layers.

## Feature Organization

Each feature follows this structure:
```
feature_name/
├── README.md              # Feature-specific documentation
├── data/
│   └── models/            # Data models and DTOs
├── domain/                # Business logic layer
└── presentation/
    ├── bloc/              # BLoC state management
    ├── pages/             # UI screens
    └── routes/            # Route constants
```

## Available Features

### 🔐 [Auth](./auth/README.md)
**Purpose:** User authentication and session management

**Screens:**
- Login Screen (phone + OTP)

**Key Features:**
- Phone number authentication
- OTP verification
- Session management
- Auto-routing based on registration status

**Status:** ✅ Implemented (Mock)

---

### 📝 [Registration](./registration/README.md)
**Purpose:** Hub owner onboarding and KYB verification

**Screens:**
- Personal Details Screen (Step 1/4)
- Business Documents Screen (Step 2/4)
- Bank Details Screen (Step 3/4)
- Terms & Submit Screen (Step 4/4)
- Registration Success Screen

**Key Features:**
- 4-step registration wizard
- Personal info collection with GPS
- Business document uploads (GSTIN, FSSAI)
- Bank details with IFSC lookup
- Terms acceptance
- Application status tracking
- **100% BLoC-driven (0 setState calls)**

**Status:** ✅ Implemented (Mock uploads)

---

## Future Features (Planned)

### 🏠 Home / Dashboard
- Hub overview
- Quick stats
- Recent orders
- Notifications

### 📦 Inventory Management
- Product catalog
- Stock management
- Bulk actions
- Low stock alerts

### 🛒 Order Management
- Order list
- Order details
- Status updates
- Order history

### 💰 Financial Management
- Transaction history
- Payouts
- Commission breakdown
- Reports

### 👤 Profile Management
- Profile editing
- Settings
- Preferences
- Support

### 🔔 Notifications
- Push notifications
- In-app notifications
- Notification preferences

## Cross-Feature Dependencies

### Shared Resources
All features use shared resources from `/core/`:
- **Widgets:** `CustomButton`, `CustomTextField`, `DocumentUploadWidget`
- **Utils:** `Validators`, helpers
- **Constants:** `AppContent`, routes
- **Theme:** `AppTheme`, color schemes
- **Routes:** Central routing via `app_routes.dart`

### BLoC Providers
All BLoCs are provided at app level in `main.dart`:
```dart
MultiProvider(
  providers: [
    BlocProvider(create: (_) => AuthBloc()),
    BlocProvider(create: (_) => RegistrationBloc()),
    // Future BLoCs will be added here
  ],
)
```

## Feature Development Guidelines

### When Adding a New Feature:

1. **Create Directory Structure**
   ```bash
   mkdir -p lib/features/feature_name/{data/models,domain,presentation/{bloc,pages,routes}}
   ```

2. **Create README.md**
   - Copy template from existing feature
   - Document architecture, screens, flows
   - List dependencies and integrations
   - Add testing instructions

3. **Implement BLoC Pattern**
   - Create events, states, bloc files
   - Follow existing naming conventions
   - Use Equatable for equality checks
   - Register in main.dart

4. **Create Screens**
   - Follow existing UI patterns
   - Use shared widgets from `/core/`
   - Implement BlocConsumer for state management
   - **Avoid setState - use BLoC only**

5. **Add Routes**
   - Define route constants in feature routes file
   - Register in `app_routes.dart`
   - Update navigation flows

6. **Update README**
   - Keep feature README.md updated
   - Document any changes
   - Add new screens/flows
   - Update API endpoints

7. **Testing**
   - Write unit tests for BLoC
   - Add widget tests for screens
   - Manual testing checklist
   - Update test documentation

### Code Style Guidelines

**BLoC Pattern:**
- Events: `<Feature><Action>Event` (e.g., `LoginWithPhoneEvent`)
- States: `<Feature><Status>` (e.g., `AuthCheckingStatus`)
- Bloc: `<Feature>Bloc` (e.g., `AuthBloc`)

**Screen Naming:**
- Format: `<purpose>_screen.dart`
- Class: `<Purpose>Screen`
- Example: `login_screen.dart` → `LoginScreen`

**Routes:**
- Constant: `static const String routeName = '/feature/screen';`
- Lowercase with hyphens
- Example: `/registration/business-documents`

**Widgets:**
- Stateless preferred
- BlocConsumer for state listening
- Proper disposal of controllers
- Extract reusable widgets to `/core/widgets/`

## Architecture Principles

### 1. Single Responsibility
Each feature handles one specific domain area

### 2. Separation of Concerns
- **Presentation:** UI and user interactions
- **Domain:** Business logic and rules
- **Data:** Models and data sources

### 3. State Management
- BLoC for all state management
- No setState in production code
- Immutable states
- Clear event → state flow

### 4. Dependency Rule
- Features can depend on `/core/`
- Features should NOT depend on other features
- Keep features isolated and modular

### 5. Testing
- Unit tests for BLoCs
- Widget tests for screens
- Integration tests for flows
- Mock external dependencies

## Documentation Standards

### Feature README Must Include:
- ✅ Overview and purpose
- ✅ Directory structure
- ✅ Features list (implemented + TODO)
- ✅ BLoC implementation details
- ✅ Screen descriptions
- ✅ User flows
- ✅ Data models
- ✅ Routes
- ✅ Dependencies
- ✅ Integration points
- ✅ Testing instructions
- ✅ Changelog
- ✅ Future enhancements

### Keep Documentation Updated:
- Update README when adding screens
- Document new events/states
- Update flows for navigation changes
- Add notes for breaking changes
- Maintain changelog

## Testing Strategy

### Per Feature:
- BLoC unit tests (events → states)
- Screen widget tests
- Integration tests for complete flows
- Mock external dependencies

### Cross-Feature:
- Navigation flow tests
- State sharing tests
- Route tests

## Migration & Refactoring

### Current Status:
- ✅ Auth - Fully BLoC-driven
- ✅ Registration - Fully BLoC-driven (0 setState)

### Best Practices:
1. Identify local state (`setState` usage)
2. Create corresponding events
3. Move logic to BLoC event handlers
4. Create/update states as needed
5. Replace StatefulWidget with StatelessWidget
6. Use BlocConsumer/BlocBuilder
7. Test thoroughly
8. Update documentation

## Performance Monitoring

### Key Metrics to Track:
- BLoC rebuild frequency
- State emission rate
- Memory usage per feature
- Navigation timing
- API response times

### Optimization Tips:
- Use Equatable for state comparison
- Avoid unnecessary rebuilds
- Dispose resources properly
- Use const widgets where possible
- Lazy load heavy features

## Troubleshooting

### Common Issues:

**BLoC not receiving events:**
- Check if BLoC is provided in widget tree
- Verify event dispatching: `context.read<Bloc>().add(event)`

**State not updating UI:**
- Ensure state extends Equatable
- Check if props includes all fields
- Verify BlocBuilder/BlocConsumer usage

**Navigation not working:**
- Check route registration in app_routes.dart
- Verify route constants match
- Ensure NavigateToNextScreen state is handled

**Memory leaks:**
- Dispose controllers in dispose()
- Close BLoC streams if custom implementation
- Remove listeners properly

## Contact & Support

For feature-specific questions, refer to individual feature README files.

For general architecture questions, contact the development team.
