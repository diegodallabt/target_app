import 'package:flutter/material.dart';
import 'package:target_app/l10n/app_localizations.dart';

class ChartLegend extends StatelessWidget {
  final int letterCount;
  final int numberCount;

  const ChartLegend({
    super.key,
    required this.letterCount,
    required this.numberCount,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _LegendItem(
          color: Colors.blue,
          label: l10n.letters,
          value: letterCount,
        ),
        _LegendItem(
          color: Colors.green,
          label: l10n.numbers,
          value: numberCount,
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final int value;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$label: $value',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
