import 'package:demarco_flutter_test/src/core/style/app_style_colors.dart';
import 'package:demarco_flutter_test/src/modules/tasks/presentation/blocs/cubit/tasks_cubit.dart';
import 'package:demarco_flutter_test/src/modules/tasks/presentation/blocs/states/tasks_state.dart';
import 'package:demarco_flutter_test/src/modules/tasks/widgets/carrousel_slider_widget.dart';
import 'package:demarco_flutter_test/src/shared/components/actions/c_task_checkbox_tile.dart';
import 'package:demarco_flutter_test/src/shared/components/buttons/c_button.dart';
import 'package:demarco_flutter_test/src/shared/components/buttons/c_floating_action_button.dart';
import 'package:demarco_flutter_test/src/shared/components/forms/c_text_form.dart';
import 'package:demarco_flutter_test/src/shared/components/overlays/c_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../widgets/tasks_skeleton_widget.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
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
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            child: const Text(
                              'Ops...Parece que você ainda não possui nenhuma tarefa',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
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
          onPressedAction: () {
            _cubit.addNewTask();
            Navigator.of(context).pop();
          },
          content: Column(
            children: [
              const SizedBox(height: 16),
              CTextForm(
                label: 'Nome',
                hintText: 'Informe o nome da sua tarefa',
                controller: _cubit.taskNameController,
              ),
              const SizedBox(height: 8),
              CTextForm(
                label: 'Data',
                hintText: 'Informe uma data',
                controller: _cubit.taskDateController,
                type: CTextFormType.date,
              ),
              const SizedBox(height: 8),
              CTextForm(
                height: 100,
                label: 'Descrição',
                hintText: 'Informe sua descrição aqui',
                maxLines: 3,
                controller: _cubit.taskDescriptionController,
                onChanged: (value) {},
              ),
              const SizedBox(height: 8),
              const CButton(
                label: 'Adicionar imagem',
                icon: Icon(
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
