import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

/// Reusable Document Upload Widget
/// Used for uploading KYB documents (GST, FSSAI, Bank Proof, etc.)
class DocumentUploadWidget extends StatefulWidget {
  final String label;
  final String? hint;
  final Function(File?) onFileSelected;
  final File? initialFile;
  final List<String> allowedExtensions;

  const DocumentUploadWidget({
    super.key,
    required this.label,
    this.hint,
    required this.onFileSelected,
    this.initialFile,
    this.allowedExtensions = const ['jpg', 'jpeg', 'png', 'pdf'],
  });

  @override
  State<DocumentUploadWidget> createState() => _DocumentUploadWidgetState();
}

class _DocumentUploadWidgetState extends State<DocumentUploadWidget> {
  File? _selectedFile;

  @override
  void initState() {
    super.initState();
    _selectedFile = widget.initialFile;
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: widget.allowedExtensions,
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
        widget.onFileSelected(_selectedFile);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error picking file: $e')));
      }
    }
  }

  void _removeFile() {
    setState(() {
      _selectedFile = null;
    });
    widget.onFileSelected(null);
  }

  String _getFileName() {
    if (_selectedFile == null) return '';
    return _selectedFile!.path.split('/').last;
  }

  bool _isPDF() {
    if (_selectedFile == null) return false;
    return _selectedFile!.path.toLowerCase().endsWith('.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontFamily: 'Poppins', 
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        if (_selectedFile == null)
          GestureDetector(
            onTap: _pickFile,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.outline, width: 1.5, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
              ),
              child: Column(
                children: [
                  Icon(Icons.cloud_upload_outlined, size: 48, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(height: 12),
                  Text(
                    'Tap to upload document',
                    style: TextStyle(fontFamily: 'Poppins', 
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  if (widget.hint != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      widget.hint!,
                      style: TextStyle(fontFamily: 'Poppins', 
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    'Supported: ${widget.allowedExtensions.join(", ").toUpperCase()}',
                    style: TextStyle(fontFamily: 'Poppins', 
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  ),
                  child: _isPDF()
                      ? Icon(Icons.picture_as_pdf, size: 32, color: Theme.of(context).colorScheme.primary)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(_selectedFile!, fit: BoxFit.cover),
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getFileName(),
                        style: TextStyle(fontFamily: 'Poppins', 
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Uploaded',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 11, color: Colors.green, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                IconButton(onPressed: _removeFile, icon: const Icon(Icons.delete_outline), color: Colors.red),
              ],
            ),
          ),
      ],
    );
  }
}
