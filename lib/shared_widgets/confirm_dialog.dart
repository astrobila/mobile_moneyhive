import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    this.confirmTitle = 'Loading...',
    this.yesTitle = 'Yes',
    this.noTitle = 'No',
    this.yesOnPressed,
    this.noOnPressed,
  });

  final String confirmTitle;
  final String yesTitle;
  final String noTitle;
  final Function()? yesOnPressed;
  final Function()? noOnPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Text(confirmTitle),
            const SizedBox(height: 8),
            Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: yesOnPressed, child: Text(yesTitle))),
                const SizedBox(width: 8),
                Expanded(
                    child: ElevatedButton(
                        onPressed: noOnPressed, child: Text(noTitle))),
              ],
            )
          ],
        ),
      ),
    );
  }
}

showConfirmDialog(
  BuildContext context, {
  String confirmTitle = 'Confirm?',
  String yesTitle = 'Yes',
  Function()? yesOnPressed,
  String noTitle = 'No',
  Function()? noOnPressed,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return ConfirmDialog(
        confirmTitle: confirmTitle,
        yesTitle: yesTitle,
        noTitle: noTitle,
        yesOnPressed: yesOnPressed ??
            () {
              Navigator.pop(context, 1);
            },
        noOnPressed: noOnPressed ??
            () {
              Navigator.pop(context, 0);
            },
      );
    },
  );
}
