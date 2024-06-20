// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:budget_x/database/expenses_database.dart';
import 'package:budget_x/json/stats_json.dart';
import 'package:budget_x/models/category_model.dart';
import 'package:budget_x/models/expense_model.dart';
import 'package:budget_x/pages/drawer.dart';
import 'package:budget_x/theme/color.dart';
import 'package:budget_x/utils/routes.dart';
import 'package:budget_x/widgets/chart.dart';
import 'package:fl_chart/fl_chart.dart' as prefix;
import 'package:flutter/material.dart' hide MonthPicker;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:velocity_x/velocity_x.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {

  late List<Expense> expenses;
  bool isLoading = false;
  DateTime result = DateTime.now();
  num totalBalance = 0;
  Map<String, double> dataMap = {
    "Food & Drinks": 5,
    "Healthcare": 8,//Category.healthcareAmountSpent.toDouble(),
    "Gifts": 7,
    "Education": 9,//Category.educationAmountSpent.toDouble(),
    "Other": 20// Category.totalAmountSpent.toDouble()
  };

  @override
  void initState() {
    super.initState();
    refreshExpenses();
  }

  @override
  void dispose() {
    ExpensesDatabase.instance.close();
    super.dispose();
  }

  Future refreshExpenses() async {
    setState(()=> isLoading = true);
    expenses = await ExpensesDatabase.instance.readAllExpenses();
    setState(()=> isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stats"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: InkWell(
                child: ElevatedButton(
                  onPressed: () async {
                    final sometime = await Navigator.push(context, MaterialPageRoute(builder: (context) => PopUpDialog()));
                    ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(content: Text(DateFormat.yMMM().format(sometime))));
                    setState(() {
                      result = sometime;
                      num spent = 0, income = 0;
                      totalBalance = 0;
                      var newdate = DateTime(result.year, result.month+1, result.day);
                      for(int i=0; i<expenses.length; i++){
                        if(expenses[i].time.compareTo(result) >= 0 && expenses[i].time.compareTo(newdate) < 0){
                          if(expenses[i].isExpense == true){
                            spent -= expenses[i].amount;
                            totalBalance -= expenses[i].amount;
                          } else {
                            income += expenses[i].amount;
                            totalBalance += expenses[i].amount;
                          }
                        }
                      }
                      Expense.totalExpense = spent; Expense.totalIncome = income;
                    });
                  },
                  child: Text(DateFormat.yMMM().format(result),style: GoogleFonts.inter(fontWeight: FontWeight.bold,fontSize: 15, color: black)),
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
          )
        ],
      ),
      backgroundColor: backgroundColor,
      body: getBody(),
      drawer: Drawer(
        child: MyDrawer(),
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
            Column(
              children: List.generate(statsTypes.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: InkWell(
                    onTap: () async {
                      await Future.delayed(Duration(milliseconds: 900));
                      await Navigator.pushNamed(
                          context, MyRoute.detailedStatsRoute, arguments: {
                        statsTypes[index]['statsType'],
                        statsTypes[index]['amount']
                      });
                      //DetailedStats(statsType: statsTypes[index]['statsType'], amount: statsTypes[index]['amount'],);
                    },
                    child: Container(
                        width: size.width - 30,
                        height: statsTypes[index]['statsType'] == 'Current Budget' || statsTypes[index]['statsType'] == 'Cash Flow'
                            ? 120
                            : 100,
                        decoration: BoxDecoration(
                            color: boxColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(statsTypes[index]['statsType'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                          color: Color(0xFFC2C2C2))),
                                  SizedBox(height: 5),
                                  statsTypes[index]['statsType'] ==
                                          'Current Budget'
                                      ? getWidget()
                                      : statsTypes[index]['statsType'] ==
                                          'Cash Flow' ? Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                              Text('Amount spent' ,style: TextStyle(color:Colors.red,fontSize: 15)),
                                              Text('Amount earnt' ,style: TextStyle(color: Colors.green,fontSize: 15)),
                                        ],
                                      ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                              Text(Expense.totalExpense.toString() ,style: TextStyle(color:Colors.red,fontSize: 30,fontWeight: FontWeight.bold)),
                                              Text('+' + Expense.totalIncome.toString() ,style: TextStyle(color: Colors.green,fontSize: 30,fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                            ],
                                          ) : Text(totalBalance.toString(),
                                          style: TextStyle(
                                              color: white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)),
                                ]))),
                  ),
                );
              }),
            ),
            ChartContainer(
              title: 'Category wise expense distribution', 
              color: Colors.transparent, 
              chart: PieChartContent()
            ),
          ],
        ),
      ),
    );
  }

  Widget getWidget() {
    var size = MediaQuery.of(context).size;

    return SizedBox(
        height: 40,
        child: Column(
          children: [
            Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('\$' + Category.totalAmountSpent.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: orange)),
                                const SizedBox(width: 8),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Text(((Category.totalAmountSpent/Category.totalAmountSet)*100).toStringAsFixed(2) + '%', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.grey)),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text('\$' + Category.totalAmountSet.toString(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.grey)),
                            )
                          ],
                        ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Stack(
                children: [
                  Container(
                    width: size.width - 40,
                    height: 6,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  Container(
                    width: (size.width - 20) * ((Category.totalAmountSpent/Category.totalAmountSet)*100),
                    height: 6,
                    decoration: BoxDecoration(
                        color: orange, borderRadius: BorderRadius.circular(5)),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class DetailedStats extends StatefulWidget {
  const DetailedStats({Key? key, required this.statsType, required this.amount})
      : super(key: key);
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
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Calendar
              Container(
                decoration: BoxDecoration(color: Colors.black, boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3)
                ]),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: DateTime(1990),
                    lastDay: DateTime(2050),
                    calendarFormat: CalendarFormat.week,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarStyle: CalendarStyle(
                        todayDecoration: const BoxDecoration(
                            color: orange, shape: BoxShape.circle),
                        todayTextStyle: const TextStyle(
                            color: white, fontWeight: FontWeight.bold)),
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
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Balance Trends",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFFC4C4C4))),
                                SizedBox(height: 5),
                                Text('TODAY',
                                    style: TextStyle(
                                        color: white.withOpacity(0.6),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("\$5,000",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: white)),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: SizedBox(
                                width: size.width - 20,
                                height: 200,
                                child: prefix.LineChart(mainData())),
                          )
                        ]),
                      ))),

              SizedBox(
                height: 20,
              ),

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
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Accounts",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFFC4C4C4))),
                                SizedBox(height: 5),
                                Text('TODAY',
                                    style: TextStyle(
                                        color: white.withOpacity(0.6),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("\$2,000",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: white)),
                              ],
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              child: SizedBox(
                                  width: size.width - 60,
                                  height: 92,
                                  child: Column(
                                    children: List.generate(2, (index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: const [
                                                  Text(
                                                    'Cash',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: white,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    '\$2000',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: white,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ],
                                              )),
                                        ),
                                      );
                                    }),
                                  ))),
                        ]),
                      ))),
            ],
          ),
        ));
  }
}

