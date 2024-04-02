


import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ModelTableLoading extends StatelessWidget {
  const ModelTableLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
      child: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: DataTable2(
        
            headingRowDecoration:
                BoxDecoration(border: Border.all()),
            //  decoration: BoxDecoration(border: Border.all()),
            horizontalMargin: 20,
            columnSpacing: 20,
            dataTextStyle: TextStyle(
              fontSize: 10,
            ),
            columns: const [
                   DataColumn2(
                    
                      label: Text(
                        "No.",
                      ),
                      size: ColumnSize.S),
              
                  DataColumn2(
                    label: Text("Category"),
                  ),
                  DataColumn2(label: Text("Brand")),
                  DataColumn2(label: Text("model")),
                  DataColumn2(label: Text("transmit")),
                  DataColumn2(label: Text("fuel")),
                  DataColumn2(label: Text("baggage")),
                  DataColumn2(label: Text("price")),
                  DataColumn2(label: Text("seats")),
                  DataColumn2(label: Text("deposit")),
                  DataColumn2(label: Text("freekms")),
                  DataColumn2(label: Text("extrakms")),
            
                  DataColumn2(label: Text("Edit")),
                  DataColumn2(label: Text("Delete")),
            ],
            rows: []),
      ),
    );
  }
}

