import 'package:flutter/material.dart';
import 'package:ud_admin/domain/cardata_model.dart';

class DataSource extends DataTableSource {
  final List<CarDataModel> carmodelList;

DataSource({required this.carmodelList});

  @override
  DataRow? getRow(int index) {
    if (index >= carmodelList.length) {
      return null;
    }

    return DataRow(cells: [
      DataCell( Text("${index + 1}"), ),
      DataCell(Text(carmodelList[index].category!,textAlign: TextAlign.center,), ),
      DataCell(Text(carmodelList[index].brand!, )),
      DataCell(Text(carmodelList[index].model!)),
      DataCell(Text(carmodelList[index].transmit!)),
      DataCell(Text(carmodelList[index].fuel!)),
      DataCell(Text( carmodelList[index].baggage!, textAlign: TextAlign.center, )),
      DataCell(Text("₹ ${carmodelList[index].price!}")),
      DataCell(Text(carmodelList[index].seats!)),
      DataCell(Text("₹ ${carmodelList[index].deposit!}")),
      DataCell(Text("${carmodelList[index].freekms!} /kms")),
      DataCell(Text("₹ ${carmodelList[index].extrakms!}")),
      DataCell(Icon(Icons.edit)),
      DataCell(Icon(Icons.delete)),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => carmodelList.length+2;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount =>0;
}
