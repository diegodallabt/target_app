import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  final int letterCount;
  final int numberCount;

  const PieChartWidget({
    super.key,
    required this.letterCount,
    required this.numberCount,
  });

  @override
  Widget build(BuildContext context) {
    final total = letterCount + numberCount;
    
    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            value: letterCount.toDouble(),
            title: '${((letterCount / total) * 100).toStringAsFixed(1)}%',
            color: Colors.blue,
            radius: 80,
            titleStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          PieChartSectionData(
            value: numberCount.toDouble(),
            title: '${((numberCount / total) * 100).toStringAsFixed(1)}%',
            color: Colors.green,
            radius: 80,
            titleStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {},
        ),
      ),
    );
  }
}
