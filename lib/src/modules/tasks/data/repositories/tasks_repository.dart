import '../../domain/entities/task_model.dart';
import '../../domain/repositories/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  @override
  Future<List<TaskEntity>> getTasks() async {
    return [];
  }

  @override
  Future<void> addNewTask(TaskEntity task) async {}

  @override
  Future<void> deleteTask(TaskEntity task) async {}
}
