import 'package:animate_do/animate_do.dart';
import 'package:demarco_flutter_test/src/core/style/app_style_colors.dart';
import 'package:flutter/material.dart';

import 'carrousel_indicator_widget.dart';

class CarrouselSlider extends StatefulWidget {
  final int itemCount;
  final Widget? Function(BuildContext context, int index) itemBuilder;
  const CarrouselSlider({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  State<CarrouselSlider> createState() => _CarrouselSliderState();
}

class _CarrouselSliderState extends State<CarrouselSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      height: 200,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: widget.itemCount.clamp(0, 3),
            onPageChanged: (value) => setState(
              () {
                currentIndex = value;
              },
            ),
            itemBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CarrouselImage(
                imageUrl: '',
                taskName: 'teste',
                taskDate: '12/09/0199',
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CarrouselIndicatorWidget(
                currentIndex: currentIndex,
                itemCount: 3,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CarrouselImage extends StatelessWidget {
  final String imageUrl;
  final String taskName;
  final String taskDate;

  const CarrouselImage({
    super.key,
    required this.imageUrl,
    required this.taskName,
    required this.taskDate,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/images/logo.jpeg',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          FadeInDown(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppStyleColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    taskDate,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppStyleColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
