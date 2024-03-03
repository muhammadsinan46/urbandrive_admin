import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ud_admin/application/slidebar/bloc/slidebar_bloc.dart';
import 'package:ud_admin/pages/brand_screen.dart';
import 'package:ud_admin/pages/admin_login.dart';
import 'package:ud_admin/pages/bookings.dart';
import 'package:ud_admin/pages/car_details_sreen.dart';
import 'package:ud_admin/pages/car_model_screen.dart';
import 'package:ud_admin/pages/customer_page.dart';
import 'package:ud_admin/pages/inbox_page.dart';
import 'package:ud_admin/pages/category_screen.dart';
import 'package:ud_admin/pages/ud_dashboard.dart';

class MainPageScreen extends StatefulWidget {
  MainPageScreen({super.key});

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
   SharedPreferences? pref;
  String? username;

  initial() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref!.getString("email");
    });
  }

  @override
  void initState() {
    initial();
    super.initState();
  }

  int index = 0;

  List<Widget> pages = [
    const DashboradScreen(),
     CustomerScreen(),
     BookingScreen(),
    const InboxScreen(),
     CategoryScreen(),
     AddBrandScreen(),
    ModelScreen(),
     CarDetailsScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<SlidebarBloc, SlidebarState>(
      builder: (context, state) {
        if (state is SlidebarSuccessState) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: Size(450, 50),
                child: AppBar(
                  backgroundColor: Color.fromARGB(255, 219, 231, 249),
                  title: Text(
                    "data",
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    if (username != null) Text(username!),
                    IconButton(
                        onPressed: () {
                          
                          pref!.setBool("login", true);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminLoginScreen()));
                        },
                        icon: Icon(Icons.person))
                  ],
                )),
            body: CollapsibleSidebar(
                iconSize: 20,
                backgroundColor:Color.fromARGB(255, 219, 231, 249),
                selectedTextColor: Color.fromARGB(255, 0, 0, 0),
                unselectedTextColor: Colors.grey,
                textStyle:
                    const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                titleStyle: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
                toggleTitleStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                sidebarBoxShadow: const [],
                collapseOnBodyTap: false,
                itemPadding: 10,
                selectedIconBox: const Color.fromARGB(255, 255, 255, 255),
                selectedIconColor: Colors.pink,
                showTitle: true,
                avatarBackgroundColor: Colors.red,
                title: "Data",
              //  isCollapsed: false,
                //  bottomPadding: 35,

                //  avatarImg: "gauygivdvbf",

                items: [
                  CollapsibleItem(
                      isSelected: true,
                      text: "Dashboard",
                      icon: Icons.dashboard,
                      onPressed: () {
                        BlocProvider.of<SlidebarBloc>(context)
                            .add(SlidebarChangeEvent(index: index));
                      }),
                  CollapsibleItem(
                      text: "customers",
                      icon: Icons.groups,
                      onPressed: () {
                        BlocProvider.of<SlidebarBloc>(context)
                            .add(SlidebarChangeEvent(index: index + 1));
                      }),
                         CollapsibleItem(
                      text: "Bookings",
                      icon: FontAwesomeIcons.calendarWeek,
                      onPressed: () {
                        BlocProvider.of<SlidebarBloc>(context)
                            .add(SlidebarChangeEvent(index: index + 2));
                      }),
                  CollapsibleItem(
                      text: "Inbox",
                      icon: FontAwesomeIcons.envelope ,
                      onPressed: () {
                        BlocProvider.of<SlidebarBloc>(context)
                            .add(SlidebarChangeEvent(index: index +3));
                      }),
                         CollapsibleItem(
                      text: "Category",
                      icon: Icons.category,
                      onPressed: () {
                        BlocProvider.of<SlidebarBloc>(context)
                            .add(SlidebarChangeEvent(index: index + 4));
                      }),
                        CollapsibleItem(
                      text: "Brands",
                      icon: FontAwesomeIcons.rankingStar,
                      onPressed: () {
                        BlocProvider.of<SlidebarBloc>(context)
                            .add(SlidebarChangeEvent(index: index + 5));
                      }),
                           CollapsibleItem(
                      text: "Models",
                      icon: FontAwesomeIcons.taxi,
                      onPressed: () {
                        BlocProvider.of<SlidebarBloc>(context)
                            .add(SlidebarChangeEvent(index: index + 6));
                      }),
                       
                              CollapsibleItem(
                      text: "Car Details",
                      icon: FontAwesomeIcons.carSide,
                      onPressed: () {
                        BlocProvider.of<SlidebarBloc>(context)
                            .add(SlidebarChangeEvent(index: index + 7));
                      }),
                       


             
               
                      
                      
                      
                ],
                body: pages[state.index]),
          );
        }
        return pages[0];
      },
    );
  }
}
