import 'package:flutter/material.dart';
import 'package:ud_admin/pages/form_validator.dart';



class EmailTexformField extends StatelessWidget {
  const EmailTexformField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Card(
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
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 18.0, right: 18),
            child: Icon(Icons.mail),
          ),
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
          hintText: "Email",
        ),
      ),
    );
  }
}
