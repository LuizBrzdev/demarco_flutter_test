import 'dart:io';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:demarco_flutter_test/src/core/style/app_style_colors.dart';
import 'package:flutter/material.dart';

import 'carrousel_indicator_widget.dart';

class CarrouselSlider extends StatefulWidget {
  ///[itemCount] contagem de carrosséis, por padrão é limitada a 3
  final int itemCount;

  ///[itemBuilder] Cria uma lista  que funciona página por página usando widgets criados sob demanda.
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
            itemBuilder: widget.itemBuilder,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CarrouselIndicatorWidget(
                currentIndex: currentIndex,
                itemCount: widget.itemCount,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CarrouselImage extends StatelessWidget {
  ///[imageUrl] endereço da imagem
  final String imageUrl;

  ///[taskName] nome da tarefa
  final String taskName;

  ///[taskDate] data da tarefa
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
            child: Image.file(
              File(imageUrl),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    color: AppStyleColors.primary.withOpacity(0.2),
                    height: 70,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            taskName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppStyleColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            taskDate,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppStyleColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
