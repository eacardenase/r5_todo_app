import 'package:flutter/material.dart';

import 'package:r5_todo_app/models/task.dart';
import 'package:r5_todo_app/widgets/tasks_list/task_item.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.tasks,
    required this.onChanged,
    required this.onRemoveTask,
  });

  final List<Task> tasks;
  final void Function(bool?)? onChanged;
  final void Function(int index, Task task) onRemoveTask;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];

        return Dismissible(
          key: ValueKey(task),
          direction: DismissDirection.horizontal,
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              print("Update Task");

              return false;
            }

            onRemoveTask(index, task);

            return true;
          },
          background: Padding(
            padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
            child: Container(
              padding: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: Colors.green.shade300,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              alignment: Alignment.centerLeft,
              child: const Icon(Icons.check),
            ),
          ),
          secondaryBackground: Padding(
            padding: const EdgeInsets.only(top: 25, right: 25, left: 25),
            child: Container(
              padding: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.red.shade300,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              alignment: Alignment.centerRight,
              child: const Icon(Icons.delete),
            ),
          ),
          child: TaskItem(
            task,
            onChanged: onChanged,
          ),
        );
      },
    );
  }
}
