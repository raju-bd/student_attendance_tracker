import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/attendance_provider.dart';
import 'screens/attendance_screen.dart';

void main() {
  runApp(const AttendanceApp());
}

/// Root widget. The provider sits *above* MaterialApp so that everything
/// below it, including dialogs (which live in the Navigator's overlay),
/// can reach the same AttendanceProvider.
class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AttendanceProvider(withSampleData: true),
      child: MaterialApp(
        title: 'Student Attendance Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 127, 144, 242),
            style: TextStyle(color: Colors.white),
          
          ),
        ),
        home: const AttendanceScreen(),
      ),
    );
  }
}
