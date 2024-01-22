import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:uuid/uuid.dart';

import 'package:r5_todo_app/models/task.dart';

const _uuid = Uuid();

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier()
      : super([
          Task(
            id: _uuid.v4(),
            name: "Make Coffee",
            completed: true,
          ),
          Task(
            id: _uuid.v4(),
            name: "Wash the dishes",
          ),
          Task(
            id: _uuid.v4(),
            name: "Conquer the world",
          ),
        ]);

  void add(String taskName) {
    state = [
      ...state,
      Task(id: _uuid.v4(), name: taskName),
    ];
  }

  void remove(Task target) {
    state = state.where((task) => task.id != target.id).toList();
  }

  void toggleComplete(String id) {
    state = [
      for (final task in state)
        if (task.id == id)
          Task(id: task.id, name: task.name, completed: !task.completed)
        else
          task
    ];
  }
}
