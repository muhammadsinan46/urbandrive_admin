import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ud_admin/pages/form_validator.dart';
import 'package:ud_admin/pages/main_page.dart';

class AdminLoginScreen extends StatefulWidget {
  AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  late SharedPreferences pref;
  bool? isUser;
  final formKey = GlobalKey<FormState>();

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
          context, MaterialPageRoute(builder: (context) => MainPageScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width * 2 / 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(77, 126, 152, 233),
                ),
                padding: EdgeInsets.only(
                  left: 50,
                  right: 50,
                ),
                margin: EdgeInsets.only(
                    left: 200, right: 200, top: 100, bottom: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: TextFormField(
                        cursorColor: Colors.black,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            FormValidator().validateEmail(value),
                        controller: emailController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIconColor:
                                const Color.fromARGB(255, 191, 191, 191),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 18.0, right: 18),
                              child: Icon(Icons.mail),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              // borderRadius: BorderRadius.circular(30)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 79, 107, 158)),
                              //  borderRadius: BorderRadius.circular(30)
                            ),
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 191, 191, 191),
                            ),
                            hintText: "Email"),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Card(
                      elevation: 5,
                      child: TextFormField(
                        cursorColor: Colors.black,
                        validator: (value) =>
                            FormValidator().validatePassword(value),
                        controller: passwordController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIconColor:
                                const Color.fromARGB(255, 191, 191, 191),
                            prefixIcon: const Icon(Icons.lock),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              // borderRadius: BorderRadius.circular(30)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 79, 107, 158)),
                              // borderRadius: BorderRadius.circular(30)
                            ),
                            hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 191, 191, 191),
                            ),
                            hintText: "Password"),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 280),
                        child: TextButton(
                            onPressed: () {
                              //  userauth.forgotPassword(emailController.text);
                            },
                            child: const Text(
                              "Forgot Password?",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ))),
                    GestureDetector(
                      onTap: () {
                        String email = emailController.text;
                        String password = passwordController.text;

                        if (email == "admin@gmail.com" &&
                            password == "123456") {
                          pref.setBool("login", false);
                          pref.setString("email", email);
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainPageScreen()), (route) => false);

                        }

 
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        height: 45,
                        width: 120,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              // decoration: BoxDecoration(image: AssetImage('lib\assets\images\adminwall.jpg')),
              child: Image.asset(
                'lib/assets/images/splashscreen.jpg',
                fit: BoxFit.cover,
              ),
              //  color: Colors.blue,
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width * 1 / 3,
            )
          ],
        ),
      ),
    );
  }
}
