import 'package:flutter/material.dart';

///[TasksEmptyStateWidget] widget exibido quando não há nenhum tarefa cadastrada
class TasksEmptyStateWidget extends StatelessWidget {
  const TasksEmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            child: const Text(
              'Ops...Parece que você ainda não possui nenhuma tarefa',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
