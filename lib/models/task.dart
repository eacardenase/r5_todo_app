import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();

class Task {
  Task({
    required this.name,
    this.completed = false,
  });

  String? id;
  final String name;
  final bool completed;
  final DateTime date = DateTime.now();

  String get formattedDate {
    return dateFormatter.format(date);
  }
}
