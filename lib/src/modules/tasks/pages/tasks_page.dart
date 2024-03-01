import 'package:demarco_flutter_test/src/core/style/app_style_colors.dart';
import 'package:demarco_flutter_test/src/modules/tasks/widgets/carrousel_indicator.dart';
import 'package:demarco_flutter_test/src/modules/tasks/widgets/carrousel_slider.dart';
import 'package:demarco_flutter_test/src/shared/components/actions/c_task_checkbox_tile.dart';
import 'package:demarco_flutter_test/src/shared/components/buttons/c_button.dart';
import 'package:demarco_flutter_test/src/shared/components/buttons/c_floating_action_button.dart';
import 'package:demarco_flutter_test/src/shared/components/forms/c_text_form.dart';
import 'package:demarco_flutter_test/src/shared/components/overlays/c_dialog.dart';
import 'package:flutter/material.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

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
            const CarrouselSlider(itemCount: 3),
            const SizedBox(height: 20),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemCount: 6,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) => CTaskCheckBoxTile(
                completedTask: false,
                title: 'Tarefa $index',
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: CFloatingActionButton(
        onPressed: () {
          openDialog(
            title: 'Adicionar Tarefa',
            context: context,
            actionLabel: 'Adicionar',
            onPressedAction: () {
              Navigator.of(context).pop();
            },
            content: Column(
              children: [
                const SizedBox(height: 16),
                CTextForm(
                  label: 'Nome',
                  hintText: 'Informe o nome da sua tarefa',
                  onChanged: (value) {},
                  type: CTextFormType.date,
                ),
                const SizedBox(height: 8),
                CTextForm(
                  label: 'Data',
                  hintText: 'Informe uma data',
                  onChanged: (value) {},
                  type: CTextFormType.date,
                ),
                const SizedBox(height: 8),
                CTextForm(
                  height: 100,
                  label: 'Descrição',
                  hintText: 'Informe sua descrição aqui',
                  maxLines: 3,
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
          );
        },
      ),
    );
  }
}
