import 'package:demarco_flutter_test/src/core/style/app_theme_data.dart';
import 'package:flutter/material.dart';

import 'src/modules/tasks/presentation/pages/tasks_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      title: 'demarco_flutter_test',
      theme: AppThemeData.themeData,
      home: const TasksPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
