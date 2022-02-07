// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:budget_x/database/expenses_database.dart';
import 'package:budget_x/json/create_expense_json.dart';
import 'package:budget_x/models/category_model.dart';
import 'package:budget_x/models/expense_model.dart';
import 'package:budget_x/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({ Key? key }) : super(key: key);

  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Budget', style: GoogleFonts.inter(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => PopUpDialog(title: "Create Budget for each category",)));
              setState(() {
                Category.foodAndDrinksAmountSet = int.parse(result[0]);
                Category.healthcareAmountSet = int.parse(result[1]);
                Category.giftsAmountSet = int.parse(result[2]);
                Category.educationAmountSet = int.parse(result[3]);
                Category.otherAmountSet = int.parse(result[4]);
              });
            },
          )
        ],
      ),
      body: getBody(),
      drawer: Drawer(),
    );
  }

  Widget getBody(){

    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 50),
          Column(
            children: List.generate(categoryTypes.length, (index){
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20,),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: boxColor, borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(categoryTypes[index]['category'], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: white)),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('\$' + categoryAmountSpent(categoryTypes[index]['category']), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: categoryTypes[index]['color'])),
                                const SizedBox(width: 8),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Text(calculatePercentage(categoryTypes[index]['category']) + '%', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.grey)),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text('\$' + categoryAmountSet(categoryTypes[index]['category']), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.grey)),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        Stack(children: [
                          Container(
                            width: size.width - 40, height: 5,
                            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
                          ),
                          Container(
                            width: (size.width - 40) * double.parse(calculatePercentage(categoryTypes[index]['category']))/100, height: 4,
                            decoration: BoxDecoration(color: categoryTypes[index]['color'], borderRadius: BorderRadius.circular(5)),
                          ),
                        ],),
                        if(double.parse(calculatePercentage(categoryTypes[index]['category']))/100 >= 1)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Text('!', style: TextStyle(color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          )
                        else SizedBox(height: 15)
                      ],
                    ),
                  )
                ),
              );
            })
          ),
        ],
      ),
    );
  }

  String categoryAmountSpent(String category){
    if(category == 'Food & Drinks'){
      return Category.foodAndDrinksAmountSpent.toString();
    }
    else if(category == 'Healthcare'){
      return Category.healthcareAmountSpent.toString();
    }
    else if(category == 'Gifts'){
      return Category.giftsAmountSpent.toString();
    }
    else if(category == 'Education'){
      return Category.educationAmountSpent.toString();
    }
    else if(category == 'Other'){
      return Category.otherAmountSpent.toString();
    }
    else {
      return '';
    }
  }

  String calculatePercentage(String category){
    if(category == 'Food & Drinks'){
      return ( (Category.foodAndDrinksAmountSpent/Category.foodAndDrinksAmountSet) * 100).toStringAsFixed(2);
    }
    else if(category == 'Healthcare'){
      return ( (Category.healthcareAmountSpent/Category.healthcareAmountSet) * 100).toStringAsFixed(2);
    }
    else if(category == 'Gifts'){
      return ( (Category.giftsAmountSpent/Category.giftsAmountSet) * 100).toStringAsFixed(2);
    }
    else if(category == 'Education'){
      return ( (Category.educationAmountSpent/Category.educationAmountSet) * 100).toStringAsFixed(2);
    }
    else if(category == 'Other'){
      return ( (Category.otherAmountSpent/Category.otherAmountSet) * 100).toStringAsFixed(2);
    }
    else {
      return '';
    }
  }

  String categoryAmountSet(String category){
    if(category == 'Food & Drinks'){
      return Category.foodAndDrinksAmountSet.toString();
    }
    else if(category == 'Healthcare'){
      return Category.healthcareAmountSet.toString();
    }
    else if(category == 'Gifts'){
      return Category.giftsAmountSet.toString();
    }
    else if(category == 'Education'){
      return Category.educationAmountSet.toString();
    }
    else if(category == 'Other'){
      return Category.otherAmountSet.toString();
    }
    else {
      return '';
    }
  }
}

class PopUpDialog extends StatefulWidget {
  var title;
  PopUpDialog({ Key? key, required this.title }) : super(key: key);

  @override
  _PopUpDialogState createState() => _PopUpDialogState();
}

class _PopUpDialogState extends State<PopUpDialog> {

  final GlobalKey<FormState> _categoryWiseBudgetDetails = GlobalKey<FormState>();
  String foodAndDrinksBudget = '';
  String healthcareBudget = '';
  String giftsBudget = '';
  String educationBudget = '';
  String otherBudget = '';

  Widget buildBudget(String categoryBudget){
    return TextFormField(
      validator: (value){
        if(value!.isEmpty || int.parse(value) < 0){
          return "Please enter a non-negative number";
        }
        return null;
      },
      cursorColor: orange,
      decoration: InputDecoration(
        hintText: "Set budget for $categoryBudget"
      ),
      onSaved: (value){
        setBudget(categoryBudget, value!);
      }
    );
  }
  
  void setBudget(String categoryBudget, String value){

    if(categoryBudget == 'Food & Drinks') 
      {foodAndDrinksBudget = value;}
    else if(categoryBudget == 'Healthcare')
      {healthcareBudget = value;}
    else if(categoryBudget == 'Gifts'){
      giftsBudget = value;
    }
    else if(categoryBudget == 'Education'){
      educationBudget = value;
    }
    else if(categoryBudget == 'Other'){
      otherBudget = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _categoryWiseBudgetDetails,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: 
                List.generate(categoryTypes.length, (index) {
                  return Column(
                    children: [
                      buildBudget(categoryTypes[index]['category']),
                      SizedBox(height: 50)
                    ],
                  );
                }),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    if(!_categoryWiseBudgetDetails.currentState!.validate()){
                      return;
                    }
                    _categoryWiseBudgetDetails.currentState!.save();
                    Navigator.pop(context, [
                      foodAndDrinksBudget,
                      healthcareBudget,
                      giftsBudget,
                      educationBudget,
                      otherBudget,
                    ]);

                  },
                  child: Text('Save budgets'),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}