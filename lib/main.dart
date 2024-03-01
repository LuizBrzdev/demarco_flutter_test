import 'package:demarco_flutter_test/src/core/style/app_theme_data.dart';
import 'package:demarco_flutter_test/src/modules/tasks/pages/tasks_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'demarco_flutter_test',
      theme: AppThemeData.themeData,
      home: const TasksPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
