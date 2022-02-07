// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:budget_x/database/expenses_database.dart';
import 'package:budget_x/json/create_expense_json.dart';
import 'package:budget_x/models/category_model.dart';
import 'package:budget_x/models/expense_model.dart';
import 'package:budget_x/pages/root_app.dart';
import 'package:budget_x/theme/color.dart';
import 'package:budget_x/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class CreateExpense extends StatefulWidget {
  const CreateExpense({ Key? key }) : super(key: key);

  @override
  _CreateExpenseState createState() => _CreateExpenseState();
}

class _CreateExpenseState extends State<CreateExpense> {

  bool addExpense = false;
  late Expense expense;
  List<String> items = [];
  //num amount = 1000;
  static var category = "Category"; static var category1 = "Category";
  static Icon categoryIcon = Icon(CupertinoIcons.question, color: white);
  static Icon categoryIcon1 = Icon(CupertinoIcons.question, color: white);
  static Color categoryColor = Colors.grey;
  static Color categoryColor1 = Colors.grey;

  String amount = '';
  String note = '';
  String dateAndTime = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: getBody()
    );
  }

  Widget getBody(){

    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [

          Container(
            //decoration: BoxDecoration(color: Colors.black, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.01), spreadRadius: 10, blurRadius: 3)]),
            padding: EdgeInsets.only(top: 60, bottom: 25, right: 20, left: 20),
          ),

          Container(
            width: size.width, height: size.height,
            decoration: BoxDecoration(color: boxColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
            child: Column(
              children: [

                //before divider part
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(child: Text('Add a transaction', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: white))),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: size.width - 20,
                          height: 38,
                          decoration: BoxDecoration(color: Colors.transparent , border: Border.all(width: 2, color: addExpense ? Colors.red : Colors.green), borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => setState((){addExpense = true;}),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Container(
                                    
                                    width: (size.width - 30)/2,
                                    height: 28,
                                    decoration: BoxDecoration(color: addExpense ? Colors.red : Colors.transparent, borderRadius: BorderRadius.circular(15)),
                                    child: Center(child: Text('Expense', style: TextStyle(color: white, fontWeight: FontWeight.bold)))
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => setState(() {addExpense = false;}),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 3),
                                  child: Container(
                                    width: (size.width - 30)/2,
                                    height: 28,
                                    decoration: BoxDecoration(color: addExpense ? Colors.transparent : Colors.green, borderRadius: BorderRadius.circular(15)),
                                    child: Center(child: Text('Income', style: TextStyle(color: white, fontWeight: FontWeight.bold)))
                                  ),
                                ),
                              )
                      ]),
                          ),
                        SizedBox(height: 20),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 44, height: 44,
                                decoration: BoxDecoration(color: addExpense ? Colors.red : Colors.green, shape: BoxShape.circle),
                                child: Center(child: Icon(CupertinoIcons.money_dollar, color: white))
                              ),
                              InkWell(onTap: () async {

                                final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => PopUpDialog(title: "Amount", isExpense: addExpense)));
                                ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(content: Text('You have set an ' +
                                (addExpense ? 'expense' : 'income') + ' amount of \$'+ '$result')));
                                setState(() {
                                  amount = result;
                                });

                              }, child: Text( (addExpense ? '-' : '+') + amount, style: TextStyle(color: addExpense? Colors.red:Colors.green, fontWeight: FontWeight.bold, fontSize: 45),))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                  child: Divider(color: white.withOpacity(0.5)),
                ),

                //After divider
                Column(
                  children: List.generate(attributes.length, (index){
                    return Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 44, height: 44,
                                  decoration: BoxDecoration(color: index == 0 ? addExpense ? categoryColor : categoryColor1 : 
                                    index == 1 || index == 4 || index == 5 ?
                                     orange.withOpacity(0.8) : attributes[index]['color'], shape: BoxShape.circle),
                                  child: Center(child: index == 0 ? addExpense ? categoryIcon : categoryIcon1 : attributes[index]['icon'])
                                ),
                                SizedBox(width: 10),
                                Text(index == 0 ? addExpense ?
                                      category : category1 
                                    : index == 2 && dateAndTime!='' ? dateAndTime  : index == 3 && note!=''? note :
                                    attributes[index]['attribute'], style: TextStyle(
                                      color: index == 1 || index == 4 || index == 5 ?
                                     white.withOpacity(0.5):white, fontSize: 18, fontWeight: FontWeight.w500))
                              ],
                            ),
                            IconButton(
                              icon: Icon(Icons.add, color: index == 1 || index == 4 || index == 5 ? white.withOpacity(0.4) : white),
                              onPressed: () async {
                                  if(index == 1 || index == 4 || index == 5){
                                    ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(content: Text('Future Scope')));
                                  }
                                  else {
                                  final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => PopUpDialog(title: attributes[index]['attribute'], isExpense: addExpense)));
                                  //ScaffoldMessenger.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(content: Text('$result')));

                                  if(index == 0){
                                    setState(() {
                                      addExpense ? category = result[0] : category1  = result[0];
                                      addExpense ? categoryIcon = result[1] : categoryIcon1 = result[1];
                                      addExpense ? categoryColor = result[2] : categoryColor1 = result[2];
                                  });}
                                  else if(index == 2){
                                    setState(() {
                                      dateAndTime = result!;
                                    });
                                  }
                                  else if(index == 3){
                                    setState(() {
                                      note = result;
                                    });
                                  }
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  })
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    final expense = Expense(
                      amount: int.parse(amount),
                      category: addExpense ? category : category1 ,
                      time: DateTime.parse(dateAndTime),
                      note: note,
                      isExpense: addExpense,
                    );
                    final income = Expense(
                      amount: 1000,
                      category: 'scholarship',
                      time: DateTime.now(),
                      note: 'won 1st prize in hackathon',
                      isExpense: addExpense,
                    );
                    await ExpensesDatabase.instance.create(expense);
                    final snackBar = SnackBar(
                      content: const Text('Transaction saved'),
                      action: SnackBarAction(
                        label: 'Show all', 
                        onPressed: () async {
                          RootAppState.pageIndex = 2;
                          await Future.delayed(Duration(milliseconds: 900));
                          await Navigator.pushNamed(context, MyRoute.expenseRoute);
                        }
                      )
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                    width: size.width - 30, height: 33,
                    decoration: BoxDecoration( borderRadius: BorderRadius.circular(4), color: orange),
                    child: Center(child: Text('Save', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: white))
                  )),
                )
              ],
            )
          )

        ]),
    );
  }
}

