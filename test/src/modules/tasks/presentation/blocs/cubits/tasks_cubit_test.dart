import 'package:demarco_flutter_test/src/core/bindings/app_bindings.dart';
import 'package:demarco_flutter_test/src/modules/tasks/domain/entities/task_entity.dart';
import 'package:demarco_flutter_test/src/modules/tasks/domain/repositories/tasks_repository.dart';
import 'package:demarco_flutter_test/src/modules/tasks/presentation/blocs/cubits/tasks_cubit.dart';
import 'package:demarco_flutter_test/src/modules/tasks/presentation/blocs/states/tasks_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class TasksRepositoryMock extends Mock implements TasksRepository {}

void main() {
  late TasksRepositoryMock tasksRepositoryMock;
  late TasksCubit cubit;
  final GetIt getIt = GetIt.instance;

  final task = TaskEntity(
    id: 1,
    name: 'name',
    description: 'description',
    date: '01/01/2028',
    completed: false,
    image: '',
  );

  setUpAll(() {
    AppBindings.setupAppBindings();
    tasksRepositoryMock = TasksRepositoryMock();
    cubit = TasksCubit(tasksRepository: tasksRepositoryMock, validationHelper: getIt());
    registerFallbackValue(task);
  });

  group(
    'Fetch tasks ||',
    () {
      test(
        'Should be fetch all tasks',
        () async {
          when(() => tasksRepositoryMock.getTasks()).thenAnswer(
            (_) async => [task],
          );
          expect(
            cubit.stream,
            emitsInOrder(
              [
                isA<TasksLoadingState>(),
                isA<TasksLoadedState>(),
              ],
            ),
          );
          await cubit.fetchAllTasks();
        },
      );
      test(
        'Should be fetch all tasks and show empty state',
        () async {
          when(() => tasksRepositoryMock.getTasks()).thenAnswer(
            (_) async => [],
          );
          expect(
            cubit.stream,
            emitsInOrder(
              [
                isA<TasksLoadingState>(),
                isA<TasksEmptyState>(),
              ],
            ),
          );
          await cubit.fetchAllTasks();
        },
      );
    },
  );
}
