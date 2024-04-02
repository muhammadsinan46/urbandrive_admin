import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ud_admin/features/dashboard/data/titile_data.dart';

class DonutChartWdget extends StatelessWidget {
  const DonutChartWdget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        children: [
          PieChart(PieChartData(
            startDegreeOffset: 250,
            sectionsSpace: 0,
            centerSpaceRadius: 100,
            sections: [
                PieChartSectionData(
                      value: 45,
                      color: Colors.greenAccent,
                      radius: 45,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      value: 35,
                      color: Colors.blue.shade900,
                      radius: 25,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      value: 20,
                      color: Colors.grey.shade400,
                      radius: 20,
                      showTitle: false,
                    ),
            ]
          ))
        ],
      ),
    );
  }
}