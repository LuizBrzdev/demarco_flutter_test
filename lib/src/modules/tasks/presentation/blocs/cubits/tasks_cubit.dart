import 'package:demarco_flutter_test/src/shared/utils/validation/validation_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/task_entity.dart';
import '../../../domain/repositories/tasks_repository.dart';
import '../states/tasks_state.dart';
import 'package:bloc/bloc.dart';

class TasksCubit extends Cubit<TasksState> {
  //CONSTRUCTOS
  final TasksRepository _tasksRepository;
  final ValidationHelper validationHelper;

  TasksCubit({required TasksRepository tasksRepository, required this.validationHelper})
      : _tasksRepository = tasksRepository,
        super(TasksLoadingState());

  //CONTROLLERS
  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  final taskDateController = TextEditingController();

  //VARIABLES
  String _selectedImagePath = '';

  //METHODS

  Future<void> fetchAllTasks() async {
    final tasks = await _tasksRepository.getTasks();
    orderTasksByDate(tasks);
    _emitTasks(tasks);
  }

  void orderTasksByDate(List<TaskEntity> tasks) {
    tasks.sort((a, b) {
      DateTime firstTaskDate = DateFormat('dd/MM/yyyy').parse(a.date);
      DateTime secondTaskDate = DateFormat('dd/MM/yyyy').parse(b.date);
      return firstTaskDate.compareTo(secondTaskDate);
    });
  }

  List<TaskEntity> filterTasksByCompletedStatus(List<TaskEntity> tasks) {
    return tasks.where((task) => task.completed == false).toList();
  }

  Future<void> updateCompletedStatus(TaskEntity task) async {
    final List<TaskEntity>? tasks = _getStateTasks();
    if (tasks == null) return;
    final int index = tasks.indexOf(task);
    tasks[index] = task;
    await _tasksRepository.updateCompletedStatus(task.copyWith(completed: !task.completed));
    await fetchAllTasks();
  }

  List<TaskEntity>? _getStateTasks() {
    final state = this.state;
    if (state is! TasksLoadedState) {
      return null;
    }
    return state.tasks.toList();
  }

  void _emitTasks(List<TaskEntity> tasks) {
    emit(TasksLoadingState());
    if (tasks.isEmpty) {
      emit(TasksEmptyState());
    } else {
      emit(TasksLoadedState(tasks: tasks));
    }
  }

  Future<void> addNewTask() async {
    final newTask = TaskEntity(
      id: 1,
      name: taskNameController.text,
      description: taskDescriptionController.text,
      date: taskDateController.text,
      completed: false,
      image: _selectedImagePath,
    );

    await _tasksRepository.addNewTask(newTask);
    clearNewTaskInformation();
    fetchAllTasks();
  }

  Future<String> selectImageToAddTask() async {
    FilePickerResult? selectedImage = await FilePicker.platform.pickFiles();
    return _selectedImagePath = selectedImage?.paths.single ?? '';
  }

  void clearNewTaskInformation() {
    taskNameController.clear();
    taskDescriptionController.clear();
    taskDateController.clear();
    _selectedImagePath = '';
  }

  bool allTasksFormsAreValid() {
    const tasksValidForms = ['taskName', 'taskDescription', 'taskDate'];
    return validationHelper.checkAllFormsAreValid(tasksValidForms);
  }

  @visibleForTesting
  void addTasks(List<TaskEntity> tasks) {
    emit(TasksLoadedState(tasks: tasks));
  }
}
