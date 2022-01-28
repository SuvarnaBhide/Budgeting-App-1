// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, prefer_typing_uninitialized_variables, camel_case_types, unused_local_variable

import 'package:budget_x/pages/login_page.dart';
import 'package:budget_x/pages/signUp_page.dart';
import 'package:budget_x/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:budget_x/pages/root_app.dart';

class passwordPage extends StatefulWidget {
  const passwordPage({Key? key}) : super(key: key);

  @override
  passwordPageState createState() => passwordPageState();
}

class passwordPageState extends State<passwordPage> {
  var key = GlobalKey<FormState>();
  var new_password = TextEditingController();
  var confirm_Password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: key,
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                TextFormField(
                  obscureText: true,
                  controller: new_password,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Pls enter the password";
                    }
                    if (value.length < 8) {
                      return "Pls enter 8 digit password";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "New Password",
                    labelText: "New Password",
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  controller: confirm_Password,
                  validator: (value) {
                    if (new_password.value.text !=
                            confirm_Password.value.text &&
                        new_password.value.text.length >= 8) {
                      return "Pls enter same password";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    labelText: "Confirm Password",
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 200,
                  child: InkWell(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (key.currentState!.validate()) {
                          RootAppState.pageIndex = 3;
                          await Future.delayed(Duration(milliseconds: 900));
                          await Navigator.pushNamed(
                              context, MyRoute.profileRoute);
                          MySignUpPageState.password_value =
                              confirm_Password.value.text;
                          MyLoginPageState.password =
                              confirm_Password.value.text;
                        }
                      },
                      child: Text(
                        "Save",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Vx.hexToColor("#FF6600"),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  child: InkWell(
                    child: ElevatedButton(
                      onPressed: () async {
                        RootAppState.pageIndex = 3;
                        await Future.delayed(Duration(milliseconds: 900));
                        await Navigator.pushNamed(
                            context, MyRoute.profileRoute);
                      },
                      child: Text(
                        "Back",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Vx.hexToColor("#FF6600"),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
