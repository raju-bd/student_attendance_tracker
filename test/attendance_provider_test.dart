import 'package:flutter_test/flutter_test.dart';
import 'package:student_attendance_tracker/providers/attendance_provider.dart';

void main() {
  group('AttendanceProvider', () {
    test('starts empty with zeroed statistics', () {
      final provider = AttendanceProvider();

      expect(provider.students, isEmpty);
      expect(provider.totalCount, 0);
      expect(provider.presentCount, 0);
      expect(provider.absentCount, 0);
    });

    test('new students are added as absent', () {
      final provider = AttendanceProvider();

      final added = provider.addStudent('  Rahim  ');

      expect(added, isTrue);
      expect(provider.students.single.name, 'Rahim'); // trimmed
      expect(provider.students.single.isPresent, isFalse);
      expect(provider.absentCount, 1);
    });

    test('empty or blank names are rejected', () {
      final provider = AttendanceProvider();

      expect(provider.addStudent(''), isFalse);
      expect(provider.addStudent('   '), isFalse);
      expect(provider.totalCount, 0);
    });

    test('setAttendance updates the statistics', () {
      final provider = AttendanceProvider()..addStudent('Nusrat');
      final id = provider.students.first.id;

      provider.setAttendance(id, true);
      expect(provider.presentCount, 1);
      expect(provider.absentCount, 0);

      provider.setAttendance(id, false);
      expect(provider.presentCount, 0);
      expect(provider.absentCount, 1);
    });

    test('removeStudent deletes the student and updates the statistics', () {
      final provider = AttendanceProvider()
        ..addStudent('Tanvir')
        ..addStudent('Farhana');
      provider.setAttendance(provider.students.first.id, true);

      provider.removeStudent(provider.students.first.id);

      expect(provider.totalCount, 1);
      expect(provider.presentCount, 0);
      expect(provider.absentCount, 1);
    });

    test('listeners are notified when data changes', () {
      final provider = AttendanceProvider();
      var notifications = 0;
      provider.addListener(() => notifications++);

      provider.addStudent('Rahim');
      provider.setAttendance(provider.students.first.id, true);
      provider.removeStudent(provider.students.first.id);

      expect(notifications, 3);
    });
  });
}
