# Student Attendance Tracker

A single-screen Flutter app for managing student attendance, built to
practise **Provider** state management.

## Features

- View a list of students with their attendance status
- Tick the checkbox to mark **Present**; untick for **Absent**
- Add a student with the floating action button (starts as Absent)
- Delete a student with the trash icon
- Live statistics: **Total Students**, **Present**, **Absent**
- Friendly empty-state message when the list is empty
- Student name can't be empty (or just spaces)

## How Provider is used

| Requirement                | Where                                         |
| -------------------------- | --------------------------------------------- |
| `Student` model            | `lib/models/student.dart`                     |
| `AttendanceProvider`       | `lib/providers/attendance_provider.dart`      |
| `ChangeNotifierProvider`   | `lib/main.dart`                               |
| `context.read()` actions   | `student_tile.dart`, `add_student_dialog.dart` |
| `Consumer`                 | `lib/widgets/student_list.dart`               |
| `context.watch()`          | `lib/widgets/stats_card.dart`                 |
| `notifyListeners()`        | every action in `AttendanceProvider`          |

No `setState()` is used for student or attendance data, and no other state
management package is involved.

## Project structure

```
lib/
├── main.dart                     # App root + ChangeNotifierProvider
├── models/student.dart
├── providers/attendance_provider.dart
├── screens/attendance_screen.dart
└── widgets/
    ├── add_student_dialog.dart
    ├── empty_state.dart
    ├── stats_card.dart
    ├── student_list.dart
    └── student_tile.dart
test/
├── attendance_provider_test.dart
└── attendance_screen_test.dart
```

## Getting started

This repo contains the Dart source and config. Generate the platform
folders (android, ios, web...) once, then run:

```bash
flutter create .          # adds platform folders; keeps existing lib/ and pubspec
flutter pub get
flutter run
flutter test              # run the unit and widget tests
```
