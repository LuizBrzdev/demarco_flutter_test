import '../entities/task_model.dart';

abstract class TasksRepository {
  Future<List<TaskEntity>> getTasks();

  Future<void> addNewTask(TaskEntity task);

  Future<void> deleteTask(TaskEntity task);
}
