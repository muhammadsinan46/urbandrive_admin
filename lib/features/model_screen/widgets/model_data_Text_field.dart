
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_admin/domain/car_data.dart';
import 'package:ud_admin/features/model_screen/bloc/model_image_bloc/carscreen_bloc.dart';
import 'package:ud_admin/features/model_screen/bloc/update_details_bloc/update_details_bloc.dart';
import 'package:ud_admin/features/model_screen/pages/car_model_screen.dart';
import 'package:ud_admin/features/model_screen/widgets/dropdown_loading_field.dart';

class ModelDataTextField extends StatelessWidget {
  const ModelDataTextField({
    super.key,
    required this.imageFileList,
    required this.cardata,
    required this.categorylist,
    required this.brandlist,
    required this.modelController,
    required this.priceController,
    required this.depositController,
    required this.freekmsController,
    required this.extraController,
  });

  final List<Uint8List>? imageFileList;
  final CarData cardata;
  final List<String> categorylist;
  final List<String> brandlist;
  final TextEditingController modelController;
  final TextEditingController priceController;
  final TextEditingController depositController;
  final TextEditingController freekmsController;
  final TextEditingController extraController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  imageFileList!.addAll(state.imageFile);
                }

                //   imageFileList!.addAll(state.imageFile);

                return Column(
                  children: [
                    Container(
                      height: 450,
                      width: MediaQuery.sizeOf(context).width - 1020,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.2,
                          crossAxisCount: 2,
                          //  // crossAxisSpacing: 18.0,
                          //   mainAxisSpacing: 18.0
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 10,
                            width: 20,
                            margin: EdgeInsets.all(18),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 147, 147, 147))),
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
                        context.read<CarscreenBloc>().add(UploadImageEvent());
                      },
                      child: Container(
                        color: Colors.black,
                        height: 45,
                        width: 160,
                        child: const Center(
                            child: Text(
                          "Add Image",
                          style: TextStyle(color: Colors.white),
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
                      width: MediaQuery.sizeOf(context).width - 1020,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.2,
                          crossAxisCount: 2,
                          //  // crossAxisSpacing: 18.0,
                          //   mainAxisSpacing: 18.0
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 10,
                            width: 20,
                            margin: EdgeInsets.all(18),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 147, 147, 147))),
                            child: Icon(
                              Icons.add_a_photo_outlined,
                              color: const Color.fromARGB(255, 203, 203, 203),
                            ),
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<CarscreenBloc>().add(UploadImageEvent());
                      },
                      child: Container(
                        color: Colors.black,
                        height: 45,
                        width: 160,
                        child: const Center(
                            child: Text(
                          "Add Image",
                          style: TextStyle(color: Colors.white),
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
            // height: 450,
            width: MediaQuery.sizeOf(context).width - 958,
            // decoration:
            //     BoxDecoration(border: Border.all()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocBuilder<UpdateDetailsBloc, UpdateDetailsState>(
                  builder: (context, state) {
                    if (state is UpdatedDetailsState) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              // height: 50,
                              width: 280,
                              child: DropdownButtonFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null) {
                                    return "Please select an Item";
                                  }
                                  return null;
                                },
                                value: cardata.categoryValue,
                                decoration: InputDecoration(
                                  labelText: "Category",
                                  border: const OutlineInputBorder(),
                                  // hintText: ,
                                ),
                                items: state.categoryList.map((String value) {
                                  return DropdownMenuItem(
                                      value: value, child: Text(value));
                                }).toList(),
                                onChanged: (String? value) {
                                  cardata.categoryValue = value;

                                  //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                                },
                                onSaved: (newValue) {
                                  //     (newValue);
                                  cardata.categoryValue = newValue;
                                  //    ( cardata.brand);
                                },
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            //     height: 50,
                            width: 280,

                            child: DropdownButtonFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null) {
                                  return "Please select an Item";
                                }
                                return null;
                              },
                              value: cardata.brandValue,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: "Brands",
                              ),
                              items: state.brandnameList.map((String value) {
                                return DropdownMenuItem(
                                    value: value, child: Text(value));
                              }).toList(),
                              onChanged: (String? value) {
                                cardata.brandValue = value;

                                //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                              },
                              onSaved: (newValue) {
                                //     (newValue);
                                cardata.brandValue = newValue;
                                //    ( cardata.brand);
                              },
                            ),
                          )
                        ],
                      );
                    } else {
                      return DropdownLoadingField(
                          categorylist: categorylist,
                          cardata: cardata,
                          brandlist: brandlist);
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      // height: 50,
                      width: 280,

                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter model name";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), hintText: "Model"),
                        controller: modelController,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        //     height: 50,
                        width: 280,
                        child: DropdownButtonFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null) {
                              return "Please select an transmission";
                            }
                            return null;
                          },
                          value: cardata.transmitValue,
                          decoration: InputDecoration(
                            labelText: "Transmission",
                            border: const OutlineInputBorder(),
                            // hintText: ,
                          ),
                          items: cardata.transmitList.map((String value) {
                            return DropdownMenuItem(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (String? value) {
                            cardata.transmitValue = value;
                            //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                          },
                          onSaved: (newValue) {
                            //     (newValue);
                            cardata.transmitValue = newValue;
                            //    ( cardata.brand);
                          },
                        ))
                  ],
                ),
                //////////////////////////////////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        // height: 50,
                        width: 280,
                        child: DropdownButtonFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null) {
                              return "Please select fuel type";
                            }
                            return null;
                          },
                          value: cardata.fuelValue,
                          decoration: InputDecoration(
                            labelText: "Fuel",
                            border: const OutlineInputBorder(),
                            // hintText: ,
                          ),
                          items: cardata.fuelList.map((String value) {
                            return DropdownMenuItem(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (String? value) {
                            cardata.fuelValue = value;

                            //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                          },
                          onSaved: (newValue) {
                            //     (newValue);
                            cardata.fuelValue = newValue;
                            //    ( cardata.brand);
                          },
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        // height: 50,
                        width: 280,
                        child: DropdownButtonFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null) {
                              return "Please select an baggage size";
                            }
                            return null;
                          },
                          value: cardata.baggageValue,
                          decoration: InputDecoration(
                            labelText: "Baggage",
                            border: const OutlineInputBorder(),
                            // hintText: ,
                          ),
                          items: cardata.baggageList.map((String value) {
                            return DropdownMenuItem(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (String? value) {
                            cardata.baggageValue = value;

                            //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                          },
                          onSaved: (newValue) {
                            //     (newValue);
                            cardata.baggageValue = newValue;
                            //    ( cardata.brand);
                          },
                        )),
                  ],
                ),

                ////////////////////////////////////////////////////           //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                    
                      width: 280,

                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter price amount(₹)";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Price(₹)"),
                        controller: priceController,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        // height: 50,
                        width: 280,
                        child: DropdownButtonFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null) {
                              return "Please select seat count";
                            }
                            return null;
                          },
                          //  value: cardata.model,
                          decoration: InputDecoration(
                            labelText: "Seats",
                            border: const OutlineInputBorder(),
                            // hintText: ,
                          ),
                          items: cardata.seatsList.map((String value) {
                            return DropdownMenuItem(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (String? value) {
                            cardata.seatsValue = value;

                            //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                          },
                          onSaved: (newValue) {
                            //     (newValue);
                            cardata.seatsValue = newValue;
                            //    ( cardata.brand);
                          },
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      // height: 50,
                      width: 280,

                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter deposit amount(₹)";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Deposit(₹)"),
                        controller: depositController,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      // height: 50,
                      width: 280,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 140,
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "* Required field";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Free Kms"),
                              controller: freekmsController,
                            ),
                          ),
                          Container(
                            width: 130,
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "* Required field";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Extra Kms"),
                              controller: extraController,
                            ),
                          )
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
    );
  }
}