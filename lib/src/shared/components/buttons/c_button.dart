// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import '../../../core/style/app_style_colors.dart';

enum CButtonStyle {
  primary,
  primaryDisabled,
}

enum CButtonIconAxis { LEFT, RIGHT }

enum CButtonCounterAxis { LEFT, RIGHT }

class CButton extends StatelessWidget {
  /// [style] É um enum que define o estilo do botão.
  final CButtonStyle style;

  /// [label] é o texto que será exibido no botão.
  final String label;

  /// [hasIcon] é um bool que indica se o botão tem um ícone.
  /// O valor default é [false].
  /// Se [hasIcon] for [true], o atributo [icon] não pode ser nulo.
  final bool hasIcon;

  /// [icon] é o ícone que será exibido no botão.
  final Widget? icon;

  /// [height] é a altura do botão.
  /// O valor default é [55].
  final double height;

  /// [width] é a largura do botão.
  /// O valor default é [double.infinity].
  final double width;

  /// [onPressed] é a função que será executada quando o botão for pressionado.
  final VoidCallback? onPressed;

  /// [inProcess] é um bool que indica se o botão está em processo.
  /// O valor default é [false].
  /// Se [inProcess] for [true], o botão será desabilitado e será exibido
  /// um [Lottie] de carregamento.
  final bool inProcess;

  const CButton({
    super.key,
    this.style = CButtonStyle.primary,
    required this.label,
    this.hasIcon = false,
    this.icon,
    this.height = 55,
    this.onPressed,
    this.inProcess = false,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _denyPressCondition() ? null : onPressed,
      child: Visibility(
        visible: !inProcess,
        replacement: Container(
          height: height,
          width: double.infinity,
          decoration: _boxDecoration(style),
          child: const Center(
            child: CircularProgressIndicator(
              color: AppStyleColors.black,
              strokeWidth: 2,
            ),
          ),
        ),
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
      ),
    );
  }

  bool _denyPressCondition() {
    List<CButtonStyle> denyPress = [
      CButtonStyle.primaryDisabled,
    ];
    return (denyPress.contains(style) || onPressed == null || inProcess);
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

      default:
        return BoxDecoration(
          color: AppStyleColors.primary,
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
