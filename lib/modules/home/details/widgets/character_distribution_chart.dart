import 'package:flutter/material.dart';
import 'package:target_app/l10n/app_localizations.dart';
import 'bar_chart_widget.dart';
import 'pie_chart_widget.dart';
import 'chart_legend.dart';

enum ChartType { bar, pie }

class CharacterDistributionChart extends StatefulWidget {
  final int letterCount;
  final int numberCount;

  const CharacterDistributionChart({
    super.key,
    required this.letterCount,
    required this.numberCount,
  });

  @override
  State<CharacterDistributionChart> createState() => _CharacterDistributionChartState();
}

class _CharacterDistributionChartState extends State<CharacterDistributionChart> {
  ChartType _chartType = ChartType.bar;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final total = widget.letterCount + widget.numberCount;
    
    if (total == 0) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.info_outline,
                size: 48,
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.noDataToDisplay,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.characterDistribution,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SegmentedButton<ChartType>(
                  segments: const [
                    ButtonSegment<ChartType>(
                      value: ChartType.bar,
                      icon: Icon(Icons.bar_chart, size: 16),
                    ),
                    ButtonSegment<ChartType>(
                      value: ChartType.pie,
                      icon: Icon(Icons.pie_chart, size: 16),
                    ),
                  ],
                  selected: {_chartType},
                  onSelectionChanged: (Set<ChartType> newSelection) {
                    setState(() {
                      _chartType = newSelection.first;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: _chartType == ChartType.bar
                  ? BarChartWidget(
                      letterCount: widget.letterCount,
                      numberCount: widget.numberCount,
                      total: total,
                    )
                  : PieChartWidget(
                      letterCount: widget.letterCount,
                      numberCount: widget.numberCount,
                    ),
            ),
            const SizedBox(height: 16),
            ChartLegend(
              letterCount: widget.letterCount,
              numberCount: widget.numberCount,
            ),
          ],
        ),
      ),
    );
  }
}
