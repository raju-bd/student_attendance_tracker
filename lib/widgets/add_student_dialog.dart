import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/attendance_provider.dart';

/// Dialog with a name field and an Add button.
///
/// It's a StatefulWidget only because the TextEditingController needs to be
/// created and disposed properly. No student/attendance state lives here and
/// there are no setState calls; validation is handled by the Form.
class AddStudentDialog extends StatefulWidget {
  const AddStudentDialog({super.key});

  @override
  State<AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// Validates the name, hands it to the provider, then closes the dialog.
  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<AttendanceProvider>().addStudent(_nameController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Student'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _nameController,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: 'Student name',
            hintText: 'e.g. Rahim Uddin',
            border: OutlineInputBorder(),
          ),
          // Names can't be empty or just spaces.
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a student name';
            }
            return null;
          },
          // Pressing "done" on the keyboard works like tapping Add.
          onFieldSubmitted: (_) => _submit(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
