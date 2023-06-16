import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key, this.title = 'Loading...'});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(title),
          ],
        ),
      ),
    );
  }
}

void showLoadingDialog(
  BuildContext context, {
  String title = 'Loading...',
}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return LoadingDialog(title: title);
    },
  );
}
