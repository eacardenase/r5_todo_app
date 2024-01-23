import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:r5_todo_app/models/task.dart';
import 'package:r5_todo_app/providers/task/task_provider.dart';

class TaskItem extends ConsumerStatefulWidget {
  const TaskItem(
    this.task, {
    super.key,
  });

  final Task task;

  @override
  ConsumerState<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends ConsumerState<TaskItem> {
  @override
  Widget build(BuildContext context) {
    print("Task Translation:");
    print(widget.task.translation);

    return Padding(
      padding: const EdgeInsets.only(top: 25, right: 25, bottom: 0, left: 25),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
        decoration: const BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(
            Radius.circular(
              20,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
              value: widget.task.completed,
              onChanged: (_) {
                ref
                    .watch(tasksProvider.notifier)
                    .toggleComplete(widget.task.id!);
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.task.name,
                  style: TextStyle(
                    fontSize: 18,
                    decoration: widget.task.completed
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                Text(
                  widget.task.formattedDate,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
