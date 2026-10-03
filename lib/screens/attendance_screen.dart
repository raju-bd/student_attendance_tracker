import 'package:flutter/material.dart';

import '../widgets/stats_card.dart';
import '../widgets/student_list.dart';

/// The one and only screen of the app.
class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

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
    );
  }
}
