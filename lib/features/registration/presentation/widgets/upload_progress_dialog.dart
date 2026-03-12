import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_state.dart';

class UploadProgressDialog extends StatelessWidget {
  const UploadProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Prevent dismissal
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          int current = 0;
          int total = 1;
          String currentFile = '';
          String title = 'Processing...';

          if (state is ImagesUploading) {
            current = state.current;
            total = state.total;
            currentFile = state.currentFile;
            title = 'Uploading Documents';
          } else if (state is SubmittingRequest) {
            current = 1;
            total = 1;
            currentFile = 'Finalizing registration details...';
            title = 'Submitting Request';
          }

          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(value: total > 0 ? current / total : 0, backgroundColor: Colors.grey[200]),
                const SizedBox(height: 20),
                if (state is ImagesUploading) ...[
                  Text('Uploading $current of $total', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                ],
                Text(
                  currentFile.isEmpty ? 'Please wait...' : currentFile,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600], fontStyle: FontStyle.italic),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
