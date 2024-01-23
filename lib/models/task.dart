import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();

class Task {
  Task({
    required this.name,
    this.translation = "",
    this.completed = false,
  });

  String? id;
  final String name;
  String translation;
  final bool completed;
  final DateTime date = DateTime.now();

  String get formattedDate {
    return dateFormatter.format(date);
  }
}
