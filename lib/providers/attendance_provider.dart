import 'package:flutter/foundation.dart';

import '../models/student.dart';

/// Holds the student list and exposes everything the UI needs:
/// the students themselves, the attendance statistics, and the actions
/// that change them.
///
/// Every action that changes data finishes with [notifyListeners], which is
/// what makes widgets using `context.watch` / `Consumer` rebuild on their own.
class AttendanceProvider extends ChangeNotifier {
  AttendanceProvider({bool withSampleData = false}) {
    if (withSampleData) {
      // A few starter students so the app doesn't open on an empty screen.
      addStudent('Rahim Uddin');
      addStudent('Nusrat Jahan');
      addStudent('Tanvir Ahmed');
      addStudent('Farhana Akter');
    }
  }

  final List<Student> _students = [];

  /// Simple counter used to hand out unique ids.
  int _nextId = 0;

  // ---------------------------------------------------------------------
  // Read-only data for the UI
  // ---------------------------------------------------------------------

  /// An unmodifiable view, so widgets can't change the list behind our back.
  List<Student> get students => List.unmodifiable(_students);

  /// Total number of students on the list.
  int get totalCount => _students.length;

  /// How many students are currently marked present.
  int get presentCount => _students.where((s) => s.isPresent).length;

  /// Everyone who isn't present is absent.
  int get absentCount => totalCount - presentCount;

  // ---------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------

  /// Adds a new student (starting as Absent).
  ///
  /// Returns false and does nothing if the name is empty or only spaces.
  bool addStudent(String name) {
    final cleanName = name.trim();
    if (cleanName.isEmpty) return false;

    _students.add(Student(id: 'student_${_nextId++}', name: cleanName));
    notifyListeners();
    return true;
  }

  /// Marks a student present (true) or absent (false).
  void setAttendance(String id, bool isPresent) {
    final index = _students.indexWhere((s) => s.id == id);
    if (index == -1) return; // Student was already removed; nothing to do.

    _students[index] = _students[index].copyWith(isPresent: isPresent);
    notifyListeners();
  }

  /// Removes a student from the list.
  void removeStudent(String id) {
    final before = _students.length;
    _students.removeWhere((s) => s.id == id);

    // Only bother the UI if something was actually removed.
    if (_students.length != before) notifyListeners();
  }
}
