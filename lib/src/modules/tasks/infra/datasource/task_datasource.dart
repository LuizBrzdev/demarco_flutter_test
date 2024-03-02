import 'package:demarco_flutter_test/src/modules/tasks/domain/entities/task_entity.dart';

abstract class TaskDatasource {
  Future<List<TaskEntity>> getAllTasks();

  Future<void> deleteTask(int id);

  Future<void> addNewTask(TaskEntity entity);
}
