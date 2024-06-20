import 'package:budget_x/models/category_model.dart';

var totalExpesne = Category.foodAndDrinksAmountSpent+Category.healthcareAmountSpent+Category.giftsAmountSpent+Category.educationAmountSpent+Category.otherAmountSpent;
var totalIncome = Category.foodAndDrinksAmountSet+Category.healthcareAmountSet+Category.giftsAmountSpent+Category.educationAmountSpent+Category.otherAmountSpent;

List statsTypes = [
  {
    "statsType": "Net Balance",
    "image": "assets thing idhar jayega"
  },
  {
    "statsType": "Cash Flow",
    "image": "assets thing idhar jayega"
  },
  {
    "statsType": "Current Budget",
  },
];