// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:demarco_flutter_test/src/core/style/app_style_colors.dart';
import 'package:flutter/material.dart';

class CarrouselIndicatorWidget extends StatelessWidget {
  final int currentIndex;
  final int itemCount;

  const CarrouselIndicatorWidget({
    required this.currentIndex,
    required this.itemCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount.clamp(1, 3),
        (index) => _IndicatorWidget(isActive: currentIndex == index),
      ),
    );
  }
}

class _IndicatorWidget extends StatelessWidget {
  final bool isActive;
  const _IndicatorWidget({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: AppStyleColors.primary),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
