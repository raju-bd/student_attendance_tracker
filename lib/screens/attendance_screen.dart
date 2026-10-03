import 'package:flutter/material.dart';

import '../widgets/add_student_dialog.dart';
import '../widgets/stats_card.dart';
import '../widgets/student_list.dart';

/// The one and only screen of the app.
class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  /// Opens the "Add Student" dialog.
  void _showAddDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => const AddStudentDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Tracker')),
      body: const Column(
        children: [
          StatsCard(),
          Expanded(child: StudentList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        tooltip: 'Add student',
        child: const Icon(Icons.add),
      ),
    );
  }
}
