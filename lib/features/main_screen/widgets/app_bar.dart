import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ud_admin/features/admin_login/pages/admin_login.dart';




class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    required this.username,
    required this.pref,
  });

  final String? username;
  final SharedPreferences? pref;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 219, 231, 249),
      title: Text(
        "URBAN DRIVE",
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
                builder: (context) => AdminLoginScreen(),
              ),
            );
          },
          icon: Icon(Icons.person),
        )
      ],
    );
  }
}
