// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, sized_box_for_whitespace, non_constant_identifier_names
import 'package:budget_x/database/expenses_database.dart';
import 'package:budget_x/json/create_expense_json.dart';
import 'package:budget_x/json/dashboard_json.dart';
import 'package:budget_x/models/expense_model.dart';
import 'package:budget_x/pages/root_app.dart';
import 'package:budget_x/pages/drawer.dart';
import 'package:budget_x/theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late List<Expense> expenses;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshExpenses();
  }

  Future refreshExpenses() async {
    setState(() => isLoading = true);
    expenses = await ExpensesDatabase.instance.readAllExpenses();
    refreshBalance(expenses);
    setState(() => isLoading = false);
  }

  void refreshBalance(List<Expense> expenses) {
    num totalBalance = 0;
    for (Expense expense in expenses) {
      expense.isExpense
          ? totalBalance -= expense.amount
          : totalBalance += expense.amount;
    }
    Expense.balance = totalBalance;
    print('Total Balance: ${Expense.balance}');
  }

  @override
  void dispose() {
    ExpensesDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Icon(Icons.notifications),
          )
        ],
      ),
      body: getBody(),
      drawer: Drawer(
        child: MyDrawer(),
      ),
    );
  }

  Widget getBody() {
    int index1 = 0, index2 = 0;
    int index = expenses.length;
    var time;
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
                      Text(Expense.balance.toString(),
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
              child: index == 0
                  ? Padding(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 20, left: 15),
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
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 20, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {},
                              child: Text('Adjust Balance',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800))),
                          Divider(color: Colors.grey),
                          InkWell(
                              onTap: () {},
                              child: Text('Add Account',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800))),
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
                            Text(
                                Index == 0
                                    ? "Latest Transactions"
                                    : "Top expenses",
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
                            children: index > 3
                                ? List.generate(3, (oldIndex) {
                                    setState(() {
                                      if (index < expenses.length - 2) {
                                        index = expenses.length;
                                      }
                                      index--;
                                      for (int i = 0;
                                          i < categoryTypes.length - 1;
                                          i++) {
                                        if (categoryTypes[i]['category'] ==
                                            expenses[index].category) {
                                          index1 = i;
                                        }
                                      }
                                      for (int j = 0;
                                          j < categoryTypes.length - 1;
                                          j++) {
                                        if (categoryTypes1[j]['category'] ==
                                            expenses[index].category) {
                                          index2 = j;
                                        }
                                      }
                                      time = DateFormat.yMMMd()
                                          .format(expenses[index].time);
                                    });
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
                                                          color: expenses[index]
                                                                  .isExpense
                                                              ? categoryTypes[
                                                                      index1]
                                                                  ['color']
                                                              : categoryTypes1[
                                                                      index2]
                                                                  ['color'],
                                                          shape:
                                                              BoxShape.circle),
                                                      child: Center(
                                                        child: expenses[index]
                                                                .isExpense
                                                            ? categoryTypes[
                                                                index1]['icon']
                                                            : categoryTypes1[
                                                                index2]['icon'],
                                                      )),
                                                  const SizedBox(width: 15),
                                                  Container(
                                                      width: (size.width - 90) *
                                                          0.5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              expenses[index]
                                                                      .isExpense
                                                                  ? categoryTypes[
                                                                          index1]
                                                                      [
                                                                      'category']
                                                                  : categoryTypes1[
                                                                          index2]
                                                                      [
                                                                      'category'],
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          const SizedBox(
                                                              height: 5),
                                                          Index == 0
                                                              ? Text(
                                                                  time,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w200),
                                                                )
                                                              : Container()
                                                        ],
                                                      )),
                                                  Text(
                                                      Index == 0
                                                          ? expenses[index]
                                                                  .isExpense
                                                              ? '-' +
                                                                  expenses[
                                                                          index]
                                                                      .amount
                                                                      .toString()
                                                              : '+' +
                                                                  expenses[
                                                                          index]
                                                                      .amount
                                                                      .toString()
                                                          : expenses[index]
                                                              .amount
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Index == 0
                                                              ? expenses[index]
                                                                      .isExpense
                                                                  ? Colors.red
                                                                  : Colors.green
                                                              : Colors.grey)),
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
                                  })
                                : [
                                    Center(
                                        child: Text(
                                      "Add more than 3 transactions",
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600),
                                    ))
                                  ]),
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
