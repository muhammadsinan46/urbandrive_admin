import 'package:flutter/cupertino.dart';

class DashCardModel {


  int? totalBooking;
  int? totalCars;
  int ? totalCustomers;
  int? totalRevenue;

  DashCardModel(
      {
      
      required this.totalBooking,
      required this.totalCars,
      required this.totalCustomers,
      required this.totalRevenue
      });
}
