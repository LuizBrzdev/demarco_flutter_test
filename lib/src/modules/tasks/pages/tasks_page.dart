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
      body: Container(),
    );
  }
}
