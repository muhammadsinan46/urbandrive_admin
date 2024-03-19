// ignore_for_file: must_be_immutable

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
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

  String? carmodelId;

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
  // var _multicontroller = MultiSelectController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    context.read<CarModelListBloc>().add(CarModelListLoadedEvent());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              // border: Border.all(),
              ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Models",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        // carmodel.uploadBrandList();
                        //  cater.getCategoryData();
                        context
                            .read<UpdateDetailsBloc>()
                            .add(UpdatedDetailsEvent());
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Form(
                                key: _formKey,
                                child: AlertDialog(
                                  backgroundColor: Colors.white,
                                  actions: [
                                    // BlocBuilder<CategoryBloc, CategoryState>(
                                    //   builder: (context, state) {
                                    //     return
                                    submitModelForm(context),
                                    //   },
                                    // ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration:
                                            BoxDecoration(border: Border.all()),
                                        height: 50,
                                        width: 100,
                                        child: Center(child: Text("Cancel")),
                                      ),
                                    )
                                  ],
                                  title: const Text("Add Model Details"),
                                  content: Card(
                                    child: ModelDataTextField(
                                        imageFileList: imageFileList,
                                        cardata: cardata,
                                        categorylist: categorylist,
                                        brandlist: brandlist,
                                        modelController: modelController,
                                        priceController: priceController,
                                        depositController: depositController,
                                        freekmsController: freekmsController,
                                        extraController: extraController),
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
                          "Add ",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),
                //row

                Container(
                  decoration: BoxDecoration(
                      // border: Border.all(),
                      ),
                  height: MediaQuery.sizeOf(context).height - 100,
                  width: MediaQuery.sizeOf(context).width - 200,
                  child: BlocBuilder<CarModelListBloc, CarModelListState>(
                    builder: (context, state) {
                      print(state.runtimeType);
                      if (state is CarModelListInitial) {
                        //    return ListView.builder(itemBuilder: (context, index) {
                        return DataTable2(
                            headingRowDecoration:
                                BoxDecoration(border: Border.all()),
                            //  decoration: BoxDecoration(border: Border.all()),
                            horizontalMargin: 20,
                            columnSpacing: 20,
                            dataTextStyle: TextStyle(
                              fontSize: 10,
                            ),
                            columns: const [
                              DataColumn2(
                                  label: Text(
                                    "No.",
                                  ),
                                  size: ColumnSize.S),
                              // DataColumn2(label: Text("Id")),
                              DataColumn2(
                                label: Text("Category"),
                              ),
                              DataColumn2(label: Text("Brand")),
                              DataColumn2(label: Text("model")),
                              DataColumn2(label: Text("transmit")),
                              DataColumn2(label: Text("fuel")),
                              DataColumn2(label: Text("baggage")),
                              DataColumn2(label: Text("price")),
                              DataColumn2(label: Text("seats")),
                              DataColumn2(label: Text("deposit")),
                              DataColumn2(label: Text("freekms")),
                              DataColumn2(label: Text("extrakms")),
                              // DataColumn2(label: Text("car color")),
                              DataColumn2(label: Text("Edit")),
                              DataColumn2(label: Text("Delete")),
                            ],
                            rows: []);

                        //     },);
                      } else if (state is CarModelListUpdated) {
                        carmodelList = state.cardataList;
                        return carmodelList.length != 0
                            ? DataTable2(
                                headingRowDecoration:
                                    BoxDecoration(border: Border.all()),
                                horizontalMargin: 20,
                                columnSpacing: 20,
                                dataTextStyle: TextStyle(
                                  fontSize: 10,
                                ),
                                columns: const [
                                  DataColumn2(
                                      label: Text(
                                        "No.",
                                      ),
                                      size: ColumnSize.S),
                                  // DataColumn2(label: Text("Id")),
                                  DataColumn2(
                                    label: Text("Category"),
                                  ),
                                  DataColumn2(label: Text("Brand")),
                                  DataColumn2(label: Text("model")),
                                  DataColumn2(label: Text("transmit")),
                                  DataColumn2(label: Text("fuel")),
                                  DataColumn2(label: Text("baggage")),
                                  DataColumn2(label: Text("price")),
                                  DataColumn2(label: Text("seats")),
                                  DataColumn2(label: Text("deposit")),
                                  DataColumn2(label: Text("freekms")),
                                  DataColumn2(label: Text("extrakms")),
                                  // DataColumn2(label: Text("car color")),
                                  DataColumn2(label: Text("Edit")),
                                  DataColumn2(label: Text("Delete")),
                                ],
                                rows:
                                    List.generate(carmodelList.length, (index) {
                                  return DataRow(cells: [
                                    DataCell(
                                      Text("${index + 1}"),
                                    ),
                                    // DataCell(Text(carmodelList[index].id)),
                                    DataCell(
                                      Text(
                                        carmodelList[index].category!,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    DataCell(Text(
                                      carmodelList[index].brand!,
                                    )),
                                    DataCell(Text(carmodelList[index].model!)),
                                    DataCell(
                                        Text(carmodelList[index].transmit!)),
                                    DataCell(Text(carmodelList[index].fuel!)),
                                    DataCell(Text(
                                      carmodelList[index].baggage!,
                                      textAlign: TextAlign.center,
                                    )),
                                    DataCell(Text(carmodelList[index].price!)),
                                    DataCell(Text(carmodelList[index].seats!)),
                                    DataCell(
                                        Text(carmodelList[index].deposit!)),
                                    DataCell(
                                        Text(carmodelList[index].freekms!)),
                                    DataCell(
                                        Text(carmodelList[index].extrakms!)),
                                    //  DataCell(

                                    //   Container(

                                    //     height: 30,
                                    //     width: 30,
                                    //     color: getColor(carmodelList[index].carColor!),

                                    //   )),

                                    DataCell(Icon(Icons.edit)),
                                    DataCell(Icon(Icons.delete)),
                                  ]);
                                }))
                            : Container(
                                child: Center(
                                  child: Text("No models to display"),
                                ),
                              );
                      } else {
                        return Container();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector submitModelForm(BuildContext context) {
    return GestureDetector(
                                    onTap: ()async{
                                          if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    firebase_storage.Reference ref = await firebase_storage
        .FirebaseStorage.instance
        .ref('carmodelimage${DateTime.now().millisecond}');

    List<String> imgurlList = [];

    for (Uint8List image in imageFileList!) {
      firebase_storage.UploadTask uploadTask = ref.putData(image);

      await uploadTask;
      String newUrl = await ref.getDownloadURL();

      imgurlList.add(newUrl);
    }

    carmodelId = await firestore.collection('models').doc().id;

    Map<String, dynamic> datas = {
      "id": "${carmodelId}",
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
      "color": cardata.colorValue
    };

    await firestore
        .collection('models')
        .doc(carmodelId)
        .set(datas)
        .then((value) {
      context.read<CarModelListBloc>().add(CarModelListLoadedEvent());
      modelController.clear();
      priceController.clear();
      depositController.clear();
      freekmsController.clear();
      extraController.clear();
      context.read<CarscreenBloc>().add(ModelImageUpdatedEvent());

      Navigator.pop(context);
    });
  }
                                    },
                                    child: Container(
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      height: 50,
                                      width: 100,
                                      child: Center(child: Text("Submit")),
                                    ),
                                  );
  }

  submitModelData(context) async {

  }

  Color getColor(String strColor) {
    String cleanValue = strColor
        .replaceAll("MaterialColor(primary value: Color(", "")
        .replaceAll("))", "");

    int colorvalue = int.parse(
      cleanValue,
    );
    Color color = Color(colorvalue);

    return color;
  }

  List<ValueItem<Object?>> getCityValueList() {
    List<ValueItem<Object?>> cityvalueList = cardata.cityList
        .map((city) => ValueItem(label: city, value: city))
        .toList();

    return cityvalueList;
  }
}

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
                              color: const Color.fromARGB(255, 147, 147, 147))),
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
                              color: const Color.fromARGB(255, 147, 147, 147))),
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
                                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                 autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      // height: 50,
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
                                 autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                 autovalidateMode: AutovalidateMode.onUserInteraction,
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



class DropdownLoadingField extends StatelessWidget {
  const DropdownLoadingField({
    super.key,
    required this.categorylist,
    required this.cardata,
    required this.brandlist,
  });

  final List<String> categorylist;
  final CarData cardata;
  final List<String> brandlist;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            // height: 50,
            width: 280,
            child: DropdownButtonFormField(
              validator: (value) {
                if (value == null) {
                  return "Please select an Item";
                }
                return null;
              },
              //   value: cardata.model,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Category",
              ),
              items: categorylist.map((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
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
            validator: (value) {
              if (value == null) {
                return "Please select an Item";
              }
              return null;
            },
            // value: cardata.brand,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "Brands",
            ),
            items: brandlist.map((String value) {
              return DropdownMenuItem(value: value, child: Text(value));
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
  }
}
