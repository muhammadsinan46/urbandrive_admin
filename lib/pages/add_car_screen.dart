// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_admin/application/addcar/bloc/addcarmenu_bloc.dart';

class AddCarDropMenu extends StatefulWidget {
  AddCarDropMenu(
      {super.key,
      required this.brandList,
      required this.hintTexted,
      required this.brandValue});

  List<String> brandList = [];
  String? hintTexted;
  String? brandValue;

  @override
  State<AddCarDropMenu> createState() => _AddCarDropMenuState();
}

class _AddCarDropMenuState extends State<AddCarDropMenu> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddcarmenuBloc, AddcarmenuState>(
      builder: (context, state) {
        return DropdownButtonFormField(
            decoration: InputDecoration(
                border:const  OutlineInputBorder(),
              hintText:widget. hintTexted,
            ),
            items: widget.brandList.map((String value) {
              return DropdownMenuItem(value: value, child: Text(value));
            }).toList(),
            onChanged: (String? value) {

              BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
             
            });
      },
    );
  }
}
