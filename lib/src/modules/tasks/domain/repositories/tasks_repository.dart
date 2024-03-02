import '../entities/task_entity.dart';

abstract class TasksRepository {
  Future<List<TaskEntity>> getTasks();

  Future<void> addNewTask(TaskEntity task);

  Future<void> deleteTask(TaskEntity task);
}
