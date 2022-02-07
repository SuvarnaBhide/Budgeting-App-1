
// ignore_for_file: prefer_const_constructors

import 'package:budget_x/theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const List attributes = [

  { 
    "color": Colors.grey, 
    "icon": Icon(CupertinoIcons.question, color: white),
    "attribute": "Category"
  },
  { 
    "color": orange, 
    "icon": Icon(Icons.account_balance, color: white),
    "attribute": "Account"
  },
  { 
    "color": orange, 
    "icon": Icon(Icons.calendar_today, color: white),
    "attribute": "Date & Time"
  },
  { 
    "color": orange, 
    "icon": Icon(Icons.edit, color: white),
    "attribute": "Write a note"
  },
  { 
    "color": orange, 
    "icon": Icon(Icons.photo, color: white),
    "attribute": "Add photo"
  },
  { 
    "color": orange, 
    "icon": Icon(Icons.repeat_on_outlined, color: white),
    "attribute": "Recurrence"
  },
];

List categoryTypes = [
  {"color": orange , "category": "Food & Drinks" , "icon": Icon(Icons.food_bank_outlined, size: 30)},
  {"color": Colors.green , "category": "Healthcare", "icon": Icon(Icons.health_and_safety_sharp, size: 30),},
  {"color": Colors.red , "category": "Gifts", "icon": Icon(Icons.card_giftcard_sharp, size: 30)},
  {"color": Colors.blue , "category": "Education", "icon": Icon(Icons.school)},
  {"color": Colors.grey , "category": "Other", "icon": Icon(Icons.notes_rounded)},
];

List categoryTypes1 = [
  {"color": Colors.blue , "category": "Scholarship" , "icon": Icon(Icons.school, size: 30)},
  {"color": Colors.green , "category": "Salary/Income", "icon": Icon(Icons.payments_outlined, size: 30),},
  {"color": Colors.red , "category": "Prizes", "icon": Icon(Icons.wallet_giftcard,size: 30)},
  {"color": Colors.grey , "category": "Other", "icon": Icon(Icons.notes_rounded)},
];