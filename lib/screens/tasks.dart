import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:r5_todo_app/providers/task/task_provider.dart';
import 'package:r5_todo_app/services/firestore.dart';
import 'package:r5_todo_app/widgets/new_task/dialog_box.dart';
import 'package:r5_todo_app/widgets/tasks_list/task_list.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen> {
  final _controller = TextEditingController();

  void _saveNewTask() {
    ref.watch(tasksProvider.notifier).add(_controller.text);

    _controller.clear();

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
    final FirestoreService firestoreService = FirestoreService();

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
      body: StreamBuilder(
        stream: firestoreService.getTasksStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Something went wrong.',
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No tasks found.',
              ),
            );
          }

          final loadedTasks = snapshot.data!.docs;

          return TaskList(tasks: loadedTasks);
        },
      ),
    );
  }
}
