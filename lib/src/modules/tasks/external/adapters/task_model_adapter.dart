import '../../domain/entities/task_entity.dart';
import '../isar/task_model.dart';

class TaskModelAdapter {
  static TaskModel taskEntityToModel(TaskEntity entity) {
    return TaskModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      date: entity.date,
      completed: entity.completed,
      image: entity.image,
    );
  }
}
