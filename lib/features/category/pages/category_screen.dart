// ignore_for_file: must_be_immutable
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:ud_admin/features/category/bloc/category_image_bloc/category_bloc.dart';
import 'package:ud_admin/features/category/bloc/category_list_bloc/categorylist_bloc.dart';
import 'package:ud_admin/domain/car_model_repo.dart';
import 'package:ud_admin/domain/category_model.dart';
import 'package:ud_admin/domain/category_repo.dart';
import 'package:ud_admin/features/category/widgets/category_intialList.dart';
import 'package:ud_admin/features/category/widgets/category_search_list.dart';
import 'package:ud_admin/features/category/widgets/category_updated_list.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  var categorynameController = TextEditingController();
  var descriptionController = TextEditingController();

  List<CategoryModel> categoryList = [];
  List<CategoryModel> categorySearchList = [];

  CarModelRepo carmodel = CarModelRepo();
  CategoryRepo cater = CategoryRepo();
  Uint8List? categoryImage;
  String? catefirestoreId;

  final _formKey = GlobalKey<FormState>();

  var _searchController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {

    context.read<CategorylistBloc>().add(CateListLoadedEvent());
    return Scaffold(
      body: SingleChildScrollView(
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
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.sizeOf(context).width - 1100,
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width - 1150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey)),
                              child: TextFormField(
                                onChanged: (value) {
                                  context
                                      .read<CategorylistBloc>()
                                      .add(CategorSearchEvent(search: value));
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Search here....",
                                  //label: Text("Search")
                                ),
                                controller: _searchController,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // carmodel.uploadBrandList();
                          //  cater.getCategoryData();
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


                                      GestureDetector(
                                        onTap: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();

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
                                            catefirestoreId = await firestore
                                                .collection('category')
                                                .doc()
                                                .id;

                                            Map<String, dynamic> datas = {
                                              "id": catefirestoreId,
                                              "image": newImageUrl,
                                              "name":
                                                  categorynameController.text,
                                              "description":
                                                  descriptionController.text
                                            };

                                            await firestore
                                                .collection('category')
                                                .doc(catefirestoreId)
                                                .set(datas)
                                                .then((value) {
                                              categorynameController.clear();
                                              descriptionController.clear();
                                              context
                                                  .read<CategorylistBloc>()
                                                  .add(CateListLoadedEvent());
                                              Navigator.pop(context);
                                            });
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all()),
                                          height: 50,
                                          width: 100,
                                          child: Center(child: Text("Submit")),
                                        ),
                                      ),
                                      //   },
                                      // ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all()),
                                          height: 50,
                                          width: 100,
                                          child: Center(child: Text("Cancel")),
                                        ),
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
                                                                .fromARGB(
                                                                255,
                                                                152,
                                                                152,
                                                                152))),
                                                    height: 100,
                                                    width: 150,
                                                    child: Center(
                                                        child: Text(
                                                      "Add Image",
                                                      style: TextStyle(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              152, 152, 152)),
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
                                                                .fromARGB(
                                                                255,
                                                                152,
                                                                152,
                                                                152))),
                                                    height: 100,
                                                    width: 150,
                                                    child: Center(
                                                        child: Image.memory(
                                                      state.cateImage,
                                                      fit: BoxFit.cover,
                                                    )),
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
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Please enter category name";
                                                    }
                                                    return null;
                                                  },
                                                  controller:
                                                      categorynameController,
                                                  decoration:
                                                      const InputDecoration(
                                                    label: Text("Category Name",
                                                        style: TextStyle(
                                                            color: const Color
                                                                .fromARGB(
                                                                255,
                                                                152,
                                                                152,
                                                                152))),
                                                    border:
                                                        OutlineInputBorder(),
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
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Please enter description";
                                                    }
                                                    return null;
                                                  },

                                                  controller:
                                                      descriptionController,
                                                  maxLines: 5,
                                                  decoration:
                                                      const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          hintText:
                                                              "Description",
                                                          hintStyle: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
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
                child: BlocBuilder<CategorylistBloc, CategorylistState>(
                  builder: (context, state) {
                    print(state.runtimeType);
                    if (state is CategorylistInitial) {
                      //    return ListView.builder(itemBuilder: (context, index) {
                      return CategoryInitialList(categoryList: categoryList);

                      //     },);
                    } else if (state is CategoryUpdatedState) {
                      categoryList = state.categoryList;
                      return categoryList.length != 0
                          ? CategoryUpdatedList(
                              categoryList: categoryList,
                              categoryImage: categoryImage,
                              categorynameController: categorynameController,
                              descriptionController: descriptionController,
                              firestore: firestore)
                          : Container(
                              child: Center(
                                child: Text("No Category to Display"),
                              ),
                            );
                    } else if (state is CategorySearchedList) {
                      categorySearchList = state.categorySearchList;
                      return CategorySearchList(
                          categorySearchList: categorySearchList,
                          categoryImage: categoryImage,
                          categorynameController: categorynameController,
                          descriptionController: descriptionController,
                          firestore: firestore,
                          categoryList: categoryList);
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
    );
  }
}
