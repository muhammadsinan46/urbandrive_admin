// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AddCarDropMenu extends StatefulWidget {
  final List<String> brandList;
  final String? hintText;
  String? brandValue;
  String? selectedValue;

  AddCarDropMenu({
    Key? key,
    required this.brandList,
    required this.hintText,
    required this.brandValue,
    required this.selectedValue,
  }) : super(key: key);

  @override
  _AddCarDropMenuState createState() => _AddCarDropMenuState();
}

class _AddCarDropMenuState extends State<AddCarDropMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget.selectedValue,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.hintText,
      ),
      items: widget.brandList.map((String value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          widget.selectedValue = value;
          print(widget.selectedValue);
          // BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue: value! ));
        });
      },
    );
  }
}
