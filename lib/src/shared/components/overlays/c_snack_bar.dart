import 'package:flutter/material.dart';

import '../../../core/style/app_style_colors.dart';

class SnackBarWidget extends SnackBar {
  ///[message] mensagem a ser exibida na snack bar
  final String message;

  ///[context] contexto a ser cedido
  final BuildContext context;

  SnackBarWidget({super.key, required this.message, required this.context})
      : super(
          content: Text(
            message,
            style: const TextStyle(color: AppStyleColors.white),
          ),
          backgroundColor: AppStyleColors.errorPrimary,
          dismissDirection: DismissDirection.up,
          behavior: SnackBarBehavior.floating,
          padding: const EdgeInsets.all(20),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.25,
            left: 10,
            right: 10,
          ),
        );
}
