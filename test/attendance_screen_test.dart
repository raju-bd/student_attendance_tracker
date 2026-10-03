import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:student_attendance_tracker/providers/attendance_provider.dart';
import 'package:student_attendance_tracker/screens/attendance_screen.dart';

/// Wraps the screen with the same provider setup the real app uses.
Widget buildTestApp(AttendanceProvider provider) {
  return ChangeNotifierProvider.value(
    value: provider,
    child: const MaterialApp(home: AttendanceScreen()),
  );
}

/// Reads the number shown in one of the statistics boxes.
String statValue(WidgetTester tester, String key) {
  return tester.widget<Text>(find.byKey(Key(key))).data!;
}

void main() {
  testWidgets('shows the empty-state message when there are no students',
      (tester) async {
    await tester.pumpWidget(buildTestApp(AttendanceProvider()));

    expect(find.text('No students yet'), findsOneWidget);
    expect(statValue(tester, 'stat_total'), '0');
  });

  testWidgets('adds a student as Absent through the dialog', (tester) async {
    await tester.pumpWidget(buildTestApp(AttendanceProvider()));

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Rahim');
    await tester.tap(find.widgetWithText(FilledButton, 'Add'));
    await tester.pumpAndSettle();

    expect(find.text('Rahim'), findsOneWidget);
    expect(find.text('No students yet'), findsNothing);
    expect(statValue(tester, 'stat_total'), '1');
    expect(statValue(tester, 'stat_absent'), '1');
    expect(statValue(tester, 'stat_present'), '0');
  });

  testWidgets('does not accept an empty student name', (tester) async {
    final provider = AttendanceProvider();
    await tester.pumpWidget(buildTestApp(provider));

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Add'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter a student name'), findsOneWidget);
    expect(provider.totalCount, 0);
  });

  testWidgets('checking the box marks Present and updates statistics',
      (tester) async {
    final provider = AttendanceProvider()..addStudent('Nusrat');
    await tester.pumpWidget(buildTestApp(provider));
    final id = provider.students.first.id;

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(tester.widget<Text>(find.byKey(ValueKey('status_$id'))).data,
        'Present');
    expect(statValue(tester, 'stat_present'), '1');
    expect(statValue(tester, 'stat_absent'), '0');

    // Unchecking goes back to Absent.
    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(tester.widget<Text>(find.byKey(ValueKey('status_$id'))).data,
        'Absent');
    expect(statValue(tester, 'stat_absent'), '1');
  });

  testWidgets('delete icon removes the student and updates statistics',
      (tester) async {
    final provider = AttendanceProvider()..addStudent('Tanvir');
    await tester.pumpWidget(buildTestApp(provider));

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pump();

    expect(find.text('Tanvir'), findsNothing);
    expect(find.text('No students yet'), findsOneWidget);
    expect(statValue(tester, 'stat_total'), '0');
  });
}
