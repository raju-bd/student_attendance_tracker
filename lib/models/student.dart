/// A single student in the attendance list.
///
/// The model is immutable on purpose: when attendance changes we create a
/// fresh copy with [copyWith] and let the provider swap it into the list.
/// That keeps all the "who changed what" logic in one place (the provider).
class Student {
  /// Unique id so we can find the right student even if two share a name.
  final String id;

  /// Display name shown in the list.
  final String name;

  /// true = Present, false = Absent. New students start out absent.
  final bool isPresent;

  const Student({
    required this.id,
    required this.name,
    this.isPresent = false,
  });

  /// Returns a copy of this student with the given fields replaced.
  Student copyWith({String? name, bool? isPresent}) {
    return Student(
      id: id,
      name: name ?? this.name,
      isPresent: isPresent ?? this.isPresent,
    );
  }

  /// Human-friendly label used by the UI ("Present" / "Absent").
  String get statusLabel => isPresent ? 'Present' : 'Absent';
}
