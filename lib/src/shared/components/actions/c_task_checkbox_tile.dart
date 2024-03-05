import 'package:demarco_flutter_test/src/core/style/app_style_colors.dart';
import 'package:flutter/material.dart';

class CTaskCheckBoxTile extends StatelessWidget {
  ///[title] nome da tarefa
  final String title;

  ///[description] descrição da tarefa
  final String description;

  ///[date] data da tarefa
  final String date;

  ///[completedTask] indica se a tarefa foi concluída
  final bool completedTask;

  ///[onChanged] método executado quando clicar na tarefa
  final void Function(bool? value)? onChanged;

  const CTaskCheckBoxTile({
    super.key,
    required this.completedTask,
    required this.title,
    this.onChanged,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        activeColor: AppStyleColors.primary,
        checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        title: Text(
          title,
          maxLines: 1,
          style: TextStyle(
            fontSize: 16,
            overflow: TextOverflow.ellipsis,
            color: completedTask ? AppStyleColors.grey : AppStyleColors.black,
            decoration: completedTask ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: completedTask ? AppStyleColors.grey : AppStyleColors.black,
                decoration: completedTask ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
            Text(
              date,
              style: TextStyle(
                fontSize: 12,
                color: completedTask ? AppStyleColors.grey : AppStyleColors.black,
                decoration: completedTask ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
          ],
        ),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: completedTask,
        onChanged: onChanged,
      ),
    );
  }
}
