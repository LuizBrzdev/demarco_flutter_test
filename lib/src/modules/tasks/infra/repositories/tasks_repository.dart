import 'package:demarco_flutter_test/src/modules/tasks/infra/datasource/task_datasource.dart';

import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../../external/isar/isar_data_source.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TaskDatasource _datasource;

  TasksRepositoryImpl({required IsarDatasource datasource}) : _datasource = datasource;

  @override
  Future<List<TaskEntity>> getTasks() async {
    return await _datasource.getAllTasks();
  }

  @override
  Future<void> addNewTask(TaskEntity task) async {}

  @override
  Future<void> deleteTask(TaskEntity task) async {}
}
