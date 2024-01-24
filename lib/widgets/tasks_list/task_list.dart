import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:r5_todo_app/models/task.dart';
import 'package:r5_todo_app/providers/task/task_provider.dart';
import 'package:r5_todo_app/services/firestore.dart';
import 'package:r5_todo_app/widgets/tasks_list/task_item.dart';

class TaskList extends ConsumerStatefulWidget {
  const TaskList({
    super.key,
    required this.tasks,
  });

  final List<QueryDocumentSnapshot> tasks;

  @override
  ConsumerState<TaskList> createState() => _TaskListState();
}

class _TaskListState extends ConsumerState<TaskList> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        DocumentSnapshot document = widget.tasks[index];
        String docId = document.id;

        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        String taskTitle = data['title'];
        String taskTranslation = data['translation'];
        bool taskCompleted = data['completed'];

        final task = Task(
          title: taskTitle,
          completed: taskCompleted,
        );

        task.id = docId;
        task.translation = taskTranslation;

        return Dismissible(
          key: ValueKey(docId),
          direction: DismissDirection.horizontal,
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              ref.watch(tasksProvider.notifier).toggleComplete(docId);

              return false;
            }

            ref.watch(tasksProvider.notifier).remove(docId);

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
