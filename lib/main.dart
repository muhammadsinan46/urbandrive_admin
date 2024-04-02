import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_admin/domain/car_details_repo.dart';
import 'package:ud_admin/features/admin_login/pages/admin_login.dart';
import 'package:ud_admin/features/booking/presentation/bloc/booking_data_bloc.dart';
import 'package:ud_admin/features/brands/bloc/brand_list_bloc/brand_list_bloc.dart';
import 'package:ud_admin/features/brands/bloc/brand_logo/brand_logo_bloc.dart';
import 'package:ud_admin/features/car_details/bloc/car_details_list/car_details_list_bloc.dart';
import 'package:ud_admin/features/car_details/bloc/car_model_bloc/car_details_bloc.dart';
import 'package:ud_admin/features/dashboard/bloc/dash_board_bloc/dash_card_bloc.dart';
import 'package:ud_admin/features/dashboard/domain/dashboard_repo.dart';
import 'package:ud_admin/features/inbox_screen/bloc/chatuser_bloc.dart';
import 'package:ud_admin/features/inbox_screen/domain/inbox_repo.dart';
import 'package:ud_admin/features/model_screen/bloc/car_model_list_bloc/car_model_list_bloc.dart';
import 'package:ud_admin/features/model_screen/bloc/update_details_bloc/update_details_bloc.dart';
import 'package:ud_admin/features/model_screen/bloc/model_image_bloc/carscreen_bloc.dart';


import 'package:ud_admin/features/category/bloc/category_image_bloc/category_bloc.dart';
import 'package:ud_admin/features/category/bloc/category_list_bloc/categorylist_bloc.dart';
import 'package:ud_admin/features/customers/bloc/customers_list_bloc.dart';


import 'package:ud_admin/features/main_screen/bloc/slidebar_bloc.dart';
import 'package:ud_admin/features/booking/domain/booking_repo.dart';
import 'package:ud_admin/domain/brand_repo.dart';
import 'package:ud_admin/domain/car_model_repo.dart';
import 'package:ud_admin/domain/cardata_model_repo.dart';
import 'package:ud_admin/domain/category_repo.dart';
import 'package:ud_admin/domain/customer_repo.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDRQV1JI6V_t4nnuiiNDWJGcwp2woc1-Pg",
            appId: "1:626820479065:web:ac34698727c8f2fe411948",
            messagingSenderId: "626820479065",
            storageBucket: "urban-drive-2a233.appspot.com",
            projectId: "urban-drive-2a233",
            authDomain: "urban-drive-2a233.firebaseapp.com",
            databaseURL: 'https://urban-drive-2a233-default-rtdb.firebaseio.com/'
            
            ));
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SlidebarBloc(),
        ),
        BlocProvider(create: (context) => CarscreenBloc(),),
        BlocProvider(create: (context) => UpdateDetailsBloc(CarModelRepo()),),
       
        BlocProvider(create: (context)=>CategoryBloc()),
          BlocProvider(
          create: (context) => CategorylistBloc(CategoryRepo()),
        ),

        BlocProvider(create: (context) => BrandLogoBloc(),),
        BlocProvider(create: (context) => BrandListBloc(BrandRepo()),),
        BlocProvider(create: (context) => CarModelListBloc(CarDataModelRepo()),),
        BlocProvider(create: (context) => CustomersListBloc(CustomersRepo()),),
        BlocProvider(create: (context) => BookingDataBloc(BookingRepo()),),
        BlocProvider(create: (context) => CarDetailsBloc(CarDetailsRepo()),),
        BlocProvider(create: (context) => CarDetailsListBloc(CarDetailsRepo()),),
        BlocProvider(create: (context) => DashCardBloc(DashBoardRepo()),),
        BlocProvider(create: (context) => ChatuserBloc(InboxRoomRepo()),),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false, home: AdminLoginScreen()),
    );
  }
}
