// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_admin/application/carModelScreen/car_model_list_bloc/car_model_list_bloc.dart';
import 'package:ud_admin/application/carModelScreen/update_details_bloc/update_details_bloc.dart';
import 'package:ud_admin/application/carModelScreen/model_image_bloc/carscreen_bloc.dart';

import 'package:ud_admin/domain/car_data.dart';
import 'package:ud_admin/domain/cardata_model.dart';
import 'package:ud_admin/domain/cardata_model_repo.dart';


class ModelScreen extends StatelessWidget {
  ModelScreen({super.key});

  bool isimageAvailable = false;

  CarDataModelRepo sample = CarDataModelRepo();

  List<Uint8List>? imageFileList = [];
  List<String> categorylist = [];
  List<String> brandlist = [];
  List<CarDataModel> carmodelList = [];

  //String? selectedbrand;
  CarData cardata = CarData();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var modelController = TextEditingController();
  var priceController = TextEditingController();
  var depositController = TextEditingController();
  var freekmsController = TextEditingController();
  var extraController = TextEditingController();

  @override
  Widget build(BuildContext context) {
      context.read<CarModelListBloc>().add(CarModelListLoadedEvent());
    return Scaffold(
      body: Form(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Cars",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                            sample.getCarDataModels();
                    
                        context
                            .read<UpdateDetailsBloc>()
                            .add(UpdatedDetailsEvent());
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actions: [
                                  GestureDetector(
                                    onTap: () async {
                                      firebase_storage.Reference ref =
                                          firebase_storage
                                              .FirebaseStorage.instance
                                              .ref('/caruploadimage');
                             

                                      List<String> imgurlList = [];

                                      for (Uint8List image in imageFileList!) {
                              
                                        firebase_storage.UploadTask uploadTask =
                                            ref.putData(image);

                                        await uploadTask;
                                        String newUrl =
                                            await ref.getDownloadURL();
                                   
                                        imgurlList.add(newUrl);
                                      }
                               

                                      Map<String, dynamic> datas = {
                                        "id": "${modelController.text}"
                                            "${cardata.transmitValue}",
                                        "category": cardata.categoryValue,
                                        "brand": cardata.brandValue,
                                        "model": modelController.text,
                                        "transmit": cardata.transmitValue,
                                        "fuel": cardata.fuelValue,
                                        "seats": cardata.seatsValue,
                                        "baggage": cardata.baggageValue,
                                        "price": priceController.text,
                                        "deposit": depositController.text,
                                        "freekms": freekmsController.text,
                                        "extrakms": extraController.text,
                                        "carImages": imgurlList,
                                      };

                                      await firestore
                                          .collection('models')
                                          .doc(
                                              '${modelController.text}"+"${cardata.transmitValue}')
                                          .set(datas)
                                          .then((value) {
                                        modelController.clear();
                                        priceController.clear();
                                        depositController.clear();
                                        freekmsController.clear();
                                        extraController.clear();
                                        context
                                            .read<CarscreenBloc>()
                                            .add(ModelImageUpdatedEvent());
                                        Navigator.pop(context);
                                        context.read<CarModelListBloc>().add(CarModelListLoadedEvent());
                                      });
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
                                    width:
                                        MediaQuery.of(context).size.width - 420,
                                    decoration: const BoxDecoration(
                                        //   color: Color.fromARGB(255, 224, 224, 224),
                                        ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BlocBuilder<CarscreenBloc,
                                            CarscreenState>(
                                          builder: (context, state) {
                                            if (state is UploadImageState) {
                                              if (state.imageFile.isNotEmpty) {
                                                imageFileList!
                                                    .addAll(state.imageFile);
                                              }

                                              //   imageFileList!.addAll(state.imageFile);
                                
                                              return Column(
                                                children: [
                                                  Container(
                                                    height: 450,
                                                    width: MediaQuery.sizeOf(
                                                                context)
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
                                                              EdgeInsets.all(
                                                                  18),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      147,
                                                                      147,
                                                                      147))),
                                                          child: Image.memory(
                                                            state.imageFile[
                                                                index],
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
                                                          .add(
                                                              UploadImageEvent());
                                                    },
                                                    child: Container(
                                                      color: Colors.black,
                                                      height: 45,
                                                      width: 160,
                                                      child: const Center(
                                                          child: Text(
                                                        "Add Image",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else if (state
                                                is CarscreenInitial) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    // decoration: BoxDecoration(
                                                    //     border: Border.all()),
                                                    height: 450,
                                                    width: MediaQuery.sizeOf(
                                                                context)
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
                                                              EdgeInsets.all(
                                                                  18),
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
                                                                .fromARGB(255,
                                                                203, 203, 203),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      context
                                                          .read<CarscreenBloc>()
                                                          .add(
                                                              UploadImageEvent());
                                                    },
                                                    child: Container(
                                                      color: Colors.black,
                                                      height: 45,
                                                      width: 160,
                                                      child: const Center(
                                                          child: Text(
                                                        "Add Image",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                                          width:
                                              MediaQuery.sizeOf(context).width -
                                                  958,
                                          // decoration:
                                          //     BoxDecoration(border: Border.all()),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BlocBuilder<UpdateDetailsBloc,
                                                  UpdateDetailsState>(
                                                builder: (context, state) {
                                                  if (state
                                                      is UpdateDetailsInitiaState) {
                                                    return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      //     mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                            // height: 50,
                                                            width: 280,
                                                            child:
                                                                DropdownButtonFormField(
                                                              //   value: cardata.model,
                                                              decoration:
                                                                  InputDecoration(
                                                                border:
                                                                    const OutlineInputBorder(),
                                                                hintText:
                                                                    "Category",
                                                              ),
                                                              items: categorylist
                                                                  .map((String
                                                                      value) {
                                                                return DropdownMenuItem(
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                        value));
                                                              }).toList(),
                                                              onChanged:
                                                                  (String?
                                                                      value) {
                                                                cardata.categoryValue =
                                                                    value;

                                                                //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                                                              },
                                                              onSaved:
                                                                  (newValue) {
                                                                //     (newValue);
                                                                cardata.categoryValue =
                                                                    newValue;
                                                                //    ( cardata.brand);
                                                              },
                                                            )),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          //     height: 50,
                                                          width: 280,

                                                          child:
                                                              DropdownButtonFormField(
                                                            // value: cardata.brand,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  const OutlineInputBorder(),
                                                              hintText:
                                                                  "Brands",
                                                            ),
                                                            items: brandlist
                                                                .map((String
                                                                    value) {
                                                              return DropdownMenuItem(
                                                                  value: value,
                                                                  child: Text(
                                                                      value));
                                                            }).toList(),
                                                            onChanged: (String?
                                                                value) {
                                                              cardata.brandValue =
                                                                  value;
                                                          
                                                              //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                                                            },
                                                            onSaved:
                                                                (newValue) {
                                                              //     (newValue);
                                                              cardata.brandValue =
                                                                  newValue;
                                                              //    ( cardata.brand);
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  } else if (state
                                                      is UpdatedDetailsState) {
                                                    return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      //     mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                            // height: 50,
                                                            width: 280,
                                                            child:
                                                                DropdownButtonFormField(
                                                              //  value: cardata.model,
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    "Category",
                                                                border:
                                                                    const OutlineInputBorder(),
                                                                // hintText: ,
                                                              ),
                                                              items: state
                                                                  .categoryList
                                                                  .map((String
                                                                      value) {
                                                                return DropdownMenuItem(
                                                                    value:
                                                                        value,
                                                                    child: Text(
                                                                        value));
                                                              }).toList(),
                                                              onChanged:
                                                                  (String?
                                                                      value) {
                                                                cardata.categoryValue =
                                                                    value;
                                                      
                                                                //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                                                              },
                                                              onSaved:
                                                                  (newValue) {
                                                                //     (newValue);
                                                                cardata.categoryValue =
                                                                    newValue;
                                                                //    ( cardata.brand);
                                                              },
                                                            )),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          //     height: 50,
                                                          width: 280,

                                                          child:
                                                              DropdownButtonFormField(
                                                            //   value: cardata.brand,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  const OutlineInputBorder(),
                                                              hintText:
                                                                  "Brands",
                                                            ),
                                                            items: state
                                                                .brandnameList
                                                                .map((String
                                                                    value) {
                                                              return DropdownMenuItem(
                                                                  value: value,
                                                                  child: Text(
                                                                      value));
                                                            }).toList(),
                                                            onChanged: (String?
                                                                value) {
                                                              cardata.brandValue =
                                                                  value;
                                                      
                                                              //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                                                            },
                                                            onSaved:
                                                                (newValue) {
                                                              //     (newValue);
                                                              cardata.brandValue =
                                                                  newValue;
                                                              //    ( cardata.brand);
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  } else {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all()),
                                                    );
                                                  }
                                                },
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
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
                                                              hintText:
                                                                  "Model"),
                                                      controller:
                                                          modelController,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                      //     height: 50,
                                                      width: 280,
                                                      child:
                                                          DropdownButtonFormField(
                                                        //  value: cardata.model,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              "Transmission",
                                                          border:
                                                              const OutlineInputBorder(),
                                                          // hintText: ,
                                                        ),
                                                        items: cardata
                                                            .transmitList
                                                            .map(
                                                                (String value) {
                                                          return DropdownMenuItem(
                                                              value: value,
                                                              child:
                                                                  Text(value));
                                                        }).toList(),
                                                        onChanged:
                                                            (String? value) {
                                                          cardata.transmitValue =
                                                              value;
                                                  //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                                                        },
                                                        onSaved: (newValue) {
                                                          //     (newValue);
                                                          cardata.transmitValue =
                                                              newValue;
                                                          //    ( cardata.brand);
                                                        },
                                                      ))
                                                ],
                                              ),
                                              //////////////////////////////////////////
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                      // height: 50,
                                                      width: 280,
                                                      child:
                                                          DropdownButtonFormField(
                                                        //  value: cardata.model,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: "Fuel",
                                                          border:
                                                              const OutlineInputBorder(),
                                                          // hintText: ,
                                                        ),
                                                        items: cardata.fuelList
                                                            .map(
                                                                (String value) {
                                                          return DropdownMenuItem(
                                                              value: value,
                                                              child:
                                                                  Text(value));
                                                        }).toList(),
                                                        onChanged:
                                                            (String? value) {
                                                          cardata.fuelValue =
                                                              value;
                                                    
                                                          //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                                                        },
                                                        onSaved: (newValue) {
                                                          //     (newValue);
                                                          cardata.fuelValue =
                                                              newValue;
                                                          //    ( cardata.brand);
                                                        },
                                                      )),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                      // height: 50,
                                                      width: 280,
                                                      child:
                                                          DropdownButtonFormField(
                                                        //  value: cardata.model,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: "Baggage",
                                                          border:
                                                              const OutlineInputBorder(),
                                                          // hintText: ,
                                                        ),
                                                        items: cardata
                                                            .baggageList
                                                            .map(
                                                                (String value) {
                                                          return DropdownMenuItem(
                                                              value: value,
                                                              child:
                                                                  Text(value));
                                                        }).toList(),
                                                        onChanged:
                                                            (String? value) {
                                                          cardata.baggageValue =
                                                              value;
                                                        
                                                          //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                                                        },
                                                        onSaved: (newValue) {
                                                          //     (newValue);
                                                          cardata.baggageValue =
                                                              newValue;
                                                          //    ( cardata.brand);
                                                        },
                                                      )),
                                                ],
                                              ),

                                              ////////////////////////////////////////////////////           //
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
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
                                                              labelText:
                                                                  "Price(₹)"),
                                                      controller:
                                                          priceController,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                      // height: 50,
                                                      width: 280,
                                                      child:
                                                          DropdownButtonFormField(
                                                        //  value: cardata.model,
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: "Seats",
                                                          border:
                                                              const OutlineInputBorder(),
                                                          // hintText: ,
                                                        ),
                                                        items: cardata.seatsList
                                                            .map(
                                                                (String value) {
                                                          return DropdownMenuItem(
                                                              value: value,
                                                              child:
                                                                  Text(value));
                                                        }).toList(),
                                                        onChanged:
                                                            (String? value) {
                                                          cardata.seatsValue =
                                                              value;
                                                             
                                                          //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                                                        },
                                                        onSaved: (newValue) {
                                                          //     (newValue);
                                                          cardata.seatsValue =
                                                              newValue;
                                                          //    ( cardata.brand);
                                                        },
                                                      )),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
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
                                                              labelText:
                                                                  "Deposit(₹)"),
                                                      controller:
                                                          depositController,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    // height: 50,
                                                    width: 280,

                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: 130,
                                                          child: TextField(
                                                            decoration: const InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                                labelText:
                                                                    "Free Kms"),
                                                            controller:
                                                                freekmsController,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 130,
                                                          child: TextField(
                                                            decoration:
                                                                const InputDecoration(
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                    //   labelStyle: TextStyle(fontSize:15),
                                                                    labelText:
                                                                        "Extra Kms(₹)"),
                                                            controller:
                                                                extraController,
                                                          ),
                                                        ),
                                                      ],
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
               const  SizedBox(
                  height: 20,
                ),
                BlocBuilder<CarModelListBloc, CarModelListState>(
                  builder: (context, state) {
                    if (state is CarModelListInitial) {
                      return Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          height: MediaQuery.sizeOf(context).height - 500,
                          width: MediaQuery.sizeOf(context).width - 50,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text("No.")),
                              DataColumn(label: Text("Id")),
                              DataColumn(label: Text("Category")),
                              DataColumn(label: Text("Brand")),
                              DataColumn(label: Text("model")),
                              DataColumn(label: Text("transmit")),
                              DataColumn(label: Text("fuel")),
                              DataColumn(label: Text("baggage")),
                              DataColumn(label: Text("price")),
                              DataColumn(label: Text("seats")),
                              DataColumn(label: Text("deposit")),
                              DataColumn(label: Text("freekms")),
                              DataColumn(label: Text("extrakms")),
                              DataColumn(label: Text("Edit")),
                              DataColumn(label: Text("Delete")),
                            ],
                            rows: [],
              
                          ));
                    } else if (state is CarModelListUpdated) {
                      carmodelList = state.cardataList;
                      return Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          height: MediaQuery.sizeOf(context).height - 500,
                          width: MediaQuery.sizeOf(context).width - 50,
                          child: DataTable(
                              columns: const [
                                DataColumn(label: Text("No.")),
                                DataColumn(label: Text("Id")),
                                DataColumn(label: Text("Category")),
                                DataColumn(label: Text("Brand")),
                                DataColumn(label: Text("model")),
                                DataColumn(label: Text("transmit")),
                                DataColumn(label: Text("fuel")),
                                DataColumn(label: Text("baggage")),
                                DataColumn(label: Text("price")),
                                DataColumn(label: Text("seats")),
                                DataColumn(label: Text("deposit")),
                                DataColumn(label: Text("freekms")),
                                DataColumn(label: Text("extrakms")),
                                DataColumn(label: Text("Edit")),
                                DataColumn(label: Text("Delete")),
                              ],
                              rows: List.generate(carmodelList.length,
                                  (index) {
                                return  DataRow(cells: [
                                  DataCell(Text("${index+1}")),
                                  DataCell(Text(carmodelList[index].id)),
                                  DataCell(Text(carmodelList[index].category!)),
                                  DataCell(Text(carmodelList[index].brand!)),
                                  DataCell(Text(carmodelList[index].model!)),
                                  DataCell(Text(carmodelList[index].transmit!)),
                                  DataCell(Text(carmodelList[index].fuel!)),
                                  DataCell(Text(carmodelList[index].baggage!)),
                                  DataCell(Text(carmodelList[index].price!)),
                                  DataCell(Text(carmodelList[index].seats!)),
                                  DataCell(Text(carmodelList[index].deposit!)),
                                  DataCell(Text(carmodelList[index].freekms!)),
                                  DataCell(Text(carmodelList[index].extrakms!)),
                                  DataCell(Icon(Icons.edit)),
                                  DataCell(Icon(Icons.delete)),
                                ]);
                              })));
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
