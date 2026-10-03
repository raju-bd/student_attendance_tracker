import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/attendance_provider.dart';
import 'empty_state.dart';
import 'student_tile.dart';

/// Builds the scrolling list of students, or the empty-state message
/// when there's nobody on the list.
class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer rebuilds just this subtree when the provider notifies.
    return Consumer<AttendanceProvider>(
      builder: (context, provider, _) {
        final students = provider.students;

        if (students.isEmpty) {
          return const EmptyState();
        }

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 88), // room for the FAB
          itemCount: students.length,
          itemBuilder: (context, index) {
            final student = students[index];
            return StudentTile(key: ValueKey(student.id), student: student);
          },
        );
      },
    );
  }
}
