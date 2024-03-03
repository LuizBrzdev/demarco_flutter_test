import 'package:demarco_flutter_test/src/modules/tasks/infra/datasource/task_datasource.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TaskDatasource _datasource;

  TasksRepositoryImpl({required TaskDatasource datasource}) : _datasource = datasource;

  @override
  Future<List<TaskEntity>> getTasks() async {
    return await _datasource.getAllTasks();
  }

  @override
  Future<void> addNewTask(TaskEntity task) async {
    return await _datasource.addNewTask(task);
  }

  @override
  Future<void> updateCompletedStatus(TaskEntity task) async {
    return await _datasource.updateCompletedStatus(task);
  }
}