class PopUpDialog extends StatefulWidget {
  const PopUpDialog({ Key? key }) : super(key: key);

  @override
  State<PopUpDialog> createState() => _PopUpDialogState();
}

class _PopUpDialogState extends State<PopUpDialog> {

  DateTime selectedMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text('Select Month'),
      content: Column(
        children: [
          MonthPicker.single(
              firstDate: DateTime(1990),
              lastDate: DateTime(2050),
              onChanged: (mySelection){
                setState(() {
                  selectedMonth = mySelection;
                  print('selected month: $selectedMonth');
                  
                });     
              },
              selectedDate: selectedMonth,
              datePickerStyles: DatePickerStyles(
                selectedSingleDateDecoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(15)
                ) 
              )
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){
                Navigator.pop(context, selectedMonth);
              }, 
              child: Text("Save")
            ),
          )
        ],
      ),
    );
  }
}

class ChartContainer extends StatelessWidget {
  final Color color;
  final String title;
  final Widget chart;

  const ChartContainer({
    Key? key,
    required this.title,
    required this.color,
    required this.chart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.width * 0.95 * 0.65,
        padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(top: 10),
              child: chart,
            ))
          ],
        ),
      ),
    );
  }
}
class PieChartContent extends StatefulWidget {
  @override
  State<PieChartContent> createState() => _PieChartContentState();
}

class _PieChartContentState extends State<PieChartContent> {
  @override
  Widget build(BuildContext context) {
    return prefix.PieChart(
      prefix.PieChartData(
        sections: getSectionData(MediaQuery.of(context).size.width),
        centerSpaceRadius: 0,
        sectionsSpace: 0
      ),
    );
  }
}

List<prefix.PieChartSectionData> getSectionData(double screenWidth) {
  double radius = screenWidth / 4.44;

  return [
    prefix.PieChartSectionData(
      value: ((Category.foodAndDrinksAmountSpent/Category.totalAmountSet)*100).toDouble(),
      title: ((Category.foodAndDrinksAmountSpent/Category.totalAmountSet)*100).toStringAsFixed(2),
      radius: radius,
      color: Colors.orange,
    ),
    prefix.PieChartSectionData(
      value: ((Category.healthcareAmountSpent/Category.totalAmountSet)*100).toDouble(),
      title: ((Category.healthcareAmountSpent/Category.totalAmountSet)*100).toStringAsFixed(2),
      radius: radius,
      color: Colors.green,
    ),
    prefix.PieChartSectionData(
      value: ((Category.foodAndDrinksAmountSpent/Category.totalAmountSet)*100).toDouble(),
      title: ((Category.foodAndDrinksAmountSpent/Category.totalAmountSet)*100).toStringAsFixed(2),
      radius: radius,
      color: Colors.red,
    ),
    prefix.PieChartSectionData(
      value: ((Category.educationAmountSpent/Category.totalAmountSet)*100).toDouble(),
      title: ((Category.educationAmountSpent/Category.totalAmountSet)*100).toStringAsFixed(2),
      radius: radius,
      color: Colors.blue,
    ),
    prefix.PieChartSectionData(
      value: ((Category.otherAmountSpent/Category.totalAmountSet)*100).toDouble(),
      title: ((Category.otherAmountSpent/Category.totalAmountSet)*100).toStringAsFixed(2),
      radius: radius,
      color: Colors.grey,
    ),
  ];
}