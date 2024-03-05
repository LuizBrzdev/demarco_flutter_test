import 'package:get_it/get_it.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../../external/isar/isar_datasource.dart';
import '../blocs/cubits/tasks_cubit.dart';
import '../../infra/datasource/task_datasource.dart';
import '../../infra/repositories/tasks_repository.dart';

class TasksBindings {
  ///[setupTaskBindings] inicializa as dependências do modulo de tasks
  static void setupTaskBindings() {
    final getIt = GetIt.instance;
    getIt.registerLazySingleton<TaskDatasource>(() => IsarDatasource.instance);
    getIt.registerLazySingleton<TasksRepository>(() => TasksRepositoryImpl(datasource: getIt()));
    getIt.registerLazySingleton(
        () => TasksCubit(tasksRepository: getIt(), validationHelper: getIt()));
  }
}
