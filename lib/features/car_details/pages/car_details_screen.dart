import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_admin/domain/car_data.dart';
import 'package:ud_admin/domain/car_detail_model.dart';
import 'package:ud_admin/features/car_details/bloc/car_details_list/car_details_list_bloc.dart';
import 'package:ud_admin/features/car_details/bloc/car_model_bloc/car_details_bloc.dart';
import 'package:ud_admin/features/car_details/widgets/car_data_row.dart';

class CarDetailsScreen extends StatelessWidget {
  CarDetailsScreen({super.key});

  var cardata = CarData();

  Map<String, String> selectedValue = {};
  Map<String, Color> selectedColor = {};

  Set<Map<String, String>> carModelList = {};
 var carnumberController = TextEditingController();

 List<CarDetails> cardeailsList =[];

  @override
  Widget build(BuildContext context) {

    context.read<CarDetailsListBloc>().add(CarDetailsListLoadedEvent());
    return Scaffold(
      body: Form(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                      "Fleets",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<CarDetailsBloc>().add(CarDetailsLoadedEvent());
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Form(
                                child: AlertDialog(
                                  backgroundColor: Colors.white,
                                  actions: [
                                    GestureDetector(
                
                                      onTap: () {
                
                                        print(selectedColor.keys.first);
                
                                        Map<String , dynamic> datas ={
                
                                          "model":"${selectedValue.keys.first} ${selectedValue.values.first}",
                                          "color-name":selectedColor.keys.first,
                                          "color-value":selectedColor.values.first.toString(),
                                          "car-number":carnumberController.text
                                        };
                
                
                                                    print(datas);
                                        FirebaseFirestore.instance.collection('fleets').doc(carnumberController.text).set(datas).then((value){

                                          carnumberController.clear();
                                              context.read<CarDetailsListBloc>().add(CarDetailsListLoadedEvent());
                                        Navigator.pop(context);
                                        }
                                        );
                                        
                                      },
                                      child: Container(
                                        decoration:
                                            BoxDecoration(border: Border.all()),
                                        height: 50,
                                        width: 100,
                                        child: Center(child: Text("Submit")),
                                      ),
                                    ),
                                    Container(
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      height: 50,
                                      width: 100,
                                      child: Center(child: Text("Clear")),
                                    )
                                  ],
                                  title: const Text("Add "),
                                  content: Container(
                                    margin: EdgeInsets.all(15),
                                    height: 200,
                                    width: MediaQuery.of(context).size.width - 1200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BlocBuilder<CarDetailsBloc,
                                            CarDetailsState>(
                                          builder: (context, state) {
                                            if (state is CarDetailsLoadedState) {
                                              carModelList =
                                                  state.carmodelList.toSet();
                                              // carModelList = state.carmodelList;
                
                                              return Column(
                                                children: [
                                                  Container(
                                                    //height: 70,
                                                    width: 500,
                                                    child: DropdownButtonFormField(
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      validator: (value) {
                                                        if (value == null) {
                                                          return "Please select an Item";
                                                        }
                                                        return null;
                                                      },
                                                      //value: carBrandList[0],
                                                      decoration: InputDecoration(
                                                        labelText: "Brand",
                                                        border:
                                                            const OutlineInputBorder(),
                                                        // hintText: ,
                                                      ),
                                                      items: carModelList.map(
                                                          (Map<String, String>
                                                              value) {
                                                        final key =
                                                            value.keys.first;
                                                        final values =
                                                            value.values.first;
                
                                                        return DropdownMenuItem(
                                                            value: value,
                                                            child: Text(
                                                                "$key  $values"));
                                                      }).toList(),
                                                      onChanged:
                                                          (Map<String, String>?
                                                              value) {
                                                        selectedValue = value!;
                
                                                        //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                                                      },
                                                      onSaved: (newValue) {
                                                        //     (newValue);
                                                        selectedValue = newValue!;
                                                        //    ( cardata.brand);
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    width: 500,
                                                    child: DropdownButtonFormField(
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .onUserInteraction,
                                                      validator: (value) {
                                                        if (value == null) {
                                                          return "Please select Color";
                                                        }
                                                        return null;
                                                      },
                                                      //value: carBrandList[0],
                                                      decoration: InputDecoration(
                                                        labelText: "Color",
                                                        border:
                                                            const OutlineInputBorder(),
                                                        // hintText: ,
                                                      ),
                                                      items: cardata.colorlist.map(
                                                          (Map<String, Color>
                                                              value) {
                                                        final key =
                                                            value.keys.first;
                                                        final carColor =
                                                            value.values.first;
                
                                                        return DropdownMenuItem(
                                                            value: value,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text("$key"),
                                                                Container(
                                                                  height: 20,
                                                                  width: 20,
                                                                  color: carColor,
                                                                )
                                                              ],
                                                            ));
                                                      }).toList(),
                                                      onChanged:
                                                          (Map<String, Color>?
                                                              value) {
                                                        selectedColor = value!;
                
                                                        //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                                                      },
                                                      onSaved: (newValue) {
                                                        //     (newValue);
                                                        selectedColor = newValue!;
                                                        //    ( cardata.brand);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 500,
                                                  child: DropdownButtonFormField(
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return "Please select an Item";
                                                      }
                                                      return null;
                                                    },
                                                    //value: carBrandList[0],
                                                    decoration: InputDecoration(
                                                      labelText: "Brand",
                                                      border:
                                                          const OutlineInputBorder(),
                                                      // hintText: ,
                                                    ),
                                                    items: carModelList.map(
                                                        (Map<String, String>
                                                            value) {
                                                      return DropdownMenuItem(
                                                          value: value,
                                                          child: Text(
                                                              "${value.keys} ${value.values}"));
                                                    }).toList(),
                                                    onChanged: (Map<String, String>?
                                                        value) {
                                                      selectedValue = value!;
                
                                                      //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                                                    },
                                                    onSaved: (newValue) {
                                                      //     (newValue);
                                                      selectedValue = newValue!;
                                                      //    ( cardata.brand);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  height: 50,
                                                  width: 500,
                                                  child: DropdownButtonFormField(
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return "Please select Color";
                                                      }
                                                      return null;
                                                    },
                                                    //value: carBrandList[0],
                                                    decoration: InputDecoration(
                                                      labelText: "Color",
                                                      border:
                                                          const OutlineInputBorder(),
                                                      // hintText: ,
                                                    ),
                                                    items: cardata.colorlist.map(
                                                        (Map<String, Color> value) {
                                                      final key = value.keys.first;
                                                      final carColor =
                                                          value.values.first;
                
                                                      return DropdownMenuItem(
                                                          value: value,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text("$key"),
                                                              Container(
                                                                height: 20,
                                                                width: 20,
                                                                color: carColor,
                                                              )
                                                            ],
                                                          ));
                                                    }).toList(),
                                                    onChanged: (Map<String, Color>?
                                                        value) {
                                                      selectedColor = value!;
                
                                                      //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
                                                    },
                                                    onSaved: (newValue) {
                                                      //     (newValue);
                                                      selectedColor = newValue!;
                                                      //    ( cardata.brand);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        Container(
                                          height: 50,
                                          width: 500,
                                          child: TextField(
                                            controller: carnumberController,
                                            decoration: const InputDecoration(
                                              label: Text("Car Number",
                                                  style: TextStyle(
                                                      color: const Color.fromARGB(
                                                          255, 152, 152, 152))),
                                              border: OutlineInputBorder(),
                                            ),
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
                          "Add ",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                      ),
                    )
                  ],
                ),

                                Container(
                  decoration: BoxDecoration(
                      // border: Border.all(),
                      ),
                //  height: MediaQuery.sizeOf(context).height - 100,
                  width: MediaQuery.sizeOf(context).width - 200,
                  child: BlocBuilder<CarDetailsListBloc, CarDetailsListState>(
                    builder: (context, state) {
                      print(state.runtimeType);
                      if (state is CarDetailsListInitialState) {
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
                              
                                  DataColumn2(
                                    label: Text("Model"),
                                  ),
                                  DataColumn2(label: Text("Color")),
                                  DataColumn2(label: Text("Car Number")),
                            
                                  DataColumn2(label: Text("Edit")),
                                  DataColumn2(label: Text("Delete")),
                            ],
                            rows: []);

                        //     },);
                      } else if (state is CarDetailsListLoadedState) {
                        cardeailsList = state.cardetailsList;
                        return cardeailsList.length != 0?
                        PaginatedDataTable(
                 
                        rowsPerPage: 10,
                        availableRowsPerPage: [10,20,30],
                        onRowsPerPageChanged: (value) {
                        
                        },

                          columns: [       DataColumn2(
                                    
                                      label: Text(
                                        "No.",
                                      ),
                                      size: ColumnSize.S),
                              
                                  DataColumn2(
                                    label: Text("Model"),
                                  ),
                                  DataColumn2(label: Text("Color")),
                                  DataColumn2(label: Text("Car Number")),
                                  // DataColumn2(label: Text("transmit")),
                                  // DataColumn2(label: Text("fuel")),
                                  // DataColumn2(label: Text("baggage")),
                                  // DataColumn2(label: Text("price")),
                                  // DataColumn2(label: Text("seats")),
                                  // DataColumn2(label: Text("deposit")),
                                  // DataColumn2(label: Text("freekms")),
                                  // DataColumn2(label: Text("extrakms")),
                            
                                  DataColumn2(label: Text("Edit")),
                                  DataColumn2(label: Text("Delete")),
                        ], source: CarDetailsSource(carDetailList: cardeailsList)
                   
                        
                        )
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
}
