// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

import 'package:demarco_flutter_test/src/modules/tasks/domain/entities/task_entity.dart';

part 'task_model.g.dart';

@collection
class TaskModel implements TaskEntity {
  @override
  Id id = Isar.autoIncrement;

  @override
  late String name = '';

  @override
  late String description = '';

  @override
  late String date = '';

  @override
  late bool completed = false;

  @override
  late String image = '';

  TaskModel({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.description,
    required this.date,
    required this.completed,
    required this.image,
  });

  TaskModel.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int,
        name = map['name'] as String,
        description = map['description'] as String,
        date = map['date'] as String,
        completed = map['completed'] as bool,
        image = map['image'] as String;

  @override
  TaskModel copyWith({
    Id? id,
    String? name,
    String? description,
    String? date,
    bool? completed,
    String? image,
  }) {
    return TaskModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      date: date ?? this.date,
      completed: completed ?? this.completed,
      image: image ?? this.image,
    );
  }
}
