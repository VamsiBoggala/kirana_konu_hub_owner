import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/utils/validators.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';
import '../bloc/registration_state.dart';
import '../routes/registration_routes.dart';

/// Screen 1: Personal & Location Details
/// Collects owner name, mobile number, shop name, and GPS location
class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _shopNameController = TextEditingController();

  // Focus nodes for explicit focus management
  final _nameFocusNode = FocusNode();
  final _mobileFocusNode = FocusNode();
  final _shopNameFocusNode = FocusNode();

  bool _hasUnfocused = false;

  @override
  void initState() {
    super.initState();

    // Auto-populate mobile number from authenticated user
    final authUser = FirebaseAuth.instance.currentUser;
    if (authUser != null && authUser.phoneNumber != null) {
      // Extract last 10 digits (removing country code if present)
      final phoneNumber = authUser.phoneNumber!;
      final mobileNumber = phoneNumber.length >= 10 ? phoneNumber.substring(phoneNumber.length - 10) : phoneNumber;
      _mobileController.text = mobileNumber;
    }

    // Unfocus after first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_hasUnfocused) {
        _nameFocusNode.unfocus();
        _mobileFocusNode.unfocus();
        _shopNameFocusNode.unfocus();
        _hasUnfocused = true;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _shopNameController.dispose();
    _nameFocusNode.dispose();
    _mobileFocusNode.dispose();
    _shopNameFocusNode.dispose();
    super.dispose();
  }

  void _detectLocation() {
    // Unfocus text fields when detecting location
    FocusScope.of(context).unfocus();

    // Dispatch event to BLoC - all logic is handled there
    context.read<RegistrationBloc>().add(const DetectLocationEvent());
  }

  void _showPermissionDeniedDialog(AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.locationPermissionBlocked, style: Theme.of(context).textTheme.headlineSmall),
        content: Text(l10n.locationPermissionDeniedMessage, style: Theme.of(context).textTheme.bodyMedium),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancel)),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: Text(l10n.openSettings),
          ),
        ],
      ),
    );
  }

  void _proceedToNextScreen(RegistrationState state, AppLocalizations l10n) {
    if (_formKey.currentState!.validate()) {
      // Check if location is detected from BLoC state
      final registrationData = context.read<RegistrationBloc>().currentData;
      if (registrationData.latitude == null || registrationData.longitude == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.locationRequired), backgroundColor: Colors.orange));
        return;
      }

      // Explicitly unfocus all focus nodes to clear focus state
      _nameFocusNode.unfocus();
      _mobileFocusNode.unfocus();
      _shopNameFocusNode.unfocus();
      FocusScope.of(context).unfocus();

      // Update BLoC with personal details
      context.read<RegistrationBloc>().add(
        UpdatePersonalDetailsEvent(
          ownerName: _nameController.text.trim(),
          mobileNumber: _mobileController.text.trim(),
          shopName: _shopNameController.text.trim(),
        ),
      );

      // Navigate to next screen using route constant
      Navigator.pushNamed(context, RegistrationRoutes.businessDocuments);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.personalDetailsTitle),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              // Show confirmation dialog
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
                    ElevatedButton(
                      onPressed: () {
                        // Close dialog
                        Navigator.pop(dialogContext);
                        // Trigger logout
                        context.read<AuthBloc>().add(const LogoutEvent());
                        // Navigate to login screen
                        Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        // Tap anywhere to dismiss keyboard
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocConsumer<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is LocationUpdated) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(l10n.locationSuccess), backgroundColor: Colors.green));
            } else if (state is LocationError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Error: ${state.error}'), backgroundColor: Colors.red));
            } else if (state is LocationPermissionDenied) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    l10n.locationPermissionDeniedMessage,
                  ), // Reuse or create new key for short msg? using deniedMessage for now as it fits
                  backgroundColor: Colors.orange,
                  action: SnackBarAction(
                    label: l10n.settings,
                    textColor: Colors.white,
                    onPressed: () {
                      openAppSettings();
                    },
                  ),
                  duration: const Duration(seconds: 5),
                ),
              );
            } else if (state is LocationPermissionPermanentlyDenied) {
              _showPermissionDeniedDialog(l10n);
            }
          },
          builder: (context, state) {
            // Get registration data from BLoC
            final registrationData = context.read<RegistrationBloc>().currentData;
            final isLocationDetected = registrationData.latitude != null && registrationData.longitude != null;
            final isDetectingLocation = state is LocationDetecting;

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Progress Indicator
                      _buildProgressIndicator(1),
                      const SizedBox(height: 32),

                      // Header Section
                      _buildHeader(l10n),
                      const SizedBox(height: 32),

                      // Form Fields
                      _buildFormFields(l10n),
                      const SizedBox(height: 32),

                      // Location Section
                      _buildLocationSection(
                        isLocationDetected: isLocationDetected,
                        isDetectingLocation: isDetectingLocation,
                        registrationData: registrationData,
                        l10n: l10n,
                      ),
                      const SizedBox(height: 40),

                      // Continue Button
                      _buildContinueButton(state, l10n),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Build Header Section
  Widget _buildHeader(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.personalDetailsHeader, style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 8),
        Text(
          l10n.personalDetailsSubHeader,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
        ),
      ],
    );
  }

  /// Build Form Fields Section
  Widget _buildFormFields(AppLocalizations l10n) {
    return Column(
      children: [
        // Owner Name Field
        CustomTextField(
          label: l10n.ownerNameLabel,
          hint: l10n.ownerNameHint,
          controller: _nameController,
          focusNode: _nameFocusNode,
          validator: (value) => Validators.validateName(value, l10n),
          prefixIcon: const Icon(Icons.person_outline),
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 20),

        // Mobile Number Field
        Builder(
          builder: (context) {
            final authUser = FirebaseAuth.instance.currentUser;
            final authMobile = authUser?.phoneNumber != null
                ? (authUser!.phoneNumber!.length >= 10
                      ? authUser.phoneNumber!.substring(authUser.phoneNumber!.length - 10)
                      : authUser.phoneNumber)
                : null;

            return CustomTextField(
              label: l10n.mobileNumberLabel,
              hint: l10n.phoneHint,
              controller: _mobileController,
              focusNode: _mobileFocusNode,
              validator: (value) => Validators.validateMobileMatchesAuth(value, l10n, authMobile),
              prefixIcon: const Icon(Icons.phone_outlined),
              keyboardType: TextInputType.phone,
              maxLength: 10,
              helperText: authMobile != null ? l10n.mobileHelperMatch(authMobile) : l10n.mobileHelperDefault,
              readOnly: authMobile != null, // Make read-only if we have auth mobile
            );
          },
        ),
        const SizedBox(height: 20),

        // Shop/Hub Name Field
        CustomTextField(
          label: l10n.shopNameLabel,
          hint: l10n.shopNameHint,
          controller: _shopNameController,
          focusNode: _shopNameFocusNode,
          validator: (value) => Validators.validateShopName(value, l10n),
          prefixIcon: const Icon(Icons.store_outlined),
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }

  /// Build Location Section
  Widget _buildLocationSection({
    required bool isLocationDetected,
    required bool isDetectingLocation,
    required dynamic registrationData,
    required AppLocalizations l10n,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.businessLocationTitle, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        _buildLocationCard(
          isLocationDetected: isLocationDetected,
          isDetectingLocation: isDetectingLocation,
          registrationData: registrationData,
          l10n: l10n,
        ),
      ],
    );
  }

  /// Build Location Card
  Widget _buildLocationCard({
    required bool isLocationDetected,
    required bool isDetectingLocation,
    required dynamic registrationData,
    required AppLocalizations l10n,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isLocationDetected
            ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isLocationDetected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline,
          width: isLocationDetected ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            isLocationDetected ? Icons.location_on : Icons.location_off_outlined,
            size: 48,
            color: isLocationDetected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
          ),
          const SizedBox(height: 12),
          Text(
            isLocationDetected ? l10n.locationDetected : l10n.locationNotDetected,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (isLocationDetected) ...[
            const SizedBox(height: 8),
            Text(
              'Lat: ${registrationData.latitude!.toStringAsFixed(6)}\nLng: ${registrationData.longitude!.toStringAsFixed(6)}',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: isLocationDetected ? l10n.updateLocation : l10n.detectLocation,
              onPressed: _detectLocation,
              isLoading: isDetectingLocation,
              icon: Icons.my_location,
              backgroundColor: isLocationDetected
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  /// Build Continue Button
  Widget _buildContinueButton(RegistrationState state, AppLocalizations l10n) {
    return CustomButton(
      text: l10n.continueToDocs,
      onPressed: () {
        // Unfocus immediately when button is pressed
        FocusScope.of(context).unfocus();
        // Then proceed with validation and navigation
        _proceedToNextScreen(state, l10n);
      },
      icon: Icons.arrow_forward,
    );
  }

  Widget _buildProgressIndicator(int currentStep) {
    return Row(
      children: List.generate(4, (index) {
        final stepNumber = index + 1;
        final isActive = stepNumber <= currentStep;

        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: isActive
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.outline.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              if (index < 3) const SizedBox(width: 4),
            ],
          ),
        );
      }),
    );
  }
}
