import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ud_admin/domain/car_data.dart';
import 'package:ud_admin/domain/cardata_model.dart';
import 'package:ud_admin/domain/cardata_model_repo.dart';
import 'package:ud_admin/features/model_screen/bloc/car_model_list_bloc/car_model_list_bloc.dart';
import 'package:ud_admin/features/model_screen/bloc/model_image_bloc/carscreen_bloc.dart';
import 'package:ud_admin/features/model_screen/widgets/model_data_Text_field.dart';

class DataSource extends DataTableSource {
  final List<CarDataModel> carmodelList;

  DataSource({required this.carmodelList});


 
  bool isimageAvailable = false;

  CarDataModelRepo sample = CarDataModelRepo();

  String? carmodelId;

  double? _progress;

  bool ? showprogress =false;

  List<Uint8List>? imageFileList = [];

  List<String> categorylist = [];

  List<String> brandlist = [];

  //List<CarDataModel> carmodelList = [];


  final _formKey = GlobalKey();

  CarData cardata = CarData();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var modelController = TextEditingController();

  var priceController = TextEditingController();

  var depositController = TextEditingController();

  var freekmsController = TextEditingController();

  var extraController = TextEditingController();


  @override
  DataRow? getRow(int index) {
    if (index >= carmodelList.length) {
      return null;
    }

    return DataRow(cells: [
      DataCell(
        Text("${index + 1}"),
      ),
      DataCell(Text(
        carmodelList[index].brand!,
      )),
      DataCell(Text(carmodelList[index].model!)),
      DataCell(
        Text(
          carmodelList[index].category!,
          textAlign: TextAlign.center,
        ),
      ),
      DataCell(Text(carmodelList[index].transmit!)),
      DataCell(Text(carmodelList[index].fuel!)),
      DataCell(Text(
        carmodelList[index].baggage!,
        textAlign: TextAlign.center,
      )),
      DataCell(Text("₹ ${carmodelList[index].price!}")),
      DataCell(Text(carmodelList[index].seats!)),
      DataCell(Text("₹ ${carmodelList[index].deposit!}")),
      DataCell(Text("${carmodelList[index].freekms!} /kms")),
      DataCell(Text("₹ ${carmodelList[index].extrakms!}")),
      DataCell(PopupMenuButton(
          itemBuilder: (context) => [
                PopupMenuItem(
                onTap: (){
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
                                content: Stack(
                                  children: [
      
                                   
                                    Card(
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
                                    //if(showprogress==true) Center(child: CircularProgressIndicator(),)
                                  ],
                                ),
                              ),
                            );
                          });
                },
                  child:  Text("Edit"),
                  value: "Edit",
                ),
                PopupMenuItem( 
                  child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Delete"),
                              content: Text(
                                  "Are you sure you to delete  ${carmodelList[index].brand}  ${carmodelList[index].model}"),
                              actions: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),  
                                  height: 40,
                                  width: 100,
                                  child: Center(child: Text("Cancel")),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black,
                                  ),
                                  height: 40,
                                  width: 100,
                                  child: InkWell(
                                      onTap: () async {
                                        await FirebaseFirestore.instance
                                            .collection('models')
                                            .doc(carmodelList[index].id)
                                            .delete();
                                        context
                                            .read<CarModelListBloc>()
                                            .add(CarModelListLoadedEvent());
                                            Navigator.pop(context);
                                      },
                                      child: Center(
                                          child: Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.white),
                                      ))),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Text("Delete")),
                  value: "Delete",
                ),
              ],
          icon: Icon(Icons.more_vert_sharp))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => carmodelList.length + 2;

  @override
  int get selectedRowCount => 0;

}
