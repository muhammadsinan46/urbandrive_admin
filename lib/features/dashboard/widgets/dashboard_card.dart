import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  DashboardCard({
    super.key,
    required this.value,
    required this.title,
    required this.icon,
    required this.bgColor,
  });

  final String value;
  final String title;
  final String icon;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(2, 2))
          ],
          borderRadius: BorderRadius.circular(20)),
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: bgColor,
                boxShadow: [
                  BoxShadow(blurRadius: 4, color: bgColor, offset: Offset(2, 2))
                ]),
            height: 40,
            width: 40,
            child: Center(
                child: ImageIcon(
              AssetImage(icon),
              color: Colors.white,
            )),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Text(
            "${value}",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
