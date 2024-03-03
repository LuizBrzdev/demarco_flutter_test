import 'package:get_it/get_it.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../../external/isar/isar_datasource.dart';
import '../../presentation/blocs/cubit/tasks_cubit.dart';
import '../datasource/task_datasource.dart';
import '../repositories/tasks_repository.dart';

class TasksBindings {
  static void setupTaskBindings() {
    final getIt = GetIt.instance;
    getIt.registerLazySingleton<TaskDatasource>(() => IsarDatasource.instance);
    getIt.registerLazySingleton<TasksRepository>(() => TasksRepositoryImpl(datasource: getIt()));
    getIt.registerLazySingleton(() => TasksCubit(tasksRepository: getIt()));
  }
}
