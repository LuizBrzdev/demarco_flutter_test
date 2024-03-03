import 'package:demarco_flutter_test/src/modules/tasks/domain/entities/task_entity.dart';
import 'package:demarco_flutter_test/src/modules/tasks/domain/repositories/tasks_repository.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../states/tasks_state.dart';
import 'package:bloc/bloc.dart';

class TasksCubit extends Cubit<TasksState> {
  //CONSTRUCTOS
  late final TasksRepository _tasksRepository;

  TasksCubit({required TasksRepository tasksRepository})
      : _tasksRepository = tasksRepository,
        super(TasksLoadingState());

  //CONTROLLERS
  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  final taskDateController = TextEditingController();

  //FUNCTIONS

  Future<void> fetchAllTasks() async {
    final tasks = await _tasksRepository.getTasks();
    emitTasks(tasks);
  }

  Future<void> addNewTask() async {
    await _tasksRepository.addNewTask(
      TaskEntity(
        id: 1,
        name: taskNameController.text,
        description: taskDescriptionController.text,
        date: taskDateController.text,
        completed: false,
        image: '',
      ),
    );
    fetchAllTasks();
  }

  Future<void> updateCompletedStatus(TaskEntity task) async {
    final List<TaskEntity>? tasks = _getStateTasks();
    final int index = tasks!.indexOf(task);
    tasks[index] = task;
    await _tasksRepository.updateCompletedStatus(task.copyWith(completed: !task.completed));
    fetchAllTasks();
  }

  List<TaskEntity>? _getStateTasks() {
    final state = this.state;
    if (state is! TasksLoadedState) {
      return null;
    }
    return state.tasks.toList();
  }

  emitTasks(List<TaskEntity> tasks) {
    emit(TasksLoadingState());
    if (tasks.isEmpty) {
      emit(TasksEmptyState());
    } else {
      emit(TasksLoadedState(tasks: tasks));
    }
  }
}
