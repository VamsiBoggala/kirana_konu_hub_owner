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

/// Screen 3: Bank Details
/// Collects bank account information for payouts
class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accountHolderController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _confirmAccountController = TextEditingController();
  final _ifscController = TextEditingController();
  final _branchController = TextEditingController();

  @override
  void dispose() {
    _accountHolderController.dispose();
    _accountNumberController.dispose();
    _confirmAccountController.dispose();
    _ifscController.dispose();
    _branchController.dispose();
    super.dispose();
  }

  String? _validateConfirmAccount(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.confirmAccountRequired;
    }
    if (value.trim() != _accountNumberController.text.trim()) {
      return l10n.accountMismatch;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.bankDetailsTitle), centerTitle: true),
      body: BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          // Handle validation errors
          if (state is ValidationError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error), backgroundColor: Colors.orange));
          }
          // Handle upload success
          else if (state is DocumentUploadSuccess && state.documentType == 'cancelled_cheque') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.uploadSuccess("Cancelled Cheque")), backgroundColor: Colors.green),
            );
          }
          // Handle upload failure
          else if (state is DocumentUploadFailed) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.uploadFailed(state.error)), backgroundColor: Colors.red));
          }
          // Handle IFSC lookup success
          else if (state is IFSCLookupSuccess) {
            _branchController.text = state.branchName;
          }
          // Handle navigation
          else if (state is NavigateToNextScreen) {
            Navigator.pushNamed(context, state.routeName);
          }
        },
        builder: (context, state) {
          final bloc = context.read<RegistrationBloc>();
          final data = bloc.currentData;

          // Determine loading state from BLoC state
          final isUploading = state is DocumentUploadInProgress && state.documentType == 'cancelled_cheque';

          // Get file reference from BLoC state
          final cancelledChequeFile = data.cancelledChequeFilePath != null ? File(data.cancelledChequeFilePath!) : null;

          // Initialize controllers with BLoC data if needed
          if (_accountHolderController.text.isEmpty && data.bankAccountHolderName.isNotEmpty) {
            _accountHolderController.text = data.bankAccountHolderName;
          }
          if (_accountNumberController.text.isEmpty && data.bankAccountNumber.isNotEmpty) {
            _accountNumberController.text = data.bankAccountNumber;
          }
          if (_ifscController.text.isEmpty && data.ifscCode.isNotEmpty) {
            _ifscController.text = data.ifscCode;
          }
          if (_branchController.text.isEmpty && data.branchName != null && data.branchName!.isNotEmpty) {
            _branchController.text = data.branchName!;
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
                    _buildProgressIndicator(3),
                    const SizedBox(height: 32),

                    // Header
                    Text(l10n.financialSettlementHeader, style: Theme.of(context).textTheme.displaySmall),
                    const SizedBox(height: 8),
                    Text(
                      l10n.financialSettlementSubHeader,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
                    ),
                    const SizedBox(height: 32),

                    // Account Holder Name
                    CustomTextField(
                      label: l10n.accountHolderLabel,
                      hint: l10n.accountHolderHint,
                      controller: _accountHolderController,
                      validator: (value) => Validators.validateName(value, l10n),
                      prefixIcon: const Icon(Icons.person_outline),
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 20),

                    // Account Number
                    CustomTextField(
                      label: l10n.accountNumberLabel,
                      hint: l10n.accountNumberHint,
                      controller: _accountNumberController,
                      validator: (value) => Validators.validateAccountNumber(value, l10n),
                      prefixIcon: const Icon(Icons.account_balance),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 20),

                    // Confirm Account Number
                    CustomTextField(
                      label: l10n.confirmAccountLabel,
                      hint: l10n.confirmAccountHint,
                      controller: _confirmAccountController,
                      validator: (value) => _validateConfirmAccount(value, l10n),
                      prefixIcon: const Icon(Icons.verified_outlined),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 20),

                    // IFSC Code
                    CustomTextField(
                      label: l10n.ifscLabel,
                      hint: l10n.ifscHint,
                      controller: _ifscController,
                      validator: (value) => Validators.validateIFSC(value, l10n),
                      prefixIcon: const Icon(Icons.code),
                      keyboardType: TextInputType.text,
                      maxLength: 11,
                      inputFormatters: [UpperCaseTextFormatter()],
                      onChanged: (value) {
                        if (value.length == 11) {
                          bloc.add(LookupIFSCEvent(ifscCode: value));
                        }
                      },
                    ),
                    const SizedBox(height: 20),

                    // Branch Name (Optional/Auto-filled)
                    CustomTextField(
                      label: l10n.branchLabel,
                      hint: l10n.branchHint,
                      controller: _branchController,
                      prefixIcon: const Icon(Icons.location_city),
                      keyboardType: TextInputType.text,
                      enabled: false,
                    ),
                    const SizedBox(height: 32),

                    // Cancelled Cheque Upload
                    _buildSectionHeader(l10n.cancelledChequeSection, Icons.receipt),
                    const SizedBox(height: 16),

                    DocumentUploadWidget(
                      label: l10n.uploadCheque,
                      hint: l10n.uploadChequeHint,
                      onFileSelected: (file) {
                        bloc.add(UpdateCancelledChequeFileEvent(filePath: file?.path));
                      },
                      initialFile: cancelledChequeFile,
                    ),

                    if (isUploading) const Padding(padding: EdgeInsets.only(top: 8), child: LinearProgressIndicator()),

                    const SizedBox(height: 32),

                    // Info Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              l10n.bankInfoNote,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.blue.shade900),
                            ),
                          ),
                        ],
                      ),
                    ),

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
                                  ValidateAndProceedToTermsEvent(
                                    accountHolderName: _accountHolderController.text.trim(),
                                    accountNumber: _accountNumberController.text.trim(),
                                    ifscCode: _ifscController.text.trim().toUpperCase(),
                                    branchName: _branchController.text.trim().isEmpty
                                        ? null
                                        : _branchController.text.trim(),
                                  ),
                                );
                              }
                            },
                            isLoading: isUploading,
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

/// Uppercase text formatter
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
