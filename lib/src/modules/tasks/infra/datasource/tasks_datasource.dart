import 'package:demarco_flutter_test/src/modules/tasks/domain/entities/task_entity.dart';

abstract class TasksDatasource {
  Future<List<TaskEntity>> getAllTasks();

  Future<void> addNewTask(TaskEntity entity);

  Future<void> updateCompletedStatus(TaskEntity entity);
}
