import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:r5_todo_app/models/task.dart';
import 'package:r5_todo_app/providers/completed_tasks.dart';
import 'package:r5_todo_app/widgets/tasks_list/task_list.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  void _checkboxChanged(bool? value, Task task) {
    setState(() {
      // task.completed = value ?? false;
    });
  }

  void _removeTask(int index, Task task) {
    setState(() {
      // _registeredTasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(completedMealsProvider);

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
        tasks: tasks,
        onChanged: (value) => _checkboxChanged,
        onRemoveTask: _removeTask,
      ),
    );
  }
}
