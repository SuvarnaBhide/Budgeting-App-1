// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:budget_x/database/expenses_database.dart';
import 'package:budget_x/models/expense_model.dart';
import 'package:budget_x/pages/budget_page.dart';
import 'package:budget_x/pages/profile_page.dart';
import 'package:flutter/material.dart';

import 'package:budget_x/pages/dashboard_page.dart';
import 'package:budget_x/theme/color.dart';

import 'create_expense_page.dart';
import 'expenses_page.dart';
import 'stats_page.dart';

void main() {
  runApp(MaterialApp(
    home: RootApp(),
  ));
}

class RootApp extends StatefulWidget {
  @override
  RootAppState createState() => RootAppState();
}

class RootAppState extends State<RootApp> {

  static int pageIndex = 0;
  late List<Expense> expenses;
  bool isLoading = false;

  List<Widget> pages = [
    const DashboardPage(),
    const StatsPage(),
    /*const Center(child: Text('BUDGET')),*/ BudgetPage(),
    MyProfilePage(),
    const CreateExpense(),
  ];

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  void dispose() {
    ExpensesDatabase.instance.close();
    super.dispose();
  }

  Future refresh() async {
    setState(()=> isLoading = true);
    expenses = await ExpensesDatabase.instance.readAllExpenses();
    refreshBalance(expenses);
    setState(()=> isLoading = false);
  }

  void refreshBalance(List<Expense> expenses){
    
    num totalBalance = 0;
    for(Expense expense in expenses){
      expense.isExpense ? totalBalance -= expense.amount : totalBalance += expense.amount;
    }
    Expense.balance = totalBalance;
    print('Total Balance: ${Expense.balance}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getFooter(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setTabs(4);
        },
        child: const Icon(Icons.add, size: 25, color: white),
        backgroundColor: orange,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget getBody() {
    return IndexedStack(index: pageIndex, children: pages);
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Icons.dashboard_rounded,
      Icons.bar_chart_outlined,
      Icons.account_balance_wallet,
      Icons.person,
    ];
    return AnimatedBottomNavigationBar(
      backgroundColor: Theme.of(context).backgroundColor,
      icons: iconItems,
      activeColor: orange,
      splashColor: orange.withOpacity(0.4),
      inactiveColor: Colors.white.withOpacity(0.5),
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      onTap: (index) {
        setTabs(index);
      },
    );
  }

  setTabs(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
