import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();

class Task {
  Task({
    required this.title,
    this.translation = "...",
    this.completed = false,
  });

  String? id;
  String? userId;
  final String title;
  String translation;
  final bool completed;
  final DateTime date = DateTime.now();

  String get formattedDate {
    return dateFormatter.format(date);
  }
}
