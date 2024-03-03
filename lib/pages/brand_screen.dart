// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                  //  border: Border.all(),
                  ),
                  height: MediaQuery.sizeOf(context).height - 200,
                  width: MediaQuery.sizeOf(context).width - 500,
                  child: BlocBuilder<BrandListBloc, BrandListState>(
                    builder: (context, state) {
                      print(state.runtimeType);
                      if (state is BrandListInitial) {
                        //    return ListView.builder(itemBuilder: (context, index) {
                        return  GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                         
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 30.0),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return
                             Card(
                               clipBehavior: Clip.antiAliasWithSaveLayer,
                               child:Center(child: CircularProgressIndicator(),)
                             );
                          },
                        )
                        ;
                       

                        //     },);
                      } else if (state is BrandLoadedList) {
                        brandList = state.brandList;
                        return 

                        GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                         
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 30.0),
                          itemCount: brandList.length,
                          itemBuilder: (context, index) {
                            return
                             GestureDetector(
                      onTap: () => showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        actions: [Center(child: GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),  color: Colors.black,),
                                            height: 50,width: 140,child: Center(child: Text("OK", style: TextStyle(fontSize: 18, color: Colors.white),)),),
                                        ))],
                                            content: Container(
                                              height: MediaQuery.sizeOf(context)
                                                      .height -
                                                  400,
                                              width: MediaQuery.sizeOf(context)
                                                      .width -
                                                  1200,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  CircleAvatar(
                                                    radius: 80,
                                                    child:  Image.network( brandList[index].logo),
                                                  ),
                                                  Text(
                                                    brandList[index].name,
                                                    style:
                                                        TextStyle(fontSize: 22),
                                                  ),
                                                  Text(brandList[index].description),
                                                  Text("Number of Cars: 12"),
                                               
                                                ],
                                              ),
                                            ),
                                          )
                                          ),
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      
                                      width: MediaQuery.sizeOf(context).width*2,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        // border: Border.all(),
                                          image: DecorationImage(fit: BoxFit.cover,
                                              image: NetworkImage(
                                        brandList[index].logo,
                                      ))),
                                    ),
                                   Text(brandList[index].name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                 //  Text(brandList[index].description),
                                   
                                  SizedBox(height: 6,),
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    Container(
                                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),   color:Colors.black ,),
                                    
                                    
                                      height: 30,
                                      width: 80,
                                      child: Center(child: FaIcon(FontAwesomeIcons.penToSquare, color: Colors.white,size: 12,)),),
                                      SizedBox(width: 20,),
                                    Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),   color:Colors.white ,border: Border.all()),
                                    
                                      height: 30,
                                      width: 80,
                                      child: Center(child: FaIcon(FontAwesomeIcons.trashCan, color: Colors.black,size: 12,)),),
                                   ],)
                                   
                                  ],
                                ),
                              ),
                            );
                          },
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