// ignore: must_be_immutable
class PopUpDialog extends StatefulWidget {
  var title;
  bool isExpense;

  PopUpDialog({ Key? key , required this.title, required this.isExpense}) : super(key: key);

  @override
  _PopUpDialogState createState() => _PopUpDialogState();
}

class _PopUpDialogState extends State<PopUpDialog> {

  final GlobalKey<FormState> _amount = GlobalKey<FormState>();
  final GlobalKey<FormState> _note = GlobalKey<FormState>();
  final GlobalKey<FormState> _allTransactionDetails = GlobalKey<FormState>();
  String amount = '0';
  String note = '';
  String date = '';
  DateTime selectedDate = DateTime.now();
  final TextEditingController _date = TextEditingController();


  Widget buildAmount(){
    return TextFormField(
      validator: (value){
        if(value!.isEmpty || int.parse(value) < 0){
          return "Please enter a non-negative number";
        }
        return null;
      },
      onSaved: (value){
        amount = value!;
      },
    );
  }

  Widget buildNote(){
    return TextFormField(
      onSaved: (value){
        note = value!;
      },
    );
  }

  Widget buildDateAndTime(){
    return TextFormField(
      validator: (value){
        if(value!.isEmpty){
          return "Enter a valid date";
        }
        return null;
      },
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
        selectDate(context);
      },
      controller: _date,
    );
  }

  Future<void> selectDate(BuildContext context) async {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
        _date.value = TextEditingValue(text: formatter.format(picked));
        date = _date.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.title == 'Amount')
            Column(
              children: [
                Form(
                  key: _amount,
                  child: Column(
                    children: [
                      buildAmount(),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (){
                            if(!_amount.currentState!.validate()){
                              return;
                            }
                            _amount.currentState!.save();
                            Navigator.pop(context,amount);
                          },
                          child: Text('save amount')
                        )
                      )
                    ],
                  )
                )
                ,
              ],
            )
          else if(widget.title == 'Category') 
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate( widget.isExpense ? categoryTypes.length : categoryTypes1.length, (index) {
                return InkWell(
                  onTap: () async {
                    widget.isExpense ? 
                      Navigator.pop(context, [categoryTypes[index]['category'], categoryTypes[index]['icon'], categoryTypes[index]['color']])
                      : Navigator.pop(context, [categoryTypes1[index]['category'], categoryTypes1[index]['icon'], categoryTypes1[index]['color']]);
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: widget.isExpense ? categoryTypes[index]['color'] : categoryTypes1[index]['color'],
                          shape: BoxShape.circle),
                          child: Center(
                            child: widget.isExpense ? categoryTypes[index]['icon'] : categoryTypes1[index]['icon'])),
                      const SizedBox(width: 15),
                      Text(widget.isExpense ? categoryTypes[index]['category'] : categoryTypes1[index]['category']),

                    ],
                  )
                );
              })
            )
            else if(widget.title == 'Write a note')
              Column(
                children: [
                  Form(
                  key: _note,
                  child: Column(
                    children: [
                      buildNote(),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (){
                            if(!_note.currentState!.validate()){
                              return;
                            }
                            _note.currentState!.save();
                            Navigator.pop(context, note);
                          },
                          child: Text('save note')
                        )
                      )
                    ],
                  )
                )
                ,
                ],
              )
              else if(widget.title == 'Date & Time')
              Column(
                children: [
                  buildDateAndTime(),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context, date);
                      }, 
                      child: Text('Save Date')),
                  )
                ],
              )
        ],
      ),
    );
  }
}
