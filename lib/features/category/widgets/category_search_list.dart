import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ud_admin/features/category/bloc/category_image_bloc/category_bloc.dart';
import 'package:ud_admin/features/category/bloc/category_list_bloc/categorylist_bloc.dart';
import 'package:ud_admin/domain/category_model.dart';


class CategorySearchList extends StatelessWidget {
  const CategorySearchList({
    super.key,
    required this.categorySearchList,
    required this.categoryImage,
    required this.categorynameController,
    required this.descriptionController,
    required this.firestore,
    required this.categoryList,
  });

  final List<CategoryModel> categorySearchList;
  final Uint8List? categoryImage;
  final TextEditingController categorynameController;
  final TextEditingController descriptionController;
  final FirebaseFirestore firestore;
  final List<CategoryModel> categoryList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          //    childAspectRatio: 1.2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 30.0),
      itemCount: categorySearchList.length,
      itemBuilder: (context, index) {
        return Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 2,
                height: 180,
                child: CachedNetworkImage(
                    imageUrl:
                        categorySearchList[index].image),
              ),
              Text(
                categorySearchList[index].name,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                  height: 50,
                  width: MediaQuery.sizeOf(context).width * 2,
                  child: Text(
                    categorySearchList[index].description,
                    style: TextStyle(fontSize: 12),
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                                  firebase_storage.Reference
                                      ref =
                                      await firebase_storage
                                          .FirebaseStorage
                                          .instance
                                          .ref(
                                              'category image${DateTime.now().millisecond}}');
                                  firebase_storage.UploadTask
                                      uploadTask =
                                      ref.putData(
                                          categoryImage!);
                                  await uploadTask;
                                  String newImageUrl =
                                      await ref
                                          .getDownloadURL();
                                  print(newImageUrl);
    
                                  Map<String, dynamic> datas =
                                      {
                                    "image": newImageUrl,
                                    "name":
                                        categorynameController
                                            .text,
                                    "description":
                                        descriptionController
                                            .text
                                  };
    
                                  await firestore
                                      .collection('category')
                                      .doc(categoryList[index]
                                          .name)
                                      .update(datas)
                                      .then((value) {
                                    categorynameController
                                        .clear();
                                    descriptionController
                                        .clear();
                                    context
                                        .read<
                                            CategorylistBloc>()
                                        .add(
                                            CateListLoadedEvent());
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all()),
                                  height: 50,
                                  width: 100,
                                  child: Center(
                                      child: Text("Submit")),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all()),
                                  height: 50,
                                  width: 100,
                                  child: Center(
                                      child: Text("Cancel")),
                                ),
                              )
                            ],
                            title: const Text(
                                "Add Brand Details"),
                            content: Container(
                              margin: EdgeInsets.all(15),
                              height: 400,
                              width: MediaQuery.of(context)
                                      .size
                                      .width -
                                  1000,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceEvenly,
                                children: [
                                  BlocBuilder<CategoryBloc,
                                      CategoryState>(
                                    builder:
                                        (context, state) {
                                      if (state
                                          is CategoryInitial) {
                                        return GestureDetector(
                                          onTap: () {
                                            context
                                                .read<
                                                    CategoryBloc>()
                                                .add(
                                                    CateUploadImageEvent());
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color
                                                        .fromARGB(
                                                        255,
                                                        152,
                                                        152,
                                                        152)),
                                                image: DecorationImage(
                                                    fit: BoxFit
                                                        .cover,
                                                    image: NetworkImage(
                                                        categoryList[index]
                                                            .image))),
                                            height: 150,
                                            width: 150,
                                          ),
                                        );
                                      } else if (state
                                          is UploadCateImageState) {
                                        return GestureDetector(
                                          onTap: () {
                                            context
                                                .read<
                                                    CategoryBloc>()
                                                .add(
                                                    CateUploadImageEvent());
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color
                                                        .fromARGB(
                                                        255,
                                                        152,
                                                        152,
                                                        152)),
                                                image: DecorationImage(
                                                    fit: BoxFit
                                                        .cover,
                                                    image: NetworkImage(
                                                        categoryList[index]
                                                            .image))),
                                            height: 150,
                                            width: 150,
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceEvenly,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 500,
                                        child: TextField(
                                          controller:
                                              categorynameController,
                                          decoration:
                                              InputDecoration(
                                            hintText:
                                                categoryList[
                                                        index]
                                                    .name,
                                            // label: Text(
                                            //     "Brand Name",
                                            //     style:
                                            //         TextStyle(color: const Color.fromARGB(255, 152, 152, 152))),
                                            border:
                                                OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        height: 150,
                                        width: 500,
                                        child: TextField(
                                          controller:
                                              descriptionController,
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                              border:
                                                  OutlineInputBorder(),
                                              hintText: categoryList[
                                                      index]
                                                  .description,
                                              hintStyle: TextStyle(
                                                  color: Color
                                                      .fromARGB(
                                                          255,
                                                          152,
                                                          152,
                                                          152))),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10),
                        color: Colors.blue[400],
                      ),
                      height: 40,
                      width: 100,
                      child: Center(
                          child: FaIcon(
                        FontAwesomeIcons.penToSquare,
                        color: Colors.white,
                        size: 18,
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Delete "),
                            content: Text(
                                "Are you sure you want to delete this category?"),
                            actions: [
                              GestureDetector(
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection('category')
                                      .doc(categoryList[index]
                                          .id)
                                      .delete()
                                      .then((value) {
                                    context
                                        .read<
                                            CategorylistBloc>()
                                        .add(
                                            CateListLoadedEvent());
    
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                  color: Colors.red,
                                  height: 40,
                                  width: 100,
                                  child: Center(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(
                                          color:
                                              Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black),
                                    color: Colors.white,
                                  ),
                                  height: 40,
                                  width: 100,
                                  child: Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color:
                                              Colors.black),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10),
                        color: Colors.red[400],
                      ),
                      height: 40,
                      width: 100,
                      child: Center(
                          child: FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.white,
                        size: 18,
                      )),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
