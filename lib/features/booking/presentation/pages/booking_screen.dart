// ignore_for_file: must_be_immutable
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_admin/features/booking/data_model/booking_model.dart';
import 'package:ud_admin/features/booking/presentation/widgets/booking_details_widget.dart';
import '../bloc/booking_data_bloc.dart';

class BookingScreen extends StatelessWidget {
  BookingScreen({super.key});

  List<BookingModel> bookingData = [];

  String? userId;
  String? CardModelId;

  @override
  Widget build(BuildContext context) {
    context.read<BookingDataBloc>().add(BookingDataLoadedEvent());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                  "Bookings",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
            Container(
              height: MediaQuery.sizeOf(context).height - 100,
              width: MediaQuery.sizeOf(context).width,
              child: Card(
              
                child: Container(
                  color:Colors.white,
                  child: BlocBuilder<BookingDataBloc, BookingDataState>(
                    builder: (context, state) {
                      if (state is BookingDataInitialState) {
                        return DataTable2(
                          headingRowColor: MaterialStatePropertyAll(Colors.white),
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
                              DataColumn2(
                                  label: Text("Total days"), size: ColumnSize.S),
                              DataColumn2(label: Text("Status"), size: ColumnSize.S),
                              DataColumn2(label: Text("Action"), size: ColumnSize.S),
                            ],
                            rows: []);
                      } else if (state is BookingDataLoadedState) {
                        bookingData = state.bookingdataList;
                        return DataTable2(
                          
                       dataRowColor:MaterialStatePropertyAll(Colors.white) ,
                                 headingRowColor: MaterialStatePropertyAll(Colors.white),
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
                           
                            DataColumn2(
                                label: Text("Total days"), size: ColumnSize.S),
                            DataColumn2(label: Text("Status"), size: ColumnSize.S),
                            DataColumn2(label: Text("Amount"), size: ColumnSize.S),
                          ],
                          rows: List.generate(bookingData.length, (index) {
                            return DataRow2(
                              onTap: () => _showBookingDetailsDialog(context, index),
                              cells: [
                                DataCell(Text("${index + 1}")),
                                DataCell(Text("${bookingData[index].BookingId}")),
                                DataCell(
                                    Text("${bookingData[index].userdata!['name']}")),
                                DataCell(Text(
                                    "${bookingData[index].userdata!['mobile'] ?? "N/A"}")),
                                DataCell(Text(
                                    "${bookingData[index].userdata!['email'] ?? "N/A"}")),
                                DataCell(Text(
                                    "${bookingData[index].carmodel!['brand']}\t${bookingData[index].carmodel!['model']}")),
                                // DataCell(Text("${bookingData[index].PickupDate}")),
                                // DataCell(Text("${bookingData[index].PickupAddress}")),
                                // DataCell(Text("${bookingData[index].DropOffDate}")),
                                // DataCell(Text("${bookingData[index].DropoffAddress}")),
                                DataCell(Text("${bookingData[index].BookingDays}")),
                                DataCell(Text("${bookingData[index].PaymentStatus}")),
                                DataCell(
                                    Text("₹ ${bookingData[index].PaymentAmount}")),
                              ],
                            );
                          }),
                        );
                      }
                      return Container(
                        child: Center(
                          child: Text("Failed to load booking details"),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showBookingDetailsDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Booking Details"),
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                height: 50,
                width: MediaQuery.sizeOf(context).width - 1000,
                child: Center(
                  child: Text(
                    "OK",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
        content: Container(
          
          height: MediaQuery.of(context).size.height - 400,
          width: MediaQuery.of(context).size.width - 1200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              BookingDetailsTile(   title: "User Name : \t",  bookingData: bookingData[index].userdata!['name']),
                 BookingDetailsTile( title:  "BookingId : \t",   bookingData:"${bookingData[index].BookingId}"),
                 BookingDetailsTile( title: "Mobile Number :\t ",   bookingData:"${bookingData[index].userdata!['mobile'] ?? "N/A"}"),
        
               BookingDetailsTile( title:  "Email: \t",   bookingData:"${bookingData[index].userdata!['email'] ?? "N/A"}"),
           
               BookingDetailsTile( title:   "Brand/Model :\t ",   bookingData:   "${bookingData[index].carmodel!['brand']}\t${bookingData[index].carmodel!['model']}"),
            
               BookingDetailsTile( title: "Pick-up Date :\t ",   bookingData: "${bookingData[index].PickupDate}"),
            
               BookingDetailsTile( title:  "Pick-up Address : \t",   bookingData: "${bookingData[index].PickupAddress}"),
             
               BookingDetailsTile( title:  "Drop-off Date :\t ",   bookingData:"${bookingData[index].DropOffDate}"),
             
               BookingDetailsTile( title: "Drop-off Adress: \t",   bookingData:"${bookingData[index].DropoffAddress}"),
        
               BookingDetailsTile( title:  "Booking days : \t",   bookingData: "${bookingData[index].BookingDays} "),
           
               BookingDetailsTile( title:  "Payment Status :\t ",   bookingData:"${bookingData[index].PaymentStatus}"),
           
               BookingDetailsTile( title: "Payment Amount :\t ",   bookingData:"₹ ${bookingData[index].PaymentAmount}"),
         
            ],
          ),
        ),
      ),
    );
  }
}
