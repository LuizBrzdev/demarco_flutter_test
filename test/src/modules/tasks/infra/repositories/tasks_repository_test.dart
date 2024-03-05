import 'package:demarco_flutter_test/src/modules/tasks/domain/repositories/tasks_repository.dart';
import 'package:demarco_flutter_test/src/modules/tasks/external/isar/task_model.dart';
import 'package:demarco_flutter_test/src/modules/tasks/infra/datasource/tasks_datasource.dart';
import 'package:demarco_flutter_test/src/modules/tasks/infra/repositories/tasks_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class TasksDatasourceMock extends Mock implements TasksDatasource {}

void main() {
  late TasksDatasource tasksDatasource;
  late TasksRepository tasksRepository;

  setUp(() {
    tasksDatasource = TasksDatasourceMock();
    tasksRepository = TasksRepositoryImpl(datasource: tasksDatasource);
  });

  test(
    'Should be test fetch all tasks in repository',
    () async {
      when(() => tasksDatasource.getAllTasks()).thenAnswer(
        (_) async => [
          TaskModel(),
        ],
      );
      final tasks = await tasksRepository.getTasks();

      expect(tasks.length, 1);
    },
  );

  test('Should be test if addNewTask method was called', () async {
    final task = TaskModel();

    when(() => tasksDatasource.addNewTask(task)).thenAnswer((_) async => task);

    await tasksRepository.addNewTask(task);

    verify(() => tasksDatasource.addNewTask(task)).called(1);
  });
}
