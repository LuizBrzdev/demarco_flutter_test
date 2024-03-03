import 'package:demarco_flutter_test/src/shared/utils/validation/validation_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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

  //VALIDATION
  final tasksValidForms = const ['taskName', 'taskDescription', 'taskDate'];

  //VARIABLES
  late String _selectedImagePath;

  //METHODS

  Future<void> fetchAllTasks() async {
    final tasks = await _tasksRepository.getTasks();
    final filteredTasks = tasks.where((task) => !task.completed).toList();
    _emitTasks(filteredTasks);
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

  void _emitTasks(List<TaskEntity> tasks) {
    emit(TasksLoadingState());
    if (tasks.isEmpty) {
      emit(TasksEmptyState());
    } else {
      emit(TasksLoadedState(tasks: tasks));
    }
  }

  Future<void> addNewTask() async {
    await _tasksRepository.addNewTask(
      TaskEntity(
        id: 1,
        name: taskNameController.text,
        description: taskDescriptionController.text,
        date: taskDateController.text,
        completed: false,
        image: _selectedImagePath,
      ),
    );
    clearNewTaskInformation();
    await fetchAllTasks();
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
    return validationHelper.checkAllFormsAreValid(tasksValidForms);
  }
}
