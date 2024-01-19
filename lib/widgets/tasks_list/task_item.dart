import 'package:flutter/material.dart';
import 'package:r5_todo_app/models/task.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(
    this.task, {
    super.key,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      color: Colors.blue,
    );
  }
}
