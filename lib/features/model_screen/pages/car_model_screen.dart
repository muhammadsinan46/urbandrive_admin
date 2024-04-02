// ignore_for_file: must_be_immutable


import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ud_admin/features/model_screen/bloc/car_model_list_bloc/car_model_list_bloc.dart';
import 'package:ud_admin/features/model_screen/bloc/update_details_bloc/update_details_bloc.dart';
import 'package:ud_admin/features/model_screen/bloc/model_image_bloc/carscreen_bloc.dart';
import 'package:ud_admin/domain/car_data.dart';
import 'package:ud_admin/domain/cardata_model.dart';
import 'package:ud_admin/domain/cardata_model_repo.dart';
import 'package:ud_admin/features/model_screen/widgets/data_row.dart';
import 'package:ud_admin/features/model_screen/widgets/model_data_Text_field.dart';
import 'package:ud_admin/features/model_screen/widgets/model_table_loading.dart';

class ModelScreen extends StatefulWidget {
  ModelScreen({super.key});

  @override
  State<ModelScreen> createState() => _ModelScreenState();
}

class _ModelScreenState extends State<ModelScreen> {

  int _pagesize=10;
  bool isimageAvailable = false;

  CarDataModelRepo sample = CarDataModelRepo();

  String? carmodelId;

  double? _progress;

  bool ? showprogress =false;

  List<Uint8List>? imageFileList = [];

  List<String> categorylist = [];

  List<String> brandlist = [];

  List<CarDataModel> carmodelList = [];


  CarData cardata = CarData();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var modelController = TextEditingController();

  var priceController = TextEditingController();

  var depositController = TextEditingController();

  var freekmsController = TextEditingController();

  var extraController = TextEditingController();
var _searchController =TextEditingController();
  // var _multicontroller = MultiSelectController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    context.read<CarModelListBloc>().add(CarModelListLoadedEvent());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            // border: Border.all(),
            ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
              
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
      
              BlocBuilder<CarModelListBloc, CarModelListState>(
                builder: (context, state) {
                 
                  if (state is CarModelListInitial) {
                    //    return ListView.builder(itemBuilder: (context, index) {
                    return ModelTableLoading();
                  
                    //     },);
                  } else if (state is CarModelListUpdated) {
                    carmodelList = state.cardataList;
                    return carmodelList.length != 0?
                    PaginatedDataTable(
                                        sortAscending: false,
                      showCheckboxColumn: true,
                    rowsPerPage: _pagesize,
                                        
                    onRowsPerPageChanged: (value) {
                      setState(() {
                          _pagesize = value!;
                      });
                    },
                          
                      columns: [       DataColumn2(
                                
                                  label: Text(
                                    "No.",
                                  ),
                                  size: ColumnSize.S),
                          
                              DataColumn2(label: Text("Brand")),
                              DataColumn2(label: Text("model")),
                              DataColumn2( label: Text("Category"), ),
                              DataColumn2(label: Text("transmit")),
                              DataColumn2(label: Text("fuel")),
                              DataColumn2(label: Text("baggage")),
                              DataColumn2(label: Text("price")),
                              DataColumn2(label: Text("seats")),
                              DataColumn2(label: Text("deposit")),
                              DataColumn2(label: Text("freekms")),
                              DataColumn2(label: Text("extrakms")),
                        
                        
                              DataColumn2(label: Text("More")),
                    ], source: DataSource(carmodelList: carmodelList)
                                     
                    
                    )
                        : Container(
                            child: Center(
                              child: Text("No models to display"),
                            ),
                          );
                  }
                  
                   else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<String>> uploadImages(List<Uint8List>? imageFileList) async {
    final List<String> imageUrl =
        await Future.wait(imageFileList!.map((image) => uploadFile(image)));

    return imageUrl;
  }

  Future<String >uploadFile(Uint8List image) async {
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('model${image.hashCode}');

    firebase_storage.UploadTask uploadTask = ref.putData(image);

    await uploadTask.snapshotEvents.listen((event) {

    setState(() {
          _progress =event.bytesTransferred.toDouble();
        showprogress =true;
        
      
      
    });

    
    });
    await uploadTask;

    String downloadUrl = await ref.getDownloadURL();

   


    return  downloadUrl;
  }

  Widget submitModelForm(BuildContext context) {
    return LoadingBtn(
      color: Colors.black,
      

      roundLoadingShape: false,
       loader: Container(
      padding: const EdgeInsets.all(10),
      child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
      ),
    ),
         onTap: (startLoading, stopLoading, btnState) async {

             if (btnState == ButtonState.idle) {
            startLoading();
         if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          List<String> imgurlList =await  uploadImages(imageFileList);

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
            imageFileList = [];
            context.read<CarscreenBloc>().add(ModelImageUpdatedEvent());

            Navigator.pop(context);
             Fluttertoast.showToast(
              backgroundColor: Colors.green,
              toastLength:Toast.LENGTH_SHORT,
                msg: "File added to the databse");
          });
        }
            await Future.delayed(const Duration(seconds: 5));
            stopLoading();
        }
       
      },
      
      height: 50 , width: 140, child:Text("Submit", style: TextStyle(color: Colors.white),) );
  }

  submitModelData(context) async {}

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
