import 'package:flutter/material.dart';

import 'package:r5_todo_app/models/task.dart';
import 'package:r5_todo_app/widgets/tasks_list/task_list.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<Task> _registeredTasks = [
    Task(
      name: "Make Coffee",
      completed: true,
      date: DateTime.now(),
    ),
    Task(
      name: "Wash the dishes",
      completed: true,
      date: DateTime.now(),
    ),
    Task(
      name: "Conquer the world",
      completed: false,
      date: DateTime.now(),
    ),
  ];

  void _checkboxChanged(bool? value, Task task) {
    setState(() {
      task.completed = value ?? false;
    });
  }

  void _removeTask(int index, Task task) {
    setState(() {
      _registeredTasks.remove(task);
    });
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.yellow,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: TaskList(
        tasks: _registeredTasks,
        onChanged: (value) => _checkboxChanged,
        onRemoveTask: _removeTask,
      ),
    );
  }
}
