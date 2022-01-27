import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:budget_x/pages/profile_page.dart';
import 'package:flutter/material.dart';

import 'package:budget_x/pages/dashboard_page.dart';
import 'package:budget_x/theme/color.dart';

import 'create_expense_page.dart';

void main() {
  runApp(const MaterialApp(
    home: RootApp(pageIndex: null),
  ));
}

class RootApp extends StatefulWidget {
  const RootApp({Key? key, required pageIndex}) : super(key: key);

  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  List<Widget> pages = [
    const DashboardPage(),
    /*const StatsPage()*/ const Center(child: Text('STATS')),
    const Center(child: Text('BUDGET')),
    MyProfilePage(), //idhar profile page daal de
    const CreateExpense(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
