
// ignore_for_file: must_be_immutable

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_admin/features/booking/data_model/booking_model.dart';
import 'package:ud_admin/features/booking/presentation/bloc/booking_data_bloc.dart';

class UpcomingList extends StatelessWidget {
   UpcomingList({
    super.key,
  
  });

   List<BookingModel> upcomingBooking =[];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingDataBloc, BookingDataState>(
      builder: (context, state) {

        if(state is UpcomingBookingState){
          upcomingBooking = state.upcomingBookingList;
           return Column(
          //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(8),
                 
                  height: 50,
                 width: MediaQuery.sizeOf(context).width - 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Upcoming Bookings",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                      RichText(text: TextSpan(children: [
                        TextSpan(text:"Total no. of upcoming booking :\t" ),
                        TextSpan(text:"${upcomingBooking.length}",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold) ),
                      ]))
              
                    ],
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4, color: Colors.grey, offset: Offset(2, 2))
                  ],
                  borderRadius: BorderRadius.circular(20)),
              child: upcomingBooking.length == 0
                  ? Center(
                      child: Text("No upcoming booking available"),
                    )
                  : DataTable2(
                      headingRowDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      horizontalMargin: 20,
                      columnSpacing: 20,
                      dataTextStyle: TextStyle(
                        fontSize: 10,
                      ),
                      columns: [
                        DataColumn2(
                            label: Text(
                              "No.",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            size: ColumnSize.S),
                        DataColumn(
                            label: Text(
                          "User Name",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        )),
                        DataColumn2(
                            label: Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        )),
                        DataColumn2(
                            label: Text(
                             "Brand/Model" ,
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            size: ColumnSize.L),
                        DataColumn2(
                            label: Text(
                          "Pick-up date",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        )),
                        DataColumn2(
                            fixedWidth: 150,
                            size: ColumnSize.L,
                            label: Text(
                              "Pick-up Address",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            )),
                        DataColumn2(
                            label: Text(
                          "drop-off date",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        )),
                        DataColumn2(
                            fixedWidth: 180,
                            size: ColumnSize.L,
                            label: Text(
                              "drop-off Address",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            )),
                        DataColumn2(
                            label: Text(
                              "Total days",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            size: ColumnSize.S),
                        DataColumn2(
                            label: Text(
                              "Status",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            size: ColumnSize.M),
                        DataColumn2(
                            label: Text(
                              "Amount",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            size: ColumnSize.S),
                      ],
                      rows: List.generate(
                          upcomingBooking.length <= 4
                              ? upcomingBooking.length
                              : 4, (index) {
                        return DataRow2(
                          // onTap: () => _showUserDetailsDialog(context, index),
                          cells: [
                            DataCell(Text("${index + 1}")),
                            DataCell(Text(
                                "${upcomingBooking[index].userdata!['name']}")),
                            DataCell(Text(
                                "${upcomingBooking[index].userdata!['email'] ?? "N/A"}")),
                            DataCell(Text(
                                "${upcomingBooking[index].carmodel!['brand']}\t${upcomingBooking[index].carmodel!['model']}")),
                            DataCell(Text(
                                "${upcomingBooking[index].PickupDate!.substring(0, 10)}")),
                            DataCell(Text(
                                "${upcomingBooking[index].PickupAddress!}")),
                            DataCell(Text(
                                "${upcomingBooking[index].DropOffDate!.substring(0, 10)}")),
                            DataCell(Text(
                                "${upcomingBooking[index].DropoffAddress}")),
                            DataCell(
                                Text("${upcomingBooking[index].BookingDays}")),
                            DataCell(Text(
                                "${upcomingBooking[index].PaymentStatus}")),
                            DataCell(Text(
                                "${upcomingBooking[index].PaymentAmount}")),
                          ],
                        );
                      }),
                    ),
              height: 300,
              width: MediaQuery.sizeOf(context).width - 200,
            ),
          ],
        );

        }
        return Container();
      },
    );
  }
}

