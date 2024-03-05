// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import '../../../core/style/app_style_colors.dart';

///[CButtonStyle] padrões de estilização do botão
enum CButtonStyle {
  primary,
  primaryDisabled,
}

class CButton extends StatelessWidget {
  /// [style] É um enum que define o estilo do botão.
  final CButtonStyle style;

  /// [label] é o texto que será exibido no botão.
  final String label;

  /// [icon] é o ícone que será exibido no botão.
  final Widget? icon;

  /// [height] é a altura do botão.
  /// O valor default é [48].
  final double height;

  /// [width] é a largura do botão.
  /// O valor default é [double.infinity].
  final double width;

  /// [onPressed] é a função que será executada quando o botão for pressionado.
  final VoidCallback? onPressed;

  const CButton({
    super.key,
    this.style = CButtonStyle.primary,
    required this.label,
    this.icon,
    this.height = 48,
    this.onPressed,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _denyPressCondition() ? null : onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: _boxDecoration(style),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: _textStyle(style),
                    ),
                  ),
                ),
                Visibility(
                  visible: icon != null,
                  child: icon ?? Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _denyPressCondition() {
    List<CButtonStyle> denyPress = [
      CButtonStyle.primaryDisabled,
    ];
    return (denyPress.contains(style) || onPressed == null);
  }

  BoxDecoration _boxDecoration(CButtonStyle style) {
    switch (style) {
      case CButtonStyle.primary:
        return BoxDecoration(
          color: AppStyleColors.primary,
          borderRadius: BorderRadius.circular(12),
        );
      case CButtonStyle.primaryDisabled:
        return BoxDecoration(
          color: AppStyleColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
        );
    }
  }

  TextStyle _textStyle(CButtonStyle style) {
    switch (style) {
      case CButtonStyle.primary:
        return const TextStyle(color: AppStyleColors.white);

      case CButtonStyle.primaryDisabled:
        return const TextStyle(color: AppStyleColors.black);
    }
  }
}
