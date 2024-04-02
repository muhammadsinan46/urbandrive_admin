// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:ud_admin/features/booking/presentation/bloc/booking_data_bloc.dart';
import 'package:ud_admin/features/dashboard/bloc/dash_board_bloc/dash_card_bloc.dart';
import 'package:ud_admin/features/dashboard/data/chart_model.dart';
import 'package:ud_admin/features/dashboard/domain/dashboard_repo.dart';
import 'package:ud_admin/features/dashboard/domain/donut_chart_repo.dart';
import 'package:ud_admin/features/dashboard/widgets/dashboard_card.dart';

import 'package:ud_admin/features/dashboard/widgets/upcoming_list_widget.dart';

class DashboradScreen extends StatelessWidget {
  DashboradScreen({super.key});

  DashBoardRepo? repo;

  DateTime _selectedDay = DateTime.now();
  int? startDate;
  int? endDate;
  List<DateTime>? monthRange;

  DateTime _focusDay = DateTime.now();

  DonutChartRepo? chartRepo;

  @override
  Widget build(BuildContext context) {
    context.read<BookingDataBloc>().add(UpcomingBookingEvent());
    context.read<DashCardBloc>().add(DashCardLoadedEvent());
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () async {
                  await chartRepo!.getChartStatusData();
                },
                child: Text(
                  "DashBoard",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  margin: EdgeInsets.all(12),
                  height: 300,
                  width: MediaQuery.sizeOf(context).width - 850,
                  child: BlocBuilder<DashCardBloc, DashCardState>(
                    builder: (context, state) {
                      if (state is DashCardLoadedState) {
                        return GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 18,
                                  crossAxisSpacing: 28,
                                  childAspectRatio: 2.5),
                          children: [
                            DashboardCard(
                              value: "₹ ${state.dashcard.totalRevenue!}",
                              title: "Total Revenue",
                              icon: 'lib/assets/images/rupee.png',
                              bgColor: Color.fromARGB(255, 154, 121, 237),
                            ),
                            DashboardCard(
                              value: "${state.dashcard.totalBooking!}",
                              title: "Total Booking",
                              icon: 'lib/assets/images/booking.png',
                              bgColor: Color.fromARGB(255, 121, 191, 237),
                            ),
                            DashboardCard(
                              value: "${state.dashcard.totalCars!}",
                              title: "Total Cars",
                              icon: 'lib/assets/images/car.png',
                              bgColor: Color.fromARGB(255, 187, 237, 121),
                            ),
                            DashboardCard(
                              value: "${state.dashcard.totalCustomers!}",
                              title: "Total Customers",
                              icon: 'lib/assets/images/users.png',
                              bgColor: Color.fromARGB(255, 237, 121, 142),
                            ),
                          ],
                        );
                      }
                      return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 18,
                            crossAxisSpacing: 28,
                            childAspectRatio: 2.5),
                        children: [
                          DashboardCard(
                            value: "",
                            title: "Total Revenue",
                            icon: 'lib/assets/images/rupee.png',
                            bgColor: Color.fromARGB(255, 154, 121, 237),
                          ),
                          DashboardCard(
                            value: "",
                            title: "Total Booking",
                            icon: 'lib/assets/images/booking.png',
                            bgColor: Color.fromARGB(255, 121, 191, 237),
                          ),
                          DashboardCard(
                            value: "",
                            title: "Total Cars",
                            icon: 'lib/assets/images/car.png',
                            bgColor: Color.fromARGB(255, 187, 237, 121),
                          ),
                          DashboardCard(
                            value: "",
                            title: "Total Customers",
                            icon: 'lib/assets/images/users.png',
                            bgColor: Color.fromARGB(255, 237, 121, 142),
                          ),
                        ],
                      );
                    },
                  )),
            ],
          ),
          UpcomingList()
        ],
      ),
    );
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    _focusDay = focusedDay;

    _selectedDay = start!;
    _selectedDay = start;

    monthRange!
      ..add(start)
      ..add(end!);
  }

  getchartData(DateTime _selectedDay) {}
}
