import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ud_admin/application/brandScreen/brand_list_bloc/brand_list_bloc.dart';
import 'package:ud_admin/application/brandScreen/brand_logo/brand_logo_bloc.dart';
import 'package:ud_admin/domain/brand_model.dart';

class AddBrandScreen extends StatelessWidget {
  AddBrandScreen({super.key});

  var brandnameController = TextEditingController();
  var descriptionController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Uint8List? brandlogo;

  List<BrandModel> brandList = [];
  @override
  Widget build(BuildContext context) {
    context.read<BrandListBloc>().add(BrandListLoadedEvent());
      
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
                      "Brand",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                actions: [
                                  GestureDetector(
                                    onTap: () async {
                                      firebase_storage.Reference ref =
                                          await firebase_storage
                                              .FirebaseStorage.instance
                                              .ref(
                                                  '/brand${brandnameController.text}');

                                      firebase_storage.UploadTask uploadTask =
                                          ref.putData(brandlogo!);
                                      await uploadTask;
                                      String logoUrl =
                                          await ref.getDownloadURL();
                                      print("${logoUrl}");

                                      Map<String, dynamic> datas = {
                                        "name": brandnameController.text,
                                        "description":
                                            descriptionController.text,
                                        "logo": logoUrl
                                      };
                                      await firestore
                                          .collection('brands')
                                          .doc(brandnameController.text)
                                          .set(datas)
                                          .then((value) {
                                        context
                                            .read<BrandListBloc>()
                                            .add(BrandListLoadedEvent());
                                            Navigator.pop(context);
                                      });
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
                                title: const Text("Add Brand Details"),
                                content: Container(
                                  margin: EdgeInsets.all(15),
                                  height: 400,
                                  width:
                                      MediaQuery.of(context).size.width - 1000,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      BlocBuilder<BrandLogoBloc,
                                          BrandLogoState>(
                                        builder: (context, state) {
                                          if (state is BrandLogoLoading) {
                                            return GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<BrandLogoBloc>()
                                                    .add(LogoLoadedEvent());
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color
                                                            .fromARGB(255, 152,
                                                            152, 152))),
                                                height: 150,
                                                width: 150,
                                                child: Center(
                                                    child: Text(
                                                  "Add logo",
                                                  style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              152,
                                                              152,
                                                              152)),
                                                )),
                                              ),
                                            );
                                          } else if (state
                                              is BrandLogoUpdated) {
                                            brandlogo = state.brandlogo;
                                            return GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<BrandLogoBloc>()
                                                    .add(LogoLoadedEvent());
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color
                                                            .fromARGB(255, 152,
                                                            152, 152))),
                                                height: 150,
                                                width: 150,
                                                child: Image.memory(
                                                  state.brandlogo,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 500,
                                            child: TextField(
                                              controller: brandnameController,
                                              decoration: const InputDecoration(
                                                label: Text("Brand Name",
                                                    style: TextStyle(
                                                        color: const Color
                                                            .fromARGB(255, 152,
                                                            152, 152))),
                                                border: OutlineInputBorder(),
                                              ),
                                              // controller:
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 150,
                                            width: 500,
                                            child: TextField(
                                              controller: descriptionController,
                                              maxLines: 5,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: "Description",
                                                  hintStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 152, 152, 152))),
                                              // controller:
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
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
                          "Add Brand",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                      ),
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  height: MediaQuery.sizeOf(context).height - 200,
                  width: MediaQuery.sizeOf(context).width - 500,
                  child: BlocBuilder<BrandListBloc, BrandListState>(
                    builder: (context, state) {
                      print(state.runtimeType);
                      if (state is BrandListInitial) {
                        //    return ListView.builder(itemBuilder: (context, index) {
                        return DataTable(
                            columns: [
                              DataColumn(label: Text("No.")),
                              DataColumn(label: Text("Logo")),
                              DataColumn(label: Text("Brand Name")),
                              DataColumn(label: Text("Description")),
                              DataColumn(label: Text("Edit")),
                              DataColumn(label: Text("Delete")),
                            ],
                            rows: List.generate(0, (index) {
                              return DataRow(cells: []);
                            }));

                        //     },);
                      } else if (state is BrandLoadedList) {
                        brandList = state.brandList;
                        return DataTable(
                            columns: [
                              DataColumn(label: Text("No.")),
                              DataColumn(label: Text("Logo")),
                              DataColumn(label: Text("Brand Name")),
                              DataColumn(label: Text("Description")),
                              DataColumn(label: Text("Edit")),
                              DataColumn(label: Text("Delete")),
                            ],
                            rows: List.generate(brandList.length, (index) {
                              return DataRow(cells: [
                                DataCell(Text("${index + 1}")),
                                DataCell(Image.network(
                                  brandList[index].logo,
                                )),
                                DataCell(Text(brandList[index].name)),
                                DataCell(Text(brandList[index].description)),
                                DataCell(Icon(Icons.edit)),
                                DataCell(Icon(Icons.delete)),
                              ]);
                            }));
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
