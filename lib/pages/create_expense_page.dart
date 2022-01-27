// ignore_for_file: prefer_const_constructors

import 'package:budget_x/json/create_expense_json.dart';
import 'package:budget_x/theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class CreateExpense extends StatefulWidget {
  const CreateExpense({ Key? key }) : super(key: key);

  @override
  _CreateExpenseState createState() => _CreateExpenseState();
}

class _CreateExpenseState extends State<CreateExpense> {

  bool addExpense = false;

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
                          padding: const EdgeInsets.only(top: 16, left: 100, right: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Add a transaction', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: white)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Material(
                                    color: Colors.black,
                                    child: InkWell(
                                      splashColor: white,
                                      onTap: (){},
                                      child: Container(
                                        height: 21, width: 63,
                                        alignment: Alignment.center,
                                        //decoration: BoxDecoration( boxShadow: [BoxShadow()])
                                        child: Text('Cancel', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: white))
                                      ),
                                    )
                                  )
                                ],
                              )
                            ],
                          ),
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
                              Text(addExpense ? '-0' : '+0', style: TextStyle(color: addExpense? Colors.red:Colors.green, fontWeight: FontWeight.bold, fontSize: 45),)
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
                                  decoration: BoxDecoration(color: attributes[index]['color'], shape: BoxShape.circle),
                                  child: Center(child: attributes[index]['icon'])
                                ),
                                SizedBox(width: 10),
                                Text(attributes[index]['attribute'], style: TextStyle(color: white, fontSize: 18, fontWeight: FontWeight.w500))
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios, color: white)
                          ],
                        ),
                      ),
                    );
                  })
                ),
                SizedBox(height: 20),
                Container(
                  width: size.width - 30, height: 33,
                  decoration: BoxDecoration( borderRadius: BorderRadius.circular(4), color: orange),
                  child: Center(child: Text('Save', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: white))
                ))
              ],
            )
          )

        ]),
    );

  }
}