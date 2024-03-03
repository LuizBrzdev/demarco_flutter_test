import '../../../domain/entities/task_entity.dart';

sealed class TasksState {}

class TasksLoadingState implements TasksState {
  final List<TaskEntity> tasks = [];
}

class TasksLoadedState implements TasksState {
  final List<TaskEntity> tasks;

  TasksLoadedState({required this.tasks});
}

class TasksEmptyState extends TasksLoadedState {
  TasksEmptyState() : super(tasks: []);
}
