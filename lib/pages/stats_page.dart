// ignore_for_file: prefer_const_constructors

import 'package:budget_x/json/stats_json.dart';
import 'package:budget_x/theme/color.dart';
import 'package:budget_x/utils/routes.dart';
import 'package:budget_x/widgets/chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({ Key? key }) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stats")),
      backgroundColor: backgroundColor,
      body: getBody(),
      drawer: Drawer(),
    );
  }

  Widget getBody(){
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  spreadRadius: 10,
                  blurRadius: 3
                )
              ]
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25, right: 20, left: 20),
              child: Column(children: [
                TableCalendar(
                  focusedDay: DateTime.now(),
                  firstDay: DateTime(1990),
                  lastDay: DateTime(2050),
                  calendarFormat: CalendarFormat.week,
                  startingDayOfWeek: StartingDayOfWeek.monday,

                  calendarStyle: CalendarStyle(
                    todayDecoration: const BoxDecoration(color: orange, shape: BoxShape.circle),
                    todayTextStyle: const TextStyle(color: white, fontWeight: FontWeight.bold)
                    
                  ),
                ),
              ],)
            )
          ),
          SizedBox(height: 20),
          Column(
            children: List.generate(statsTypes.length, (index){
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: InkWell(
                  onTap: () async {
                    await Future.delayed(
                      Duration(milliseconds: 900));
                      await Navigator.pushNamed(
                        context, MyRoute.detailedStatsRoute , arguments: {statsTypes[index]['statsType'], statsTypes[index]['amount']});
                    //DetailedStats(statsType: statsTypes[index]['statsType'], amount: statsTypes[index]['amount'],);
                  },
                  child: Container(
                    width: size.width - 30,
                    height: statsTypes[index]['statsType'] == 'Current Budget' ? 120:100,
                    decoration: BoxDecoration(color: boxColor, borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(statsTypes[index]['statsType'], style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Color(0xFFC2C2C2))),
                          SizedBox(height: 5),
                          statsTypes[index]['statsType'] == 'Current Budget' ?

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(statsTypes[index]['amount'], style: TextStyle(color: white, fontSize: 20, fontWeight: FontWeight.bold)),
                                Text("80%", style: TextStyle(color: white.withOpacity(0.8), fontSize: 15,)),
                              ],
                            )
                            : Text(statsTypes[index]['amount'], style: TextStyle(color: white, fontSize: 30, fontWeight: FontWeight.bold)),
                          statsTypes[index]['statsType'] == 'Current Budget' ? getWidget() : SizedBox(height: 0),
                        ])
                    )
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget getWidget(){
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: 15,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Stack(children: [
          Container(
            width: size.width - 40, height: 6,
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
          ),
          Container(
            width: (size.width - 20) * 0.8, height: 6,
            decoration: BoxDecoration(color: orange, borderRadius: BorderRadius.circular(5)),
          )
        ],),
      )
    );
  }
}

class DetailedStats extends StatefulWidget {
  const DetailedStats({ Key? key , required this.statsType, required this.amount}) : super(key: key);
  final String statsType;
  final String amount;
  @override
  _DetailedStatsState createState() => _DetailedStatsState();
}

class _DetailedStatsState extends State<DetailedStats> {
  @override
  Widget build(BuildContext context) {

    //final arguments = ModalRoute.of(context)?.settings.arguments as Map<dynamic, String>;
    const String statsType = /*arguments['statsType'];*/ "Balance";
    const String amount = /*arguments['amount'];*/ "\$5,000";
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      backgroundColor: backgroundColor,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //Calendar
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.01),
                    spreadRadius: 10,
                    blurRadius: 3
                )
              ]
            ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: TableCalendar(
                  focusedDay: DateTime.now(),
                  firstDay: DateTime(1990),
                  lastDay: DateTime(2050),
                  calendarFormat: CalendarFormat.week,
                  startingDayOfWeek: StartingDayOfWeek.monday,

                  calendarStyle: CalendarStyle(
                    todayDecoration: const BoxDecoration(color: orange, shape: BoxShape.circle),
                    todayTextStyle: const TextStyle(color: white, fontWeight: FontWeight.bold)
                        
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            //Balance trends graph
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                  width: double.infinity,
                  height: 350,
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
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Balance Trends", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFFC4C4C4))),
                          SizedBox(height: 5),
                          Text('TODAY', style: TextStyle(color: white.withOpacity(0.6), fontWeight: FontWeight.w500, fontSize: 12)),
                          SizedBox(height: 5,),
                          Text("\$5,000", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: white)),
                        ],
                      ),
                    ),
                    Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: size.width - 20,
                      height: 200,
                      child: LineChart(
                        mainData()
                      )
                    ),
                  )
                    ]),
                )
              )
            ),

            SizedBox(height: 20,),

            //Sab accounts ka milakar
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                  width: double.infinity,
                  height: 200,
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
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Accounts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFFC4C4C4))),
                          SizedBox(height: 5),
                          Text('TODAY', style: TextStyle(color: white.withOpacity(0.6), fontWeight: FontWeight.w500, fontSize: 12)),
                          SizedBox(height: 5,),
                          Text("\$2,000", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: white)),
                        ],
                      ),
                    ),
                    Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: size.width - 60,
                      height: 92,
                      child: Column(
                        children: List.generate(2, (index){
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('Cash', style: TextStyle(fontSize: 12, color: white, fontWeight: FontWeight.w400),),
                                    Text('\$2000', style: TextStyle(fontSize: 12, color: white, fontWeight: FontWeight.w400),)
                                  ],
                                )
                              ),
                            ),
                          );
                        }),
                      )
                      )
                    ),
                    ]),
                )
              )
            ),

          ],
        ),
      )
    );
  }
}