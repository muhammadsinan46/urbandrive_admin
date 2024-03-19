import 'package:flutter/material.dart';

class CarData {


  String? categoryValue;
  String? brandValue;
  String? modelValue;
  String? transmitValue;
  String? fuelValue;
  String? baggageValue;
  String? priceValue;
  String? seatsValue;
  String? colorValue;
  String? depositValue;
  String? freekmsValue;
  String? extrakmsValue;
  String? cityValue;

  List<String> transmitList = ["automatic", "manual"];

  List<String> seatsList = ["2", "4", "5"];

  List<String> availableList = ["Available", "Sold out"];

  List<String> fuelList = [
    'Petrol',
    'Diesel',
    'Electric',
  ];

  List<String> cityList =["Kochi","Bengaluru", "Chennai", "Delhi", "Chennai","Hydrabad"];
  List<Map<String, Color>> colorlist =[
    { "White":Colors.white, },
    { "Black":Colors.black, },
    { "Blue":Colors.blue, },
    { "Red":Colors.red, },
    { "Green":Colors.green, },
    { "Grey":Colors.grey, },
    { "Yellow":Colors.yellow, },
  
  ];

  List<String> baggageList = ["2", "4", "no space"];
}
