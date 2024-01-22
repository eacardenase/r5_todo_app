import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:r5_todo_app/models/task.dart';
import 'package:r5_todo_app/providers/completed_tasks.dart';
import 'package:r5_todo_app/widgets/tasks_list/task_item.dart';

class TaskList extends ConsumerStatefulWidget {
  const TaskList({
    super.key,
    required this.tasks,
  });

  final List<Task> tasks;

  @override
  ConsumerState<TaskList> createState() => _TaskListState();
}

class _TaskListState extends ConsumerState<TaskList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        final task = widget.tasks[index];

        return Dismissible(
          key: ValueKey(task.id),
          direction: DismissDirection.horizontal,
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              ref
                  .watch(completedTasksProvider.notifier)
                  .toggleComplete(task.id);

              return false;
            }

            ref.watch(completedTasksProvider.notifier).remove(task);

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
          ),
        );
      },
    );
  }
}
