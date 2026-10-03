import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/attendance_provider.dart';

/// Shows Total / Present / Absent at the top of the screen.
///
/// Nothing is stored here. Every number is read straight from the provider,
/// so the card refreshes by itself whenever the provider notifies.
class StatsCard extends StatelessWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch rebuilds this widget whenever the provider changes.
    final provider = context.watch<AttendanceProvider>();

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _StatItem(
              valueKey: const Key('stat_total'),
              label: 'Total Students',
              value: provider.totalCount,
              color: Colors.indigo,
            ),
            _StatItem(
              valueKey: const Key('stat_present'),
              label: 'Present',
              value: provider.presentCount,
              color: Colors.green.shade700,
            ),
            _StatItem(
              valueKey: const Key('stat_absent'),
              label: 'Absent',
              value: provider.absentCount,
              color: Colors.red.shade700,
            ),
          ],
        ),
      ),
    );
  }
}

/// One column of the stats row: a big number with a small label under it.
class _StatItem extends StatelessWidget {
  final Key valueKey;
  final String label;
  final int value;
  final Color color;

  const _StatItem({
    required this.valueKey,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$value',
          key: valueKey,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
