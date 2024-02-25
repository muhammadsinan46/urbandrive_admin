import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ud_admin/application/addcar/bloc/addcarmenu_bloc.dart';
import 'package:ud_admin/application/slidebar/bloc/slidebar_bloc.dart';
import 'package:ud_admin/pages/admin_login.dart';
import 'package:ud_admin/pages/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
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
        BlocProvider(
          create: (context) => AddcarmenuBloc(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false, home: AdminLoginScreen()),
    );
  }
}
