// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:budget_x/database/expenses_database.dart';
import 'package:budget_x/models/category_model.dart';
import 'package:budget_x/models/expense_model.dart';
import 'package:budget_x/theme/color.dart';
import 'package:budget_x/utils/routes.dart';
import 'package:flutter/material.dart' hide MonthPicker;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({ Key? key }) : super(key: key);

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {

  late List<Expense> expenses;
  bool isLoading = false;

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
    refreshBalance(expenses);
    setState(()=> isLoading = false);
  }

  void refreshBalance(List<Expense> expenses){
    
    num totalBalance = 0;
    resetCategoryWiseExpenses();
    for(Expense expense in expenses){
      expense.isExpense ? totalBalance -= expense.amount : totalBalance += expense.amount;
      setCategoryWiseTotalAmount(expense.category, expense.amount,expense.isExpense);
    }
    Expense.balance = totalBalance;
    print('Total Balance: ${Expense.balance}');
    printPercentage();
  }

  void resetCategoryWiseExpenses(){
    Category.educationAmountSpent = 0;
    Category.foodAndDrinksAmountSpent = 0;
    Category.otherAmountSpent = 0;
    Category.healthcareAmountSpent = 0;
    Category.giftsAmountSpent = 0;
  }
  
  void setCategoryWiseTotalAmount(String category, num amount, bool isExpense){
    if(category == 'Food & Drinks') {Category.foodAndDrinksAmountSpent+=amount;}
    else if(category == 'Healthcare') {Category.healthcareAmountSpent+=amount;}
    else if(category == 'Gifts') {Category.giftsAmountSpent+=amount;}
    else if(category == 'Education') {Category.educationAmountSpent+=amount;}
    else if(category == 'Other' && isExpense == false) {Category.otherAmountSpent+=amount;}
  }

  void printPercentage(){
    print('''
     food and drinks : ${Category.foodAndDrinksAmountSpent}
                      ${Category.foodAndDrinksAmountSpent/Category.foodAndDrinksAmountSet}
     healthcare: ${Category.healthcareAmountSpent}
                ${Category.healthcareAmountSpent/Category.healthcareAmountSet}
     gifts: ${Category.giftsAmountSpent},
            ${Category.giftsAmountSpent/Category.giftsAmountSet},
     education: ${Category.educationAmountSpent},
                ${Category.educationAmountSpent/Category.educationAmountSet}
     other: ${Category.otherAmountSpent},
            ${Category.otherAmountSpent/Category.otherAmountSet}
  ''');
  }

  DateTime result = DateTime.now();
  List<int> arr = [];

  //iterate through all expenses, see which fit month, only those indices to be displayed

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          "Expenses",
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
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
                      arr.removeRange(0, arr.length);
                      result = sometime;
                      var newdate = DateTime(result.year, result.month+1, result.day);
                      print('arr length: ${arr.length}');
                      int j = 0;
                      bool flag = false;
                      for(int i=0; i<expenses.length; i++){
                        print('$i');
                        print('result: $result , particular expense: ${expenses[i].time}');
                        int k = 0;
                        if(expenses[i].time.compareTo(result) >= 0 && expenses[i].time.compareTo(newdate) < 0){
                          arr.add(i);
                          flag = true;
                          print('Value: ${arr[k]}, arrlength now: ${arr.length}');
                          k++;
                        }
                        j++;
                      }
                      if(j==expenses.length && arr.isNotEmpty && flag == false){
                        print('haaa');
                        arr.removeRange(0, arr.length);
                        print('arr length: ${arr.length}');
                      }
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
      body: Center(child: 
        isLoading ?
          CircularProgressIndicator()
          : expenses.isEmpty || arr.isEmpty? 
            Text('No transactions', style: TextStyle(color: Colors.white))
            : getBody(),
      ),
    );
  }

  Widget getBody(){

    var size = MediaQuery.of(context).size;
    var time;
    return SingleChildScrollView(
      child: Column(
        children: List.generate(arr.length, (index){
          setState(() {
            time = DateFormat.yMMMd().format(expenses[arr[index]].time);
            print('is it an expense: ${expenses[arr[index]].isExpense}');
          });
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: InkWell(
              onTap: () async {
                await Navigator.pushNamed(
                  context, MyRoute.budgetRoute);
              },
              child: Container(
                width: size.width - 30,
                //height: 150,
                decoration: BoxDecoration(color: boxColor, borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(expenses[arr[index]].category, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Color(0xFFC2C2C2))),
                          Text(time, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFFC2C2C2))),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text( (expenses[arr[index]].isExpense ? '-' : '+') + expenses[arr[index]].amount.toString(), style: TextStyle(color: expenses[index].isExpense? Colors.red : Colors.green, fontSize: 30, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      expenses[arr[index]].note == '' ? Container() : Text(expenses[arr[index]].note, style: TextStyle(color: white, fontSize: 20,)),
                    ],
                  )
                )
              )
            )
          );
        })
      )
    );
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