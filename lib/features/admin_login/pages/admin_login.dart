import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ud_admin/features/admin_login/widgets/email_form-filed.dart';

import 'package:ud_admin/pages/form_validator.dart';
import 'package:ud_admin/features/main_screen/pages/main_page.dart';

class AdminLoginScreen extends StatefulWidget {
  AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  late SharedPreferences pref;
  bool? isUser;
  bool isHidden = true;

  @override
  void initState() {
    isLoggedIn();
    super.initState();
  }

  isLoggedIn() async {
    pref = await SharedPreferences.getInstance();
    isUser = pref.getBool("login") ?? true;
    if (isUser == false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPageScreen()),
      );
    }
  }

  togglePassword() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 2 / 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(77, 126, 152, 233),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50),
                margin: EdgeInsets.symmetric(horizontal: 200, vertical: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    EmailTexformField(emailController: emailController),
                    SizedBox(height: 25),
                    Card(
                      elevation: 5,
                      child: TextFormField(
                        obscureText: isHidden,
                        cursorColor: Colors.black,
                        validator: (value) =>
                            FormValidator().validatePassword(value),
                        controller: passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.lock),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 79, 107, 158),
                            ),
                          ),
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 191, 191, 191),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: togglePassword,
                            child: Icon(isHidden
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          hintText: "Password",
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 79, 79, 79),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                   GestureDetector(
      onTap: () {
        String email = emailController.text;
        String password = passwordController.text;
    
        if (email == "admin@gmail.com" &&
            password == "123456") {
          pref.setBool("login", false);
          pref.setString("email", email);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPageScreen(),
            ),
            (route) => false,
          );
        }
      },
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 60,
          width: 300,
          child: Center(
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    )
                  ],
                ),
              ),
            ),
            Container(
              child: Image.asset(
                'lib/assets/images/splashscreen.jpg',
                fit: BoxFit.cover,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 1 / 3,
            )
          ],
        ),
      ),
    );
  }
}
