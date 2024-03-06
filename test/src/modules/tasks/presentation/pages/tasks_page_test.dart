import 'package:demarco_flutter_test/src/core/bindings/app_bindings.dart';
import 'package:demarco_flutter_test/src/modules/tasks/domain/entities/task_entity.dart';
import 'package:demarco_flutter_test/src/modules/tasks/domain/repositories/tasks_repository.dart';
import 'package:demarco_flutter_test/src/modules/tasks/presentation/blocs/cubits/tasks_cubit.dart';
import 'package:demarco_flutter_test/src/modules/tasks/presentation/pages/tasks_page.dart';
import 'package:flutter/material.dart';
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
  });

  testWidgets(
    'Tasks page with all tasks ...',
    (tester) async {
      when(() => tasksRepositoryMock.getTasks()).thenAnswer(
        (invocation) async => [task],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: TasksPage(cubit: cubit),
        ),
      );

      expect(find.byKey(const Key('LoadingState')), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('LoadedState')), findsOneWidget);
    },
  );

  testWidgets(
    'Tasks page with a emptyState ...',
    (tester) async {
      when(() => tasksRepositoryMock.getTasks()).thenAnswer(
        (invocation) async => [],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: TasksPage(cubit: cubit),
        ),
      );

      expect(find.byKey(const Key('LoadedState')), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('EmptyState')), findsOneWidget);
    },
  );
}
