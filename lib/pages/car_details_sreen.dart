import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:ud_admin/domain/car_data.dart';
class CarDetailsScreen extends StatelessWidget {
   CarDetailsScreen({super.key});
  CarData cardata = CarData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Car Details",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            actions: [
                              Container(
                                decoration: BoxDecoration(border: Border.all()),
                                height: 50,
                                width: 100,
                                child: Center(child: Text("Submit")),
                              ),
                              Container(
                                decoration: BoxDecoration(border: Border.all()),
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
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 500,
                                        child:  DropdownButtonFormField(
      value: cardata.brand,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: "Brand",
      ),
      items: cardata.brandList.map((String value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      onChanged: (String? value) {
        cardata.brand = value;
    print(cardata);
        //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
      },
      onSaved: (newValue) {
      //  print(newValue);
       cardata.brand = newValue;
       // print( cardata.brand);
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
      value: cardata.brand,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: "Model",
      ),
      items: cardata.brandList.map((String value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      onChanged: (String? value) {
        cardata.brand = value;
    print(cardata);
        //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
      },
      onSaved: (newValue) {
      //  print(newValue);
       cardata.brand = newValue;
       // print( cardata.brand);
      },
    ),
                                        
                                      ),
                                        SizedBox(
                                        height: 10,
                                      ),
                                          Container(
                                        height: 50,
                                        width: 500,
                                        child: TextField(
                                        //  controller: brandnameController,
                                          decoration: const InputDecoration(
                                            label: Text("Car Number",
                                                style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        255, 152, 152, 152))),
                                            border: OutlineInputBorder(),
                                          ),
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
          ),
        ),
      ),
    );
  }
}