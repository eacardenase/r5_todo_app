import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:r5_todo_app/models/task.dart';
import 'package:r5_todo_app/providers/completed_tasks.dart';
import 'package:r5_todo_app/widgets/new_task/dialog_box.dart';
import 'package:r5_todo_app/widgets/tasks_list/task_list.dart';

const _uuid = Uuid();

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  final _controller = TextEditingController();

  void _saveNewTask() {
    ref.watch(completedTasksProvider.notifier).add(_controller.text);

    Navigator.of(context).pop();
  }

  void _createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: _saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(completedTasksProvider);

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
        onPressed: _createNewTask,
        backgroundColor: Colors.yellow,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: TaskList(
        tasks: tasks,
      ),
    );
  }
}
