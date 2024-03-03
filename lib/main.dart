import 'package:demarco_flutter_test/src/core/style/app_theme_data.dart';
import 'package:demarco_flutter_test/src/modules/tasks/infra/bindings/tasks_bindigs.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'src/modules/tasks/presentation/pages/tasks_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();

  runApp(
    MaterialApp(
      title: 'demarco_flutter_test',
      theme: AppThemeData.themeData,
      home: const TasksPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

void initDependencies() async {
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting();
  await GetIt.instance.allReady();
  TasksBindings.setupTaskBindings();
}
