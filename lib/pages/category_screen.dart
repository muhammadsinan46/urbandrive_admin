import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:ud_admin/application/categoryScreen/category_image_bloc/category_bloc.dart';
import 'package:ud_admin/application/categoryScreen/category_list_bloc/categorylist_bloc.dart';
import 'package:ud_admin/domain/car_model_repo.dart';

import 'package:ud_admin/domain/category_model.dart';
import 'package:ud_admin/domain/category_repo.dart';



class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  var categorynameController = TextEditingController();
  var descriptionController = TextEditingController();

  List<CategoryModel> categoryList = [];

  CarModelRepo carmodel =CarModelRepo();
  CategoryRepo cater = CategoryRepo();
  Uint8List? categoryImage;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    context.read<CategorylistBloc>().add(CateListLoadedEvent());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(),
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
                      "Category",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {

                        carmodel.uploadBrandList();
                      //  cater.getCategoryData();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Form(
                                child: AlertDialog(
                                  backgroundColor: Colors.white,
                                  actions: [
                                    BlocBuilder<CategoryBloc, CategoryState>(
                                      builder: (context, state) {
                                        return GestureDetector(
                                          onTap: () async {
                                            firebase_storage.Reference ref =
                                                await firebase_storage
                                                    .FirebaseStorage.instance
                                                    .ref(
                                                        '/ccategory${categorynameController.text}');
                                            firebase_storage.UploadTask
                                                uploadTask =
                                                ref.putData(categoryImage!);
                                            await uploadTask;
                                            String newImageUrl =
                                                await ref.getDownloadURL();
                                            print(newImageUrl);

                                            Map<String, dynamic> datas = {
                                              "image": newImageUrl,
                                              "name":
                                                  categorynameController.text,
                                              "description":
                                                  descriptionController.text
                                            };

                                            await firestore
                                                .collection('category')
                                                .doc(
                                                    categorynameController.text)
                                                .set(datas)
                                                .then((value) {
                                              categorynameController.text = "";
                                              descriptionController.text = "";
                                              context
                                                  .read<CategorylistBloc>()
                                                  .add(CateListLoadedEvent());
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                            height: 50,
                                            width: 100,
                                            child:
                                                Center(child: Text("Submit")),
                                          ),
                                        );
                                      },
                                    ),
                                    Container(
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      height: 50,
                                      width: 100,
                                      child: Center(child: Text("Clear")),
                                    )
                                  ],
                                  title: const Text("Add Category Details"),
                                  content: Container(
                                    margin: EdgeInsets.all(15),
                                    height: 400,
                                    width: MediaQuery.of(context).size.width -
                                        1000,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BlocBuilder<CategoryBloc,
                                            CategoryState>(
                                          builder: (context, state) {
                                            if (state is CategoryInitial) {
                                              return GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<CategoryBloc>()
                                                      .add(
                                                          CateUploadImageEvent());
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              152, 152, 152))),
                                                  height: 100,
                                                  width: 150,
                                                  child: Center(
                                                      child: Text(
                                                    "Add Image",
                                                    style: TextStyle(
                                                        color: const Color
                                                            .fromARGB(255, 152,
                                                            152, 152)),
                                                  )),
                                                ),
                                              );
                                            } else if (state
                                                is UploadCateImageState) {
                                              categoryImage = state.cateImage;
                                              return GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<CategoryBloc>()
                                                      .add(
                                                          CateUploadImageEvent());
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              152, 152, 152))),
                                                  height: 100,
                                                  width: 150,
                                                  child: Center(
                                                        child: Image.memory(
                                                      state.cateImage,
                                                      fit: BoxFit.cover,
                                                    )
                                                  ),
                                                ),
                                              );
                                            }
                                            return Container();
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
                                                controller:
                                                    categorynameController,
                                                decoration:
                                                    const InputDecoration(
                                                  label: Text("Category Name",
                                                      style: TextStyle(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              152, 152, 152))),
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
                                                controller:
                                                    descriptionController,
                                                maxLines: 5,
                                                decoration:
                                                    const InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        hintText: "Description",
                                                        hintStyle: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    152,
                                                                    152,
                                                                    152))),
                                                // controller:
                                              ),
                                            ),
                                          ],
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
                    ),
                  ],
                ),
                //row

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  height: MediaQuery.sizeOf(context).height - 100,
                  width: MediaQuery.sizeOf(context).width - 500,
                  child: BlocBuilder<CategorylistBloc, CategorylistState>(
                    builder: (context, state) {
                      print(state.runtimeType);
                      if (state is CategorylistInitial) {
                        //    return ListView.builder(itemBuilder: (context, index) {
                        return DataTable(
                            columns: [
                              DataColumn(label: Text("No.")),
                              DataColumn(label: Text("Image")),
                              DataColumn(label: Text("Category Name")),
                              DataColumn(label: Text("Description")),
                            ],
                            rows: List.generate(0, (index) {
                              return DataRow(cells: []);
                            }));

                        //     },);
                      } else if (state is CategoryUpdatedState) {
                        categoryList = state.categoryList;
                        return DataTable(
                            columns: [
                              DataColumn(label: Text("No.")),
                              DataColumn(label: Text("Image")),
                              DataColumn(label: Text("Category Name")),
                              DataColumn(label: Text("Description")),
                              DataColumn(label: Text("Edit")),
                              DataColumn(label: Text("Delete")),
                            ],
                            rows: List.generate(categoryList.length, (index) {
                              return DataRow(cells: [
                                DataCell(Text("${index+1}")),
                                      
                                      DataCell(Image.network(categoryList[index].image,)),
                                    
                                DataCell(
                                    Text(categoryList[index].name)),
                                DataCell(Text(
                                    categoryList[index].description)),
                                           DataCell(
                                   Icon(Icons.edit)),
                                           DataCell(
                                    Icon(Icons.delete)
                                    ),
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
