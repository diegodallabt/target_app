import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:target_app/l10n/app_localizations.dart';

class BarChartWidget extends StatelessWidget {
  final int letterCount;
  final int numberCount;
  final int total;

  const BarChartWidget({
    super.key,
    required this.letterCount,
    required this.numberCount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: (total * 1.2),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String label;
              switch (group.x.toInt()) {
                case 0:
                  label = l10n.letters;
                  break;
                case 1:
                  label = l10n.numbers;
                  break;
                default:
                  label = '';
              }
              return BarTooltipItem(
                '$label\n${rod.toY.toInt()}',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const style = TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                );
                String text;
                switch (value.toInt()) {
                  case 0:
                    text = l10n.letters;
                    break;
                  case 1:
                    text = l10n.numbers;
                    break;
                  default:
                    text = '';
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(text, style: style),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: (total / 5).ceilToDouble(),
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.1),
              strokeWidth: 1,
            );
          },
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: letterCount.toDouble(),
                color: Colors.blue,
                width: 40,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: numberCount.toDouble(),
                color: Colors.green,
                width: 40,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
