import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:r5_todo_app/models/task.dart';
import 'package:r5_todo_app/services/tasks.dart';

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]);

  final TasksService tasksService = TasksService();

  void add(String taskTitle) {
    final Task newTask = Task(title: taskTitle);

    tasksService.addTask(newTask);
  }

  void remove(String taskId) {
    tasksService.removeTask(taskId);
  }

  void toggleComplete(String id) {
    tasksService.updateTask(id);
  }
}
