import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_admin/domain/booking_model.dart';

import '../application/BookingScreen/booking_datat_bloc/booking_data_bloc.dart';

class BookingScreen extends StatelessWidget {
   BookingScreen({super.key});


  List<BookingModel> bookingData =[];

  String? userId;
  String ?CardModelId;

  @override
  Widget build(BuildContext context) {
    context.read<BookingDataBloc>().add(BookingDataLoadedEvent());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.sizeOf(context).height - 100,
                  width: MediaQuery.sizeOf(context).width,
          child: Card(
            color: const Color.fromARGB(255, 237, 241, 245),
            child: BlocBuilder<BookingDataBloc, BookingDataState>(

              
              builder: (context, state) {

                if(state is BookingDataInitialState ){
                
                    return DataTable2(
            headingRowDecoration: BoxDecoration(border: Border.all()),
                 
                            horizontalMargin: 20,
                             columnSpacing: 20,
                              dataTextStyle: TextStyle(
                                fontSize: 10,
                              ),
                  columns: [
                         DataColumn2(label: Text("No."), size: ColumnSize.S),
                    DataColumn2(label: Text("Booking Id")),
                    DataColumn(label: Text("User Name")),
                    DataColumn2(label: Text("Mobile Number")),
                    DataColumn2(label: Text("Email"), size: ColumnSize.L),
                    DataColumn2(label: Text("Car Model")),
                    DataColumn2(label: Text("Pick-up date")),
                    DataColumn2(label: Text("Pick-up Address")),
                    DataColumn2(label: Text("drop-off date")),
                    DataColumn2(label: Text("drop-off Address")),
                    DataColumn2(label: Text("Total days"), size: ColumnSize.S),
                    DataColumn2(label: Text("Status"), size: ColumnSize.S),
                    DataColumn2(label: Text("Action"), size: ColumnSize.S),
                  ],
                  rows: []
                );

                }else if(state is BookingDataLoadedState){



                  bookingData =state.bookingdataList;
                    return DataTable2(
                       headingRowDecoration: BoxDecoration(border: Border.all()),
                 
                            horizontalMargin: 20,
                             columnSpacing: 20,
                              dataTextStyle: TextStyle(
                                fontSize: 10,
                              ),
               
                  columns: [
                    DataColumn2(label: Text("No."), size: ColumnSize.S),
                    DataColumn2(label: Text("Booking Id")),
                    DataColumn(label: Text("User Name")),
                    DataColumn2(label: Text("Mobile Number")),
                    DataColumn2(label: Text("Email"), size: ColumnSize.L),
                    DataColumn2(label: Text("Car Model")),
                    DataColumn2(label: Text("Pick-up date")),
                    DataColumn2(label: Text("Pick-up Address")),
                    DataColumn2(label: Text("drop-off date")),
                    DataColumn2(label: Text("drop-off Address")),
                    DataColumn2(label: Text("Total days"), size: ColumnSize.S),
                    DataColumn2(label: Text("Status"), size: ColumnSize.S),
                    DataColumn2(label: Text("Amount"), size: ColumnSize.S),
                  ],
                  rows: List.generate(bookingData.length, (index) {
                    return DataRow2(
                      // onTap: () => _showUserDetailsDialog(context, index),
                      cells: [
                        DataCell(Text("${index + 1}")),
                        DataCell(Text("${bookingData[index].BookingId}")),
                      DataCell(Text("${bookingData[index].userdata!['name']}")),
                        DataCell(Text("${bookingData[index].userdata!['mobile']??"N/A"}")),
                        DataCell(Text("${bookingData[index].userdata!['email']??"N/A"}")),
                        DataCell(Text("${bookingData[index].carmodel!['brand']}\t${bookingData[index].carmodel!['model']}")),
                        DataCell(Text("${bookingData[index].PickupDate}")),
                        DataCell(Text("${bookingData[index].PickupAddress}")),
                        DataCell(Text("${bookingData[index].DropOffDate}")),
                        DataCell(Text("${bookingData[index].DropoffAddress}")),
                        DataCell(Text("${bookingData[index].BookingDays}")),
                        DataCell(Text("${bookingData[index].PaymentStatus}")),
                        DataCell(Text("${bookingData[index].PaymentAmount}")),
                      ],
                    );
                  }),
                );
                }
                return Container(child: Center(child: Text("Failed to load booking details"),),);
              },
            ),
          ),
        ),
      ),
    );
  }
}
