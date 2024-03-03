import 'package:demarco_flutter_test/src/core/style/app_style_colors.dart';
import 'package:demarco_flutter_test/src/modules/tasks/presentation/blocs/cubits/tasks_cubit.dart';
import 'package:demarco_flutter_test/src/modules/tasks/presentation/blocs/states/tasks_state.dart';
import 'package:demarco_flutter_test/src/modules/tasks/widgets/carrousel_slider_widget.dart';
import 'package:demarco_flutter_test/src/modules/tasks/widgets/tasks_empty_state_widget.dart';
import 'package:demarco_flutter_test/src/shared/components/actions/c_task_checkbox_tile.dart';
import 'package:demarco_flutter_test/src/shared/components/buttons/c_button.dart';
import 'package:demarco_flutter_test/src/shared/components/buttons/c_floating_action_button.dart';
import 'package:demarco_flutter_test/src/shared/components/forms/c_text_form.dart';
import 'package:demarco_flutter_test/src/shared/components/overlays/c_dialog.dart';
import 'package:demarco_flutter_test/src/shared/utils/validation/validation_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../shared/components/overlays/c_snack_bar.dart';
import '../../widgets/tasks_skeleton_widget.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with ValidationMixin {
  final _cubit = GetIt.instance<TasksCubit>();
  @override
  void initState() {
    super.initState();
    _cubit.fetchAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo_without_bg.png',
          fit: BoxFit.fitHeight,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SafeArea(child: SizedBox(height: 20)),
            BlocBuilder<TasksCubit, TasksState>(
              bloc: _cubit,
              builder: (context, state) {
                switch (state) {
                  case TasksLoadingState():
                    return const TasksSkeletonWidget();
                  case TasksEmptyState():
                    return const TasksEmptyStateWidget();

                  case TasksLoadedState():
                    return Column(
                      children: [
                        CarrouselSlider(
                          itemCount: state.tasks.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: CarrouselImage(
                              imageUrl: state.tasks[index].image,
                              taskName: state.tasks[index].name,
                              taskDate: state.tasks[index].date,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const SizedBox(height: 8),
                          itemCount: state.tasks.length,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemBuilder: (context, index) => CTaskCheckBoxTile(
                            title: state.tasks[index].name,
                            description: state.tasks[index].description,
                            date: state.tasks[index].date,
                            completedTask: state.tasks[index].completed,
                            onChanged: (value) {
                              _cubit.updateCompletedStatus(state.tasks[index]);
                            },
                          ),
                        ),
                      ],
                    );
                }
              },
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: CFloatingActionButton(
        onPressed: () => openDialog(
          title: 'Adicionar Tarefa',
          context: context,
          actionLabel: 'Adicionar',
          onPressedAction: () async {
            if (_cubit.allTasksFormsAreValid()) {
              await _cubit.addNewTask();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBarWidget(
                  message: 'Por favor verifique os dados e tente novamente',
                  context: context,
                ),
              );
            }
            if (context.mounted) Navigator.of(context).pop();
            _cubit.validationHelper.checkForms.clear();
          },
          content: Column(
            children: [
              const SizedBox(height: 16),
              CTextForm(
                label: 'Nome',
                hintText: 'Informe o nome da sua tarefa',
                controller: _cubit.taskNameController,
                onValidation: (value) => combine(
                  [
                    () => isNotEmpty(value),
                    () => isGreaterThan(value, 3),
                  ],
                  onValid: () {
                    _cubit.validationHelper.addToCheckForm('taskName');
                    _cubit.allTasksFormsAreValid();
                  },
                  onInvalid: () {
                    _cubit.validationHelper.removeToCheckForm('taskName');
                    _cubit.allTasksFormsAreValid();
                  },
                ),
              ),
              const SizedBox(height: 8),
              CTextForm(
                label: 'Data',
                hintText: 'Informe uma data',
                controller: _cubit.taskDateController,
                type: CTextFormType.date,
                onValidation: (value) => isValidDate(
                  value,
                  onValid: () {
                    _cubit.validationHelper.addToCheckForm('taskDate');
                    _cubit.allTasksFormsAreValid();
                  },
                  onInvalid: () {
                    _cubit.validationHelper.removeToCheckForm('taskDate');
                    _cubit.allTasksFormsAreValid();
                  },
                ),
              ),
              const SizedBox(height: 8),
              CTextForm(
                height: 100,
                label: 'Descrição',
                hintText: 'Informe sua descrição aqui',
                maxLines: 3,
                controller: _cubit.taskDescriptionController,
                onValidation: (value) => combine(
                  [
                    () => isNotEmpty(value),
                    () => isGreaterThan(value, 8),
                  ],
                  onValid: () {
                    _cubit.validationHelper.addToCheckForm('taskDescription');
                    _cubit.allTasksFormsAreValid();
                  },
                  onInvalid: () {
                    _cubit.validationHelper.removeToCheckForm('taskDescription');
                    _cubit.allTasksFormsAreValid();
                  },
                ),
              ),
              const SizedBox(height: 8),
              CButton(
                label: 'Adicionar imagem',
                onPressed: () => _cubit.selectImageToAddTask(),
                icon: const Icon(
                  Icons.add,
                  color: AppStyleColors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
