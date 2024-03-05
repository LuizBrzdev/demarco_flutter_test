// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

import '../../../../shared/components/overlays/c_snack_bar.dart';
import '../../widgets/tasks_skeleton_widget.dart';

class TasksPage extends StatefulWidget {
  final TasksCubit _cubit;

  const TasksPage({
    super.key,
    required TasksCubit cubit,
  }) : _cubit = cubit;

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with ValidationMixin {
  @override
  void initState() {
    super.initState();
    widget._cubit.fetchAllTasks();
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
              bloc: widget._cubit,
              builder: (context, state) {
                switch (state) {
                  case TasksLoadingState():
                    return const TasksSkeletonWidget(
                      key: Key('LoadingState'),
                    );
                  case TasksEmptyState():
                    return const TasksEmptyStateWidget(
                      key: Key('EmptyState'),
                    );

                  case TasksLoadedState():
                    return Column(
                      key: const Key('LoadedState'),
                      children: [
                        FadeOut(
                          child: Visibility(
                            visible:
                                widget._cubit.filterTasksByCompletedStatus(state.tasks).isNotEmpty,
                            replacement: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 12),
                              height: 200,
                              decoration: BoxDecoration(
                                color: AppStyleColors.primary,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(width: 1, color: AppStyleColors.primary),
                              ),
                              child: Center(
                                child: FadeIn(
                                  child: const Text(
                                    'Parabéns, você não tem nenhuma tarefa pendente',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, color: AppStyleColors.white),
                                  ),
                                ),
                              ),
                            ),
                            child: CarrouselSlider(
                              itemCount:
                                  widget._cubit.filterTasksByCompletedStatus(state.tasks).length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: CarrouselImage(
                                  imageUrl: widget._cubit
                                      .filterTasksByCompletedStatus(state.tasks)[index]
                                      .image,
                                  taskName: widget._cubit
                                      .filterTasksByCompletedStatus(state.tasks)[index]
                                      .name,
                                  taskDate: widget._cubit
                                      .filterTasksByCompletedStatus(state.tasks)[index]
                                      .date,
                                ),
                              ),
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
                              widget._cubit.updateCompletedStatus(state.tasks[index]);
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
            if (widget._cubit.allTasksFormsAreValid()) {
              await widget._cubit.addNewTask();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBarWidget(
                  message: 'Por favor verifique os dados e tente novamente',
                  context: context,
                ),
              );
            }
            if (context.mounted) Navigator.of(context).pop();
            widget._cubit.validationHelper.checkForms.clear();
          },
          content: Column(
            children: [
              const SizedBox(height: 16),
              CTextForm(
                label: 'Nome',
                hintText: 'Informe o nome da sua tarefa',
                controller: widget._cubit.taskNameController,
                onValidation: (value) => combine(
                  [
                    () => isNotEmpty(value),
                    () => isGreaterThan(value, 3),
                  ],
                  onValid: () {
                    widget._cubit.validationHelper.addToCheckForm('taskName');
                    widget._cubit.allTasksFormsAreValid();
                  },
                  onInvalid: () {
                    widget._cubit.validationHelper.removeToCheckForm('taskName');
                    widget._cubit.allTasksFormsAreValid();
                  },
                ),
              ),
              const SizedBox(height: 8),
              CTextForm(
                label: 'Data',
                hintText: 'Informe uma data',
                controller: widget._cubit.taskDateController,
                type: CTextFormType.date,
                onValidation: (value) => isValidDate(
                  value,
                  onValid: () {
                    widget._cubit.validationHelper.addToCheckForm('taskDate');
                    widget._cubit.allTasksFormsAreValid();
                  },
                  onInvalid: () {
                    widget._cubit.validationHelper.removeToCheckForm('taskDate');
                    widget._cubit.allTasksFormsAreValid();
                  },
                ),
              ),
              const SizedBox(height: 8),
              CTextForm(
                height: 100,
                label: 'Descrição',
                hintText: 'Informe sua descrição aqui',
                maxLines: 3,
                controller: widget._cubit.taskDescriptionController,
                onValidation: (value) => combine(
                  [
                    () => isNotEmpty(value),
                    () => isGreaterThan(value, 8),
                  ],
                  onValid: () {
                    widget._cubit.validationHelper.addToCheckForm('taskDescription');
                    widget._cubit.allTasksFormsAreValid();
                  },
                  onInvalid: () {
                    widget._cubit.validationHelper.removeToCheckForm('taskDescription');
                    widget._cubit.allTasksFormsAreValid();
                  },
                ),
              ),
              const SizedBox(height: 8),
              CButton(
                label: 'Adicionar imagem',
                onPressed: () => widget._cubit.selectImageToAddTask(),
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
