import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:r5_todo_app/models/task.dart';
import 'package:r5_todo_app/services/firestore.dart';

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]);

  final FirestoreService firestoreService = FirestoreService();

  void add(String taskTitle) {
    final Task newTask = Task(title: taskTitle);

    firestoreService.addTask(newTask);
  }

  void remove(String taskId) {
    firestoreService.removeTask(taskId);
  }

  void toggleComplete(String id) {
    firestoreService.updateTask(id);
  }
}
