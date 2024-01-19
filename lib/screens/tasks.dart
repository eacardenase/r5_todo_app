import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade200,
      appBar: AppBar(
        title: Text(
          "R5 ToDo",
          style: TextStyle(
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        backgroundColor: Colors.yellow,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'My ToDo',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.yellow,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
