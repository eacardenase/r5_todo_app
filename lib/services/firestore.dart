import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:r5_todo_app/models/task.dart';

class FirestoreService {
  // Get Tasks Collection
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection("tasks");

  // Create
  Future<void> addTask(Task task) {
    return tasks.add({
      "title": task.title,
      "translation": task.translation,
      "date": task.date,
      "completed": task.completed,
    });
  }

  Future<void> updateTask(String taskId) async {
    final task = await tasks.doc(taskId).get();
    Map<String, dynamic> taskData = task.data() as Map<String, dynamic>;

    bool taskCompleted = taskData['completed'];

    return tasks.doc(taskId).update({
      "completed": !taskCompleted,
    });
  }

  Future<void> removeTask(String taskId) {
    return tasks.doc(taskId).delete();
  }

  Stream<QuerySnapshot> getTasksStream() {
    final tasksStream = tasks.orderBy('date', descending: true).snapshots();

    return tasksStream;
  }
}
