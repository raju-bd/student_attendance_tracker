import 'package:flutter/material.dart';

/// The one and only screen of the app.
/// For now it's just a shell; the pieces get added in the next commits.
class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Tracker')),
      body: const Center(child: Text('Student list coming soon')),
    );
  }
}
