import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/student.dart';
import '../providers/attendance_provider.dart';

/// One row in the list: name, status, a checkbox and a delete button.
///
/// The tile only *displays* the student it is given. Changes go through
/// the provider using context.read, because actions don't need to rebuild
/// anything by themselves; the provider's notifyListeners does that.
class StudentTile extends StatelessWidget {
  final Student student;

  const StudentTile({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final statusColor =
        student.isPresent ? Colors.green.shade700 : Colors.red.shade700;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          // First letter of the name as a quick avatar.
          child: Text(String.fromCharCode(student.name.runes.first).toUpperCase()),
        ),
        title: Text(student.name),
        subtitle: Text(
          student.statusLabel,
          key: ValueKey('status_${student.id}'),
          style: TextStyle(color: statusColor, fontWeight: FontWeight.w600),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              key: ValueKey('checkbox_${student.id}'),
              value: student.isPresent,
              // Checked -> Present, unchecked -> Absent.
              onChanged: (checked) {
                context
                    .read<AttendanceProvider>()
                    .setAttendance(student.id, checked ?? false);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Colors.red.shade400,
              tooltip: 'Remove ${student.name}',
              onPressed: () {
                context.read<AttendanceProvider>().removeStudent(student.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
