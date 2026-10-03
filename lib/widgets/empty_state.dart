import 'package:flutter/material.dart';

/// Friendly message shown when the student list is empty.
class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.groups_outlined, size: 72, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text('No students yet', style: textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'Tap the + button to add your first student.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
