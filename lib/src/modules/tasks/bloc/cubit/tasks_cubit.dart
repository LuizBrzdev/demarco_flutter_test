import '../states/tasks_state.dart';
import 'package:bloc/bloc.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitialState());
}
