// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:budget_x/theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({ Key? key }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: getBody(),
    );
  }

  Widget getBody(){

    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [

          //Upar ka
          Container(
            decoration: BoxDecoration(color: Colors.black, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.01), spreadRadius: 10, blurRadius: 3)]),
            padding: const EdgeInsets.only(top: 60, bottom: 25, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Dashboard', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                Icon(Icons.notifications, color: Colors.white,)
              ]
            )
          ),

          const SizedBox(height: 20),

          //first box
          Container(
            width: size.width - 45, height: 100,
            decoration: BoxDecoration(color: const Color(0xFF262E3D), borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.01), spreadRadius: 10, blurRadius: 3)]),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(    
                    crossAxisAlignment: CrossAxisAlignment.start,    
                    children: [
                      const Text('Total Balance', style: TextStyle( color: Color(0xFFC4C4C4), fontSize: 18, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 5),
                      const Text('6900 INR', style: TextStyle( color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Icon(Icons.space_dashboard, size: 90,),
                  ),
                ],
              ),
            )
          ),
          
          const SizedBox(height: 20),

          //the 2 small box things
           Wrap(
            spacing: 20,
            children: List.generate(2, (index) {
              return Container(
                width: (size.width - 55) /2,
                height: 170,
                decoration: BoxDecoration( color: const Color(0xFF0262E3D), borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.01), spreadRadius: 10, blurRadius: 3)]),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start , mainAxisAlignment: MainAxisAlignment.spaceBetween,  children: [
                      const Icon(
                        Icons.wallet_travel_outlined,
                        size:60,
                      ),

                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Cash', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.red.withOpacity(0.5), fontSize: 13)),
                        const SizedBox(height: 2),
                        const Text('1600 INR', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 20)),
                    ],)
                  ],),
                ),
              );
            }),),

            const SizedBox(height: 20),

          Column(
            children: List.generate( 2, (index) {
              return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Container(
                      width: size.width - 45,
                      height: 250,
                      decoration: BoxDecoration(color: const Color(0xFF262E3D), borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.01), spreadRadius: 10, blurRadius: 3)]),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: 
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Latest Transactions", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22)),
                                        const Icon(CupertinoIcons.location)
                                      ],
                                    ),
                      
                                    Divider(color: Colors.white.withOpacity(0.5)),
                                    const SizedBox(height: 10),
                      
                                    Column(
                                      children: List.generate(3, (index){
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: (size.width-70),
                                                  //decoration: BoxDecoration(color: Colors.green),
                                                  child: Row(
                                                    children: [
                                                      Container( 
                                                        width: 50, height: 50,
                                                        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), shape: BoxShape.circle),
                                                        child: const Center( child: Icon(Icons.home))
                                                      ),
                                                      const SizedBox( width: 15),
                                                      Container(
                                                        width: (size.width - 90) * 0.5,
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const Text("lol", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                                                            const SizedBox(height: 5),
                                                            const Text('6/9/69', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w200), )
                                                          ],
                                                        )
                                                      ),
                                                     const Text('-420 INR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red)),
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
            })
          ),
        ],
      )
    );
  }
}