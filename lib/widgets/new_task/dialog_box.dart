import 'package:flutter/material.dart';

import 'package:r5_todo_app/widgets/new_task/dialog_button.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow.shade400,
      content: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Add a new task",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DialogButton(
                  text: "Cancel",
                  onPressed: onCancel,
                  backgroundColor: Colors.red.shade300,
                ),
                DialogButton(
                  text: "Save",
                  onPressed: onSave,
                  backgroundColor: Colors.blue.shade300,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
