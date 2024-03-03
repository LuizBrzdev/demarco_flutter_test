import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../shared/components/actions/c_task_checkbox_tile.dart';
import 'carrousel_slider_widget.dart';

class TasksSkeletonWidget extends StatelessWidget {
  const TasksSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        children: [
          CarrouselSlider(
            itemCount: 3,
            itemBuilder: (context, index) => const CarrouselImage(
              imageUrl: '',
              taskName: 'FAKE TASK NAME',
              taskDate: '',
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: List.generate(
                3,
                (index) => const Column(
                  children: [
                    CTaskCheckBoxTile(
                      completedTask: false,
                      title: 'FAKE TITLE',
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
