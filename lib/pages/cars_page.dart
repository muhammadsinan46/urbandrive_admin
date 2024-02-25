import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ud_admin/pages/add_car_screen.dart';

class CarsScreen extends StatefulWidget {
  CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  bool isimageAvailable = false;
   Uint8List? imageFile;
  var priceController = TextEditingController();

  // String? brand;
  String? brandValue;
  String? modelValue;
  String? typeValue;
  String? fuelvalue;
  String? transmitValue;
  String? seatsValue;
  String? availableValue;
  String? laggageValue;

  List<String> modelList = [
    "C-Class",
    "E-Class",
    "S-Class",
    "GLC",
    "GLE",
    "GLS"
  ];

  List<String> typeList = [
    "Sedan",
    "SUV",
    "Coupe",
    "Convertible",
    "Hatchback",
    "Crossover",
    "Wagon",
    "Sports Car",
    "Luxury Car",
    "Electric Vehicle (EV)",
    "Hybrid",
  ];

  List<String> brandList = [
    "Mercedes-Benz",
    "BMW",
    "Audi",
    "Jaguar",
    "Land Rover",
    "Lexus",
    "Volvo",
    "Porsche",
    "Bentley",
    "Rolls-Royce"
  ];
  List<String> transmitList = ["automatic", "manual"];
  List<String> seatsList = ["2", "4", "5"];
  List<String> availableList = ["Available", "Sold out"];

  List<String> fuelList = ['Petrol', 'Diesel', 'Ev', 'Hybrid'];

  List<String> laggageList = ["2", "4", "no space"];

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Form(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cars",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              GestureDetector(
                                onTap: () {
                                  print(brandValue);
                                },
                                child: Container(
                                  color: Colors.black,
                                  height: 50,
                                  width: 100,
                                  child: const Center(
                                      child: Text(
                                    "Add",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(border: Border.all()),
                                height: 50,
                                width: 100,
                                child: Center(child: Text("Cancel")),
                              ),
                            ],
                            title: const Text("Add Car Details"),
                            content: Card(
                              child: Container(
                                height: 500,
                                width: MediaQuery.of(context).size.width - 420,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 224, 224, 224),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          behavior: HitTestBehavior.translucent,
                                          onTap:() =>pickImage(),
                                          child: Container(
                                            margin: EdgeInsets.all(40),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 147, 147, 147)),
                                              // color: const Color.fromARGB(
                                              //     255, 186, 186, 186),
                                            ),
                                            height: 250,
                                            width: 400,
                                            child: isimageAvailable
                                                ? Image.memory(imageFile!)
                                                : const Icon(
                                                    Icons.add_a_photo_outlined,
                                                    size: 50,
                                                    color: Color.fromARGB(
                                                        255, 203, 203, 203),
                                                  ),
                                          ),
                                        ),
                                        
                                        Row(
                                          children: [
                                            Container(
                                              child: Icon(
                                                Icons.add_a_photo_outlined,
                                                color: const Color.fromARGB(
                                                    255, 203, 203, 203),
                                              ),
                                              margin: EdgeInsets.all(40),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 186, 186, 186),
                                              ),
                                              height: 80,
                                              width: 100,
                                            ),
                                            Container(
                                              child: Icon(
                                                Icons.add_a_photo_outlined,
                                                color: const Color.fromARGB(
                                                    255, 203, 203, 203),
                                              ),
                                              margin: EdgeInsets.all(40),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 186, 186, 186),
                                              ),
                                              height: 80,
                                              width: 100,
                                            ),
                                            Container(
                                              child: Icon(
                                                Icons.add_a_photo_outlined,
                                                color: const Color.fromARGB(
                                                    255, 203, 203, 203),
                                              ),
                                              margin: EdgeInsets.all(40),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 186, 186, 186),
                                              ),
                                              height: 80,
                                              width: 100,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 400,
                                      width: 270,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          AddCarDropMenu(
                                            brandList: brandList,
                                            hintTexted: "Brand",
                                            brandValue: brandValue,
                                          ),
                                          AddCarDropMenu(
                                            brandList: modelList,
                                            hintTexted: "Model",
                                            brandValue: modelValue,
                                          ),
                                          AddCarDropMenu(
                                            brandList: typeList,
                                            hintTexted: "Type",
                                            brandValue: typeValue,
                                          ),
                                          AddCarDropMenu(
                                            brandList: fuelList,
                                            hintTexted: "Fuel",
                                            brandValue: fuelvalue,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      height: 400,
                                      width: 280,
                                      decoration: BoxDecoration(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextField(
                                            decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: "Price"),
                                            controller: priceController,
                                          ),
                                          AddCarDropMenu(
                                            brandList: availableList,
                                            hintTexted: "Availability",
                                            brandValue: availableValue,
                                          ),
                                          AddCarDropMenu(
                                            brandList: transmitList,
                                            hintTexted: "Transmission",
                                            brandValue: transmitValue,
                                          ),
                                          Row(
                                            // mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                height: 50,
                                                width: 120,
                                                child: AddCarDropMenu(
                                                  brandList: laggageList,
                                                  hintTexted: "Baggage",
                                                  brandValue: laggageValue,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 50,
                                                width: 100,
                                                child: AddCarDropMenu(
                                                  brandList: seatsList,
                                                  hintTexted: "Seats",
                                                  brandValue: seatsValue,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    height: 40,
                    width: 100,
                    child: const Center(
                        child: Text(
                      "Add Car",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  pickImage() async {
    final image = await ImagePickerWeb.getImageAsBytes();

    try {
      if (image != null) {
        setState(() {
          imageFile = image;
          isimageAvailable = true;
         // print(imageFile.first!);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
