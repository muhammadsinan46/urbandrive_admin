

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TitleData{


  static getTitleData()=> FlTitlesData(
  
    show: true,
    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    leftTitles: AxisTitles(

      sideTitles: SideTitles(showTitles: true,
        reservedSize: 25,
      
      getTitlesWidget: (value,meta) {

         switch (value.toInt()){
              case 1:
                return Text("100K", style: TextStyle(fontSize: 12),);
               case 3:
                return Text("300K", style: TextStyle(fontSize: 12));
                 case 5:
                return Text("700K", style: TextStyle(fontSize: 12));
              


          }

        return Text("");
        
      },)
    ),
    bottomTitles:AxisTitles(
      
      sideTitles: SideTitles(
            reservedSize: 22,
        showTitles: true,
        
        getTitlesWidget: (value, _) {
          switch (value.toInt()){
              case 2:
                return Text("MON", style: TextStyle(fontWeight: FontWeight.bold,),);
               case 4:
                return Text("TUE",style: TextStyle(fontWeight: FontWeight.bold),);
                 case 6:
                return Text("WED",style: TextStyle(fontWeight: FontWeight.bold),);
                 case 8:
                return Text("THU",style: TextStyle(fontWeight: FontWeight.bold),);
                 case 10:
                return Text("FRI",style: TextStyle(fontWeight: FontWeight.bold),);
                 case 12:
                return Text("SAT",style: TextStyle(fontWeight: FontWeight.bold),);

                 case 14:
                return Text("SUN",style: TextStyle(fontWeight: FontWeight.bold),);


          }

          return Text("");
        },
      )
    )
  );
}