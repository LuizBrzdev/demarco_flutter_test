import 'package:demarco_flutter_test/src/core/style/app_style_colors.dart';
import 'package:flutter/material.dart';

Future<void> openDialog({
  required BuildContext context,
  final VoidCallback? onPressedAction,
  final VoidCallback? onPressBack,
  final Widget? content,
  final String actionLabel = '',
  final String onPressBackButtonLabel = '',
  final bool barrierDismissible = true,
  required final String title,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: AppStyleColors.primary),
      ),
      backgroundColor: AppStyleColors.white,
      insetPadding: const EdgeInsets.all(12),
      actions: [
        Visibility(
          visible: actionLabel != '',
          child: TextButton(
            onPressed: onPressedAction,
            child: Text(actionLabel),
          ),
        ),
        TextButton(
          onPressed: onPressBack ?? () => Navigator.of(context).pop(),
          child: const Text(
            'Voltar',
          ),
        ),
      ],
      content: SingleChildScrollView(child: content),
    ),
  );
}
