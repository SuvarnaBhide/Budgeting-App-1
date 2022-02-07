// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyDrawer());
}

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                "Records",
                style: GoogleFonts.inter(fontSize: 20),
              ),
              leading: Icon(Icons.list),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(
                "Planned Payments",
                style: GoogleFonts.inter(fontSize: 20),
              ),
              leading: Icon(Icons.payment),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(
                "Debts",
                style: GoogleFonts.inter(fontSize: 20),
              ),
              leading: Icon(Icons.money),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(
                "Settings",
                style: GoogleFonts.inter(fontSize: 20),
              ),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(
                "Rate Us",
                style: GoogleFonts.inter(fontSize: 20),
              ),
              leading: Icon(Icons.favorite),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(
                "Invite Friends",
                style: GoogleFonts.inter(fontSize: 20),
              ),
              leading: Icon(Icons.share),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(
                "Help",
                style: GoogleFonts.inter(fontSize: 20),
              ),
              leading: Icon(Icons.help),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
