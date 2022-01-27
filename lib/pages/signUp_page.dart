// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, sized_box_for_whitespace, dead_code, prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:budget_x/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:email_validator/email_validator.dart';

class MySignUpPage extends StatefulWidget {
  @override
  MySignUpPageState createState() => MySignUpPageState();
}

class MySignUpPageState extends State<MySignUpPage> {
  var mykey = GlobalKey<FormState>();
  static var username = "";
  static var name = "";
  static var email = "";
  static var phoneNumber = "";
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  static var password_value = "";
  static var isValid;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Vx.hexToColor("#151B28"),
        body: Center(
          child: Container(
            height: 650,
            width: 330,
            decoration: BoxDecoration(
              color: Vx.hexToColor("#262E3D"),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Form(
                key: mykey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/logo.png",
                          height: 61,
                          width: 230,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 60,
                          child: Container(
                            height: 40,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Pls enter your name";
                                } else {
                                  name = value;
                                }
                              },
                              style: TextStyle(color: Colors.black),
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 10, left: 10),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Full Name",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          child: Container(
                            height: 40,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Pls enter your username";
                                } else {
                                  username = value;
                                }
                              },
                              style: TextStyle(color: Colors.black),
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 10, left: 10),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Username",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          child: Container(
                            height: 40,
                            child: TextFormField(
                              validator: (value) {
                                if (EmailValidator.validate(value!) == true) {
                                  email = value;
                                } else {
                                  return "Pls enter your email ID";
                                }
                              },
                              style: TextStyle(color: Colors.black),
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 10, left: 10),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Email ID",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Pls enter your phone number";
                              } else if (value.length != 10) {
                                return "Pls enter 10-digit number";
                              } else {
                                phoneNumber = value;
                              }
                            },
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(top: 10, left: 10),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Phone Number",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          child: TextFormField(
                            controller: password,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Pls enter the password";
                              } else if (value.length < 8) {
                                return "Pls enter 8 digit password";
                              } else {
                                password_value = value;
                              }
                            },
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(top: 10, left: 10),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          child: TextFormField(
                            scrollPadding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            controller: confirmPassword,
                            validator: (value) {
                              if (value != password.value.text) {
                                return "Pls enter same password";
                              }
                            },
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(top: 10, left: 10),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 40,
                          width: 350,
                          child: Material(
                            child: InkWell(
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (mykey.currentState?.validate() == true) {
                                    await Future.delayed(
                                        Duration(milliseconds: 900));
                                    await Navigator.pushNamed(
                                        context, MyRoute.loginRoute);
                                  }
                                },
                                child: Text(
                                  "Register",
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
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 55,
                            ),
                            Text(
                              "Already have an account?",
                              style: GoogleFonts.inter(fontSize: 11),
                            ),
                            InkWell(
                              onTap: () async {
                                await Future.delayed(
                                    Duration(milliseconds: 900));
                                await Navigator.pushNamed(
                                    context, MyRoute.loginRoute);
                              },
                              child: Text(
                                "Login",
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 200,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
