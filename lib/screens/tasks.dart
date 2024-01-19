import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "R5 ToDo",
        ),
        backgroundColor: Colors.yellow,
      ),
      body: const Center(
        child: Text(
          'My ToDo',
        ),
      ),
    );
  }
}
