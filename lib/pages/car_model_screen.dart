// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_admin/application/carModelScreen/model_image_bloc/carscreen_bloc.dart';

import 'package:ud_admin/domain/car_data.dart';
import 'package:ud_admin/pages/add_car_screen.dart';

class ModelScreen extends StatelessWidget {
  ModelScreen({super.key});

  bool isimageAvailable = false;

  List<Uint8List>? imageFileList = [];
  List<String>categorylist =[];
  List<String> brandlist =[];

  //String? selectedbrand;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var priceController = TextEditingController();
  var carRegisterController = TextEditingController();
  CarData cardata = CarData();

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
                const Text(
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
                                onTap: () async {
                                  print("brand is ${cardata.brand}");

                                  //  print("seperate is ${ cardata.brandList}");
                                  //  print("diffrernt is ${ cardata.brandValue}");

                                  // print("calling");
                                  // firebase_storage.Reference ref =
                                  //     firebase_storage.FirebaseStorage.instance
                                  //         .ref('/caruploadimage');
                                  //         print("called");

                                  // List<String> imgurlList = [];

                                  // for (Uint8List image in imageFileList!) {
                                  //   print("forlooop");
                                  //   firebase_storage.UploadTask uploadTask =
                                  //       ref.putData(image);

                                  //   await uploadTask;
                                  //   String newUrl = await ref.getDownloadURL();
                                  //   print("url is ${newUrl}");
                                  //   imgurlList.add(newUrl);
                                  // }
                                  // print(imgurlList);

                                  // Map<String, dynamic> datas = {
                                  //   "brand": cardata.brand,
                                  //   "model": cardata.model,
                                  //   "type": cardata.type,
                                  //   "fuel": cardata.fuel,
                                  //   "transmit": cardata.transmit,
                                  //   "seats": cardata.seats,
                                  //   "availability": cardata.available,
                                  //   "baggage": cardata.laggage,
                                  //   "price": priceController.text,
                                  //   "carImage": imgurlList,
                                  //   "carNumber":carRegisterController.text
                                  // };

                                  // await firestore
                                  //     .collection('cars')
                                  //     .doc(carRegisterController.text)
                                  //     .set(datas)
                                  //     .then((value) => Navigator.pop(context));
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
                                ///  decoration: BoxDecoration(border: Border.all()),
                                height: 50,
                                width: 100,
                                child: Center(child: Text("Cancel")),
                              ),
                            ],
                            title: const Text("Add Car Model Details"),
                            content: Card(
                              child: Container(
                                height: 500,
                                width: MediaQuery.of(context).size.width - 420,
                                decoration: const BoxDecoration(
                                    //   color: Color.fromARGB(255, 224, 224, 224),
                                    ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BlocBuilder<CarscreenBloc, CarscreenState>(
                                      builder: (context, state) {
                                        if (state is UploadImageState) {
                                          if (state.imageFile.isNotEmpty) {
                                            imageFileList!
                                                .addAll(state.imageFile);
                                          }

                                          //   imageFileList!.addAll(state.imageFile);
                                          print(imageFileList!.length);
                                          return Column(
                                            children: [
                                              Container(
                                                height: 450,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width -
                                                        1020,
                                                child: GridView.builder(
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio: 1.2,
                                                    crossAxisCount: 2,
                                                    //  // crossAxisSpacing: 18.0,
                                                    //   mainAxisSpacing: 18.0
                                                  ),
                                                  itemCount: 4,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      height: 10,
                                                      width: 20,
                                                      margin:
                                                          EdgeInsets.all(18),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  147,
                                                                  147,
                                                                  147))),
                                                      child: Image.memory(
                                                        state.imageFile[index],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<CarscreenBloc>()
                                                      .add(UploadImageEvent());
                                                },
                                                child: Container(
                                                  color: Colors.black,
                                                  height: 45,
                                                  width: 160,
                                                  child: const Center(
                                                      child: Text(
                                                    "Add Image",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                                ),
                                              ),
                                            ],
                                          );
                                        } else if (state is CarscreenInitial) {
                                          return Column(
                                            children: [
                                              Container(
                                                // decoration: BoxDecoration(
                                                //     border: Border.all()),
                                                height: 450,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width -
                                                        1020,
                                                child: GridView.builder(
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    childAspectRatio: 1.2,
                                                    crossAxisCount: 2,
                                                    //  // crossAxisSpacing: 18.0,
                                                    //   mainAxisSpacing: 18.0
                                                  ),
                                                  itemCount: 4,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      height: 10,
                                                      width: 20,
                                                      margin:
                                                          EdgeInsets.all(18),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  147,
                                                                  147,
                                                                  147))),
                                                      child: Icon(
                                                        Icons
                                                            .add_a_photo_outlined,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 203, 203, 203),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<CarscreenBloc>()
                                                      .add(UploadImageEvent());
                                                },
                                                child: Container(
                                                  color: Colors.black,
                                                  height: 45,
                                                  width: 160,
                                                  child: const Center(
                                                      child: Text(
                                                    "Add Image",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return Text("Error");
                                        }
                                      },
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 100),
                                      padding: EdgeInsets.only(left: 5),
                                      height: 450,
                                      width: MediaQuery.sizeOf(context).width -
                                          958,
                                      // decoration:
                                      //     BoxDecoration(border: Border.all()),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            //     mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                  // height: 50,
                                                  width: 280,
                                                  child: BlocBuilder<
                                                      CarscreenBloc,
                                                      CarscreenState>(
                                                    builder: (context, state) {
                                                        print(state.runtimeType);
                                                        if(state is CarscreenInitial){
                                                             return DropdownButtonFormField(
                                                        value: cardata.brand,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              const OutlineInputBorder(),
                                                          hintText: "Category",
                                                        ),
                                                        items: categorylist
                                                            .map(
                                                                (String value) {
                                                          return DropdownMenuItem(
                                                              value: value,
                                                              child:
                                                                  Text(value));
                                                        }).toList(),
                                                        onChanged:
                                                            (String? value) {
                                                          cardata.brand = value;
                                                          print(cardata);
                                                          //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                                                        },
                                                        onSaved: (newValue) {
                                                          //  print(newValue);
                                                          cardata.brand =
                                                              newValue;
                                                          // print( cardata.brand);
                                                        },
                                                      );

                                                        }else if(state is UploadDataState){
                                                          categorylist = state.categoryList;
                                                        //  brandlist = state.brandnameList;
                                                          print("category list is $categorylist");
                                                          print("bramd list is $brandlist");
                                                             return DropdownButtonFormField(
                                                        value: cardata.brand,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              const OutlineInputBorder(),
                                                          hintText: "Category",
                                                        ),
                                                        items: categorylist
                                                            .map(
                                                                (String value) {
                                                          return DropdownMenuItem(
                                                              value: value,
                                                              child:
                                                                  Text(value));
                                                        }).toList(),
                                                        onChanged:
                                                            (String? value) {
                                                          cardata.brand = value;
                                                          print(cardata);
                                                          //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                                                        },
                                                        onSaved: (newValue) {
                                                          //  print(newValue);
                                                          cardata.brand =
                                                              newValue;
                                                          // print( cardata.brand);
                                                        },
                                                      );


                                                        }else{
                                                          return Container();
                                                        }

                                                   
                                                    },
                                                  )),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                //     height: 50,
                                                width: 280,

                                                child: AddCarDropMenu(
                                                  selectedvalue: cardata.model,
                                                  brandList: cardata.modelList,
                                                  hintTexted: "Brand",
                                                  brandValue:
                                                      cardata.modelValue,
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                // height: 50,
                                                width: 280,

                                                child: TextField(
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          hintText: "Model"),
                                                  controller: priceController,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                //     height: 50,
                                                width: 280,

                                                child: AddCarDropMenu(
                                                  selectedvalue:
                                                      cardata.transmit,
                                                  brandList:
                                                      cardata.transmitList,
                                                  hintTexted: "Transmission",
                                                  brandValue:
                                                      cardata.transmitValue,
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                // height: 50,
                                                width: 280,

                                                child: AddCarDropMenu(
                                                  selectedvalue: cardata.fuel,
                                                  brandList: cardata.fuelList,
                                                  hintTexted: "Fuel",
                                                  brandValue: cardata.fuelvalue,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                // height: 50,
                                                width: 280,

                                                child: AddCarDropMenu(
                                                  selectedvalue: cardata.fuel,
                                                  brandList: cardata.fuelList,
                                                  hintTexted: "Baggage",
                                                  brandValue: cardata.fuelvalue,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                // height: 50,
                                                width: 280,

                                                child: TextField(
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          hintText: "Price"),
                                                  controller: priceController,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                // height: 50,
                                                width: 280,

                                                child: AddCarDropMenu(
                                                  selectedvalue: cardata.fuel,
                                                  brandList: cardata.fuelList,
                                                  hintTexted: "Seats",
                                                  brandValue: cardata.fuelvalue,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
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
}
