// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';


class AddCarDropMenu extends StatelessWidget {
  AddCarDropMenu(
      {super.key,
      required this.brandList,
      required this.hintTexted,
      required this.brandValue,
      required this.selectedvalue
      });

  List<String> brandList = [];
  String? hintTexted;
  String? brandValue;



  String? selectedvalue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: selectedvalue,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintTexted,
      ),
      items: brandList.map((String value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      onChanged: (String? value) {
        selectedvalue = value;
    print(selectedvalue);
        //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
      },
      // onSaved: (newValue) {
      //   print(newValue);
      //   selectedvalue = newValue;
      //   print(selectedvalue);
      // },
    );
  }
}
