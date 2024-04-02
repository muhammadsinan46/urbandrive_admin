import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ud_admin/features/dashboard/data/titile_data.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 300,
      child: LineChart(LineChartData(
        
          borderData: FlBorderData(show: false),
      
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        minX: 0,
        maxX: 14,
        minY: 0,
        maxY: 6,
        titlesData:TitleData.getTitleData(),
        gridData: FlGridData(
          
          show: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              
              strokeWidth:.2
            );
          },
          drawHorizontalLine: false,
          drawVerticalLine: false
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 3),
              FlSpot(2.0, 4),
              FlSpot(4, 2),
              FlSpot(6, 2),
              FlSpot(9, 5),
      
            ],
      
            isCurved: true,
            color: Colors.blue,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Color.fromARGB(255, 179, 221, 255),
            
            )
          )
        ]
      )),
    );
  }
}