import 'package:flutter/material.dart';
import 'package:r5_todo_app/models/task.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(
    this.task, {
    super.key,
    required this.onChanged,
  });

  final Task task;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
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
              10,
            ),
          ),
        ),
        child: Row(
          children: [
            Checkbox(
              value: task.completed,
              onChanged: onChanged,
            ),
            Text(
              task.name,
              style: TextStyle(
                fontSize: 18,
                decoration: task.completed
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            )
          ],
        ),
      ),
    );
  }
}
