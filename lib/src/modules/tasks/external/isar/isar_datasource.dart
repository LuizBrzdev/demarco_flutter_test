import 'package:demarco_flutter_test/src/modules/tasks/domain/entities/task_entity.dart';
import 'package:demarco_flutter_test/src/modules/tasks/infra/datasource/tasks_datasource.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../adapters/task_model_adapter.dart';
import 'task_model.dart';

class IsarDatasource implements TasksDatasource {
  Isar? _isar;

  static IsarDatasource? _instance;

  IsarDatasource._();
  static IsarDatasource get instance => _instance ??= IsarDatasource._();

  Future<Isar> _getInstance() async {
    if (_isar != null) return _isar!;
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [TaskModelSchema],
      directory: dir.path,
    );

    return _isar!;
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    final isar = await _getInstance();
    //isar.writeTxn(() async => await isar.taskModels.clear());
    return await isar.taskModels.where().findAll();
  }

  @override
  Future<void> addNewTask(TaskEntity task) async {
    final isar = await _getInstance();
    await isar.writeTxn(() {
      return isar.taskModels.put(TaskModelAdapter.taskEntityToModel(task));
    });
  }

  @override
  Future<void> updateCompletedStatus(TaskEntity task) async {
    final isar = await _getInstance();
    final taskToUpdate = isar.taskModels.where().filter().idEqualTo(task.id).findFirstSync();
    if (taskToUpdate != null) {
      taskToUpdate.completed = !taskToUpdate.completed;
      await isar.writeTxn(() {
        return isar.taskModels.put(taskToUpdate);
      });
    }
  }
}
