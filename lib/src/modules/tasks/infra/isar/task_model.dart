import 'package:isar/isar.dart';

import 'package:demarco_flutter_test/src/modules/tasks/domain/entities/task_model.dart';

part 'task_model.g.dart';

@collection
class TaskModel implements TaskEntity {
  Id id = Isar.autoIncrement;

  @override
  final String name = '';

  @override
  final String description = '';

  @override
  final String date = '';

  @override
  final bool completed = false;

  @override
  final String image = '';
}
