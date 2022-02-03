// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, sized_box_for_whitespace, non_constant_identifier_names
import 'package:budget_x/json/dashboard_json.dart';
import 'package:budget_x/theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  int newindex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        actions: [Icon(Icons.notifications)],
      ),
      body: getBody(),
      drawer: Drawer(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
        child: Column(
      children: [
        //Upar ka
        const SizedBox(height: 20),

        //first box
        Container(
            width: size.width - 45,
            height: 100,
            decoration: BoxDecoration(
                color: const Color(0xFF262E3D),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3)
                ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, top: 15, right: 15, bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total Balance',
                          style: TextStyle(
                              color: Color(0xFFC4C4C4),
                              fontSize: 18,
                              fontWeight: FontWeight.w800)),
                      const SizedBox(height: 5),
                      const Text('6900 INR',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Icon(
                      CupertinoIcons.money_dollar_circle,
                      color: Colors.orangeAccent,
                      size: 70,
                    ),
                  ),
                ],
              ),
            )),

        const SizedBox(height: 20),

        //the 2 small box things
        Wrap(
          spacing: 20,
          children: List.generate(2, (index) {
            return Container(
              width: (size.width - 55) / 2,
              height: 170,
              decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.01),
                        spreadRadius: 10,
                        blurRadius: 3)
                  ]),
              child: index == 0 ? Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      CupertinoIcons.money_dollar_circle,
                      color: Colors.green,
                      size: 70,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cash',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 13)),
                        const SizedBox(height: 2),
                        const Text('1600 INR',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20)),
                      ],
                    )
                  ],
                ),
              ) : Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(onTap: (){} ,child: Text('Adjust Balance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800))),
                    Divider(color: Colors.grey),
                    InkWell(onTap: (){}, child: Text('Add Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800))),
                  ],
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 20),

        Column(
            children: List.generate(2, (Index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Container(
              width: size.width - 45,
              height: 250,
              decoration: BoxDecoration(
                  color: const Color(0xFF262E3D),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.01),
                        spreadRadius: 10,
                        blurRadius: 3)
                  ]),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text( Index == 0 ? "Latest Transactions" : "Top expenses",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 22)),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        ),
                        Divider(color: Colors.white.withOpacity(0.5)),
                        const SizedBox(height: 10),
                        Column(
                          children: List.generate(items.length, (index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: (size.width - 70),
                                      //decoration: BoxDecoration(color: Colors.green),
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: items[index]['color'],
                                                  shape: BoxShape.circle),
                                              child: Center(
                                                  child: items[index]['icon'])),
                                          const SizedBox(width: 15),
                                          Container(
                                              width: (size.width - 90) * 0.5,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(items[index]['title'],
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  const SizedBox(height: 5),
                                                  Index == 0? Text(
                                                    items[index]['date'],
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w200),
                                                  ) : Container()
                                                ],
                                              )),
                                          Text(Index == 0 ? '-' + items[index]['amount'] : items[index]['amount'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Index == 0 ? Colors.red : Colors.grey)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                )
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        })),
      ],
    ));
  }
}
