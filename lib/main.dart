import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_admin/application/brandScreen/brand_list_bloc/brand_list_bloc.dart';
import 'package:ud_admin/application/brandScreen/brand_logo/brand_logo_bloc.dart';
import 'package:ud_admin/application/carModelScreen/car_model_list_bloc/car_model_list_bloc.dart';
import 'package:ud_admin/application/carModelScreen/update_details_bloc/update_details_bloc.dart';
import 'package:ud_admin/application/carModelScreen/model_image_bloc/carscreen_bloc.dart';


import 'package:ud_admin/application/categoryScreen/category_image_bloc/category_bloc.dart';
import 'package:ud_admin/application/categoryScreen/category_list_bloc/categorylist_bloc.dart';
import 'package:ud_admin/application/customersScreen/bloc/customers_list_bloc.dart';


import 'package:ud_admin/application/slidebar/bloc/slidebar_bloc.dart';
import 'package:ud_admin/domain/brand_repo.dart';
import 'package:ud_admin/domain/car_model_repo.dart';
import 'package:ud_admin/domain/cardata_model_repo.dart';
import 'package:ud_admin/domain/category_repo.dart';
import 'package:ud_admin/domain/customer_repo.dart';
import 'package:ud_admin/pages/admin_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDRQV1JI6V_t4nnuiiNDWJGcwp2woc1-Pg",
            appId: "1:626820479065:web:ac34698727c8f2fe411948",
            messagingSenderId: "626820479065",
            storageBucket: "urban-drive-2a233.appspot.com",
            projectId: "urban-drive-2a233"));
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
        BlocProvider(create: (context) => CustomersListBloc(CustomersRepo()),)
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false, home: AdminLoginScreen()),
    );
  }
}
