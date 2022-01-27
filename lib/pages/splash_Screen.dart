// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, file_names

import 'package:budget_x/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';

class MySplashScreen extends StatefulWidget {
  @override
  MySplashScreenState createState() => MySplashScreenState();
}

class MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/splash_screen.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            child: Padding(
              padding: EdgeInsets.only(top: 580),
              child: Column(
                children: [
                  Text(
                    "Welcome to BudgetX",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 23,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: Material(
                      child: InkWell(
                        child: ElevatedButton(
                          onPressed: () async {
                            await Future.delayed(Duration(milliseconds: 450));
                            await Navigator.pushNamed(
                                context, MyRoute.loginRoute);
                          },
                          child: Text(
                            "Get Started",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Vx.hexToColor("#FF6600"),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 65,
                      ),
                      Text(
                        "Privacy Policy",
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.circle,
                        size: 7,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "TOS",
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.circle,
                        size: 7,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Content Policy",
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
