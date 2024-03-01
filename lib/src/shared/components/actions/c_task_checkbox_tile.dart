import 'package:demarco_flutter_test/src/core/style/app_style_colors.dart';
import 'package:flutter/material.dart';

class CTaskCheckBoxTile extends StatelessWidget {
  final String title;
  final bool completedTask;
  final void Function(bool?)? onChanged;

  const CTaskCheckBoxTile({
    super.key,
    required this.completedTask,
    required this.title,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppStyleColors.white,
        boxShadow: [
          BoxShadow(
            color: AppStyleColors.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(2, 8),
          ),
        ],
      ),
      child: CheckboxListTile(
        checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        title: Text(
          title,
          style: TextStyle(
            color: completedTask ? AppStyleColors.grey : AppStyleColors.black,
            decoration: completedTask ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        value: completedTask,
        onChanged: onChanged,
      ),
    );
  }
}
