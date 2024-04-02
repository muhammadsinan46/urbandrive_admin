import 'package:flutter/material.dart';
import 'package:ud_admin/domain/car_data.dart';

class DropdownLoadingField extends StatelessWidget {
  const DropdownLoadingField({
    super.key,
    required this.categorylist,
    required this.cardata,
    required this.brandlist,
  });

  final List<String> categorylist;
  final CarData cardata;
  final List<String> brandlist;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            // height: 50,
            width: 280,
            child: DropdownButtonFormField(
              validator: (value) {
                if (value == null) {
                  return "Please select an Item";
                }
                return null;
              },
              //   value: cardata.model,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Category",
              ),
              items: categorylist.map((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (String? value) {
                cardata.categoryValue = value;

                //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
              },
              onSaved: (newValue) {
                //     (newValue);
                cardata.categoryValue = newValue;
                //    ( cardata.brand);
              },
            )),
        SizedBox(
          width: 10,
        ),
        Container(
          //     height: 50,
          width: 280,

          child: DropdownButtonFormField(
            validator: (value) {
              if (value == null) {
                return "Please select an Item";
              }
              return null;
            },
            // value: cardata.brand,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "Brands",
            ),
            items: brandlist.map((String value) {
              return DropdownMenuItem(value: value, child: Text(value));
            }).toList(),
            onChanged: (String? value) {
              cardata.brandValue = value;

              //BlocProvider.of<AddcarmenuBloc>(context).add(AddCarChangedEvent(dropchangedvalue:value! ));
            },
            onSaved: (newValue) {
              //     (newValue);
              cardata.brandValue = newValue;
              //    ( cardata.brand);
            },
          ),
        )
      ],
    );
  }
}
