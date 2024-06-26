// ignore_for_file: must_be_immutable

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_admin/features/customers/bloc/customers_list_bloc.dart';
import 'package:ud_admin/domain/customers_model.dart';

class CustomerScreen extends StatelessWidget {
  CustomerScreen({Key? key});

  List<CustomersModel> userslist = [];

  @override
  Widget build(BuildContext context) {
    context.read<CustomersListBloc>().add(CustomerListLoadedEvent());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: const Text(
                "Customers List",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            BlocBuilder<CustomersListBloc, CustomersListState>(
              builder: (context, state) {
      
                if (state is CustomersListLoading) {
                  return _buildDataTableSkeleton(context);
                } else if (state is CustomersListLoaded) {
                  userslist = state.customersList;
                  return userslist.length!=0 ? _buildDataTable(context):Container(child: Center(child: Text("No customers to display"),),);
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDataTableSkeleton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      height: MediaQuery.of(context).size.height - 100,
      width: MediaQuery.of(context).size.width - 500,
      child: Card(
        color: const Color.fromARGB(255, 237, 241, 245),
        child: DataTable2(
          showBottomBorder: false,
          columns: [
            DataColumn2(label: Text("No."), size: ColumnSize.S),
            DataColumn2(label: Text("Id.")),
            DataColumn2(label: Text("Name")),
            DataColumn2(label: Text("Email"), size: ColumnSize.M),
            DataColumn2(label: Text("Mobile Number")),
            DataColumn2(label: Text("DL proof")),
            DataColumn2(label: Text("Action"), size: ColumnSize.S),
          ],
          rows: [],
        ),
      ),
    );
  }

  Widget _buildDataTable(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      width: MediaQuery.of(context).size.width - 400,
      child: Card(
        color: const Color.fromARGB(255, 237, 241, 245),
        child: DataTable2(
          showBottomBorder: false,
          columns: [
            DataColumn2(label: Text("No."), size: ColumnSize.S),
            DataColumn2(label: Text("Id.")),
            DataColumn(label: Text("Name")),
            DataColumn2(label: Text("Email"), size: ColumnSize.L),
          //  DataColumn2(label: Text("Mobile Number")),
       
          
          ],
          rows: List.generate(userslist.length, (index) {
            return DataRow2(
              onTap: () => _showUserDetailsDialog(context, index),
              cells: [
                DataCell(Text("${index + 1}")),
                DataCell(Text(userslist[index].id.substring(0, 5))),
                DataCell(Text(userslist[index].name)),
                DataCell(Text(userslist[index].email)),
             //   DataCell(Text(userslist[index].mobile)),
          
              
              ],
            );
          }),
        ),
      ),
    );
  }

  void _showUserDetailsDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
                width: 140,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 80,
                child: Icon(Icons.person_2_outlined),
              ),
              Text(
                userslist[index].name,
                style: TextStyle(fontSize: 22),
              ),
              Text(userslist[index].email),
             // Text(userslist[index].mobile),
              Text("DL Status: Not submitted"),
            ],
          ),
        ),
      ),
    );
  }
}
