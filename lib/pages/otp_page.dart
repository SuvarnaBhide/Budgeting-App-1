// ignore_for_file: unused_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names, avoid_returning_null_for_void, use_key_in_widget_constructors

import 'package:budget_x/pages/phone_login_page.dart';
import 'package:budget_x/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MyOTPPage extends StatefulWidget {
  @override
  MyOTPPageState createState() => MyOTPPageState();
}

class MyOTPPageState extends State<MyOTPPage> {
  var mykey = GlobalKey<FormState>();
  String otp = "123456";
  bool otp_check = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Vx.hexToColor("#151B28"),
        body: Center(
          child: Container(
            height: 440,
            width: 330,
            decoration: BoxDecoration(
              color: Vx.hexToColor("#262E3D"),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Text(
                  "OTP Verification",
                  style: GoogleFonts.inter(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Verification code sent to",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                  ),
                ),
                Text(
                  "+91 ${phoneLoginState.number}",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: mykey,
                  child: Container(
                    height: 60,
                    width: 150,
                    child: Container(
                      height: 40,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Pls enter the OTP";
                          } else if (value == otp) {
                            otp_check = true;
                          } else if (value != otp) {
                            return "Pls enter correct OTP";
                          }
                        },
                        obscureText: true,
                        textAlign: TextAlign.center,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 10),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "OTP",
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
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 150,
                  child: InkWell(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (mykey.currentState?.validate() == true &&
                            otp_check == true) {
                          if (mykey.currentState?.validate() == true) {
                            await Future.delayed(Duration(milliseconds: 900));
                            await Navigator.pushNamed(
                                context, MyRoute.mainRoute);
                          }
                        }
                      },
                      child: Text(
                        "Verify",
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
                Text(
                  "1:30",
                  style: GoogleFonts.inter(fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Didn’t recieve the code?",
                      style: GoogleFonts.inter(fontSize: 11),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Click to Resend",
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
