import 'dart:io';
import 'package:hub_owner/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/document_upload_widget.dart';
import '../../../../core/utils/validators.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';
import '../bloc/registration_state.dart';

/// Screen 2: Business Documents (KYB)
/// Collects GSTIN and FSSAI documents
class BusinessDocumentsScreen extends StatefulWidget {
  const BusinessDocumentsScreen({super.key});

  @override
  State<BusinessDocumentsScreen> createState() => _BusinessDocumentsScreenState();
}

class _BusinessDocumentsScreenState extends State<BusinessDocumentsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _gstinController = TextEditingController();
  final _fssaiController = TextEditingController();
  final _panController = TextEditingController();
  final _shopLicenseController = TextEditingController();

  void dispose() {
    _gstinController.dispose();
    _fssaiController.dispose();
    _panController.dispose();
    _shopLicenseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.businessDocsTitle), centerTitle: true),
      body: BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          // Handle validation errors
          if (state is ValidationError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error), backgroundColor: Colors.orange));
          }
          // Handle upload success
          else if (state is DocumentUploadSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.uploadSuccess(state.documentType.toUpperCase())),
                backgroundColor: Colors.green,
              ),
            );
          }
          // Handle upload failure
          else if (state is DocumentUploadFailed) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.uploadFailed(state.error)), backgroundColor: Colors.red));
          }
          // Handle navigation
          else if (state is NavigateToNextScreen) {
            Navigator.pushNamed(context, state.routeName);
          }
        },
        builder: (context, state) {
          final bloc = context.read<RegistrationBloc>();
          final data = bloc.currentData;

          // Determine loading states from BLoC state
          final isGstinUploading = state is DocumentUploadInProgress && state.documentType == 'gstin';
          final isFssaiUploading = state is DocumentUploadInProgress && state.documentType == 'fssai';
          final isPanUploading = state is DocumentUploadInProgress && state.documentType == 'pan';
          final isShopLicenseUploading = state is DocumentUploadInProgress && state.documentType == 'shop_license';
          final isShopImageUploading = state is DocumentUploadInProgress && state.documentType == 'shop_image';
          final isAnyUploading =
              isGstinUploading || isFssaiUploading || isPanUploading || isShopLicenseUploading || isShopImageUploading;

          // Get file references from BLoC state
          final gstinFile = data.gstinFilePath != null ? File(data.gstinFilePath!) : null;
          final fssaiFile = data.fssaiFilePath != null ? File(data.fssaiFilePath!) : null;
          final panFile = data.panFilePath != null ? File(data.panFilePath!) : null;
          final shopLicenseFile = data.shopLicenseFilePath != null ? File(data.shopLicenseFilePath!) : null;
          final shopImageFile = data.shopImageFilePath != null ? File(data.shopImageFilePath!) : null;

          // Initialize controllers with BLoC data if needed
          if (_gstinController.text.isEmpty && data.gstinNumber.isNotEmpty) {
            _gstinController.text = data.gstinNumber;
          }
          if (_fssaiController.text.isEmpty && data.fssaiNumber.isNotEmpty) {
            _fssaiController.text = data.fssaiNumber;
          }
          if (_panController.text.isEmpty && data.panNumber != null && data.panNumber!.isNotEmpty) {
            _panController.text = data.panNumber!;
          }
          if (_shopLicenseController.text.isEmpty &&
              data.shopLicenseNumber != null &&
              data.shopLicenseNumber!.isNotEmpty) {
            _shopLicenseController.text = data.shopLicenseNumber!;
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress Indicator
                    _buildProgressIndicator(2),
                    const SizedBox(height: 32),

                    // Header
                    Text(l10n.businessDocsHeader, style: Theme.of(context).textTheme.displaySmall),
                    const SizedBox(height: 8),
                    Text(
                      l10n.businessDocsSubHeader,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                    ),
                    const SizedBox(height: 32),

                    // GSTIN Section
                    _buildSectionHeader(l10n.gstinSection, Icons.receipt_long),
                    const SizedBox(height: 16),

                    CustomTextField(
                      label: l10n.gstinLabel,
                      hint: l10n.gstinHint,
                      controller: _gstinController,
                      validator: (value) => Validators.validateGSTIN(value, l10n),
                      prefixIcon: const Icon(Icons.numbers),
                      keyboardType: TextInputType.text,
                      maxLength: 15,
                      inputFormatters: [UpperCaseTextFormatter()],
                    ),
                    const SizedBox(height: 16),

                    DocumentUploadWidget(
                      label: l10n.uploadGstin,
                      hint: l10n.uploadGstinHint,
                      onFileSelected: (file) {
                        bloc.add(UpdateGSTINFileEvent(filePath: file?.path));
                      },
                      initialFile: gstinFile,
                    ),

                    if (isGstinUploading)
                      const Padding(padding: EdgeInsets.only(top: 8), child: LinearProgressIndicator()),

                    const SizedBox(height: 32),

                    // FSSAI Section
                    _buildSectionHeader(l10n.fssaiSection, Icons.food_bank),
                    const SizedBox(height: 16),

                    CustomTextField(
                      label: l10n.fssaiLabel,
                      hint: l10n.fssaiHint,
                      controller: _fssaiController,
                      validator: (value) => Validators.validateFSSAI(value, l10n),
                      prefixIcon: const Icon(Icons.numbers),
                      keyboardType: TextInputType.number,
                      maxLength: 14,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 16),

                    DocumentUploadWidget(
                      label: l10n.uploadFssai,
                      hint: l10n.uploadFssaiHint,
                      onFileSelected: (file) {
                        bloc.add(UpdateFSSAIFileEvent(filePath: file?.path));
                      },
                      initialFile: fssaiFile,
                    ),

                    if (isFssaiUploading)
                      const Padding(padding: EdgeInsets.only(top: 8), child: LinearProgressIndicator()),

                    const SizedBox(height: 32),

                    // PAN Card Section
                    _buildSectionHeader(l10n.panSection, Icons.credit_card),
                    const SizedBox(height: 16),

                    CustomTextField(
                      label: l10n.panLabel,
                      hint: l10n.panHint,
                      controller: _panController,
                      validator: (value) => Validators.validatePAN(value, l10n),
                      prefixIcon: const Icon(Icons.credit_card),
                      keyboardType: TextInputType.text,
                      maxLength: 10,
                      inputFormatters: [UpperCaseTextFormatter()],
                    ),
                    const SizedBox(height: 16),

                    DocumentUploadWidget(
                      label: l10n.uploadPan,
                      hint: l10n.uploadPanHint,
                      onFileSelected: (file) {
                        bloc.add(UpdatePANCardFileEvent(filePath: file?.path));
                      },
                      initialFile: panFile,
                    ),

                    if (isPanUploading)
                      const Padding(padding: EdgeInsets.only(top: 8), child: LinearProgressIndicator()),

                    const SizedBox(height: 32),

                    // Shop License Section
                    _buildSectionHeader(l10n.shopLicenseSection, Icons.store),
                    const SizedBox(height: 16),

                    CustomTextField(
                      label: l10n.shopLicenseLabel,
                      hint: l10n.shopLicenseHint,
                      controller: _shopLicenseController,
                      prefixIcon: const Icon(Icons.badge),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 16),

                    DocumentUploadWidget(
                      label: l10n.uploadShopLicense,
                      hint: l10n.uploadShopLicenseHint,
                      onFileSelected: (file) {
                        bloc.add(UpdateShopLicenseFileEvent(filePath: file?.path));
                      },
                      initialFile: shopLicenseFile,
                    ),

                    if (isShopLicenseUploading)
                      const Padding(padding: EdgeInsets.only(top: 8), child: LinearProgressIndicator()),

                    const SizedBox(height: 32),

                    // Shop Image Section
                    _buildSectionHeader(l10n.shopImageSection, Icons.photo_camera),
                    const SizedBox(height: 16),

                    DocumentUploadWidget(
                      label: l10n.uploadShopImage,
                      hint: l10n.uploadShopImageHint,
                      onFileSelected: (file) {
                        bloc.add(UpdateShopImageFileEvent(filePath: file?.path));
                      },
                      initialFile: shopImageFile,
                    ),

                    if (isShopImageUploading)
                      const Padding(padding: EdgeInsets.only(top: 8), child: LinearProgressIndicator()),

                    const SizedBox(height: 40),

                    // Navigation Buttons
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: l10n.backButton,
                            onPressed: () => Navigator.pop(context),
                            backgroundColor: Theme.of(context).colorScheme.surface,
                            textColor: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: CustomButton(
                            text: l10n.continueButton,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                bloc.add(
                                  ValidateAndProceedToBankDetailsEvent(
                                    gstinNumber: _gstinController.text.trim().toUpperCase(),
                                    fssaiNumber: _fssaiController.text.trim(),
                                    panNumber: _panController.text.trim().toUpperCase(),
                                    shopLicenseNumber: _shopLicenseController.text.trim(),
                                  ),
                                );
                              }
                            },
                            isLoading: isAnyUploading,
                            icon: Icons.arrow_forward,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
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

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      ],
    );
  }
}

/// Uppercase text formatter for GSTIN
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
