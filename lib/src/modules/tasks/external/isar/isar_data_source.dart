import 'package:demarco_flutter_test/src/modules/tasks/domain/entities/task_entity.dart';
import 'package:demarco_flutter_test/src/modules/tasks/infra/datasource/task_datasource.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../adapters/task_model_adapter.dart';
import 'task_model.dart';

class IsarDatasource implements TaskDatasource {
  late Isar? _isar;

  Future<Isar> _getInstance() async {
    if (_isar != null) {
      return _isar!;
    }

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
    return await isar.taskModels.where().findAll();
  }

  @override
  Future<void> addNewTask(TaskEntity task) async {
    final isar = await _getInstance();
    await isar.taskModels.put(TaskModelAdapter.taskEntityToModel(task));
  }

  @override
  Future<void> deleteTask(int id) async {
    final isar = await _getInstance();

    await isar.writeTxn(() {
      return isar.taskModels.delete(id);
    });
  }
}
