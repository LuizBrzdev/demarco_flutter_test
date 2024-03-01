import 'package:demarco_flutter_test/src/modules/tasks/pages/tasks_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'demarco_flutter_test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TasksPage(),
    ),
  );
}
