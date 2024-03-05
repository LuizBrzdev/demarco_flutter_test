import 'package:demarco_flutter_test/src/core/bindings/app_bindings.dart';
import 'package:demarco_flutter_test/src/core/style/app_theme_data.dart';
import 'package:demarco_flutter_test/src/modules/tasks/presentation/bindings/tasks_bindigs.dart';
import 'package:demarco_flutter_test/src/modules/tasks/presentation/blocs/cubits/tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'src/modules/tasks/presentation/pages/tasks_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(
    MaterialApp(
      title: 'demarco_flutter_test',
      theme: AppThemeData.themeData,
      home: TasksPage(cubit: GetIt.instance<TasksCubit>()),
      debugShowCheckedModeBanner: false,
    ),
  );
}

Future<void> initDependencies() async {
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting();
  AppBindings.setupAppBindings();
  TasksBindings.setupTaskBindings();
  await GetIt.instance.allReady();
}
