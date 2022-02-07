const String expenseTable = 'expenses';

class ExpenseFields {
  static final List<String> values = 
  [id, amount, category, time, note, isExpense];

  static const String id = '_id';
  static const String amount = 'amount';
  static const String category = 'category';
  static const String time = 'time';
  static const String note = 'note';
  static const String isExpense = 'isExpense';
}

class Expense {
  final int? id;
  final int amount;
  final String category;
  final DateTime time;
  final String note;
  final bool isExpense;
  static num balance = 0;

  Expense({this.id, required this.amount,required this.category, required this.time, this.note = '', required this.isExpense});

  Expense copy({
    int? id,
    int? amount,
    String? category,
    DateTime? time,
    String? note,
    bool? isExpense,
  }) => Expense(
    id: id?? this.id,
    amount: amount?? this.amount,
    category: category?? this.category,
    time: time?? this.time,
    note: note?? this.note,
    isExpense: isExpense?? this.isExpense,
  );

  static Expense fromJson( Map<String, Object?> json) => Expense(
    id: json[ExpenseFields.id] as int?,
    amount: json[ExpenseFields.amount] as int,
    category: json[ExpenseFields.category] as String,
    time: DateTime.parse(json[ExpenseFields.time] as String),
    note: json[ExpenseFields.note] as String,
    isExpense: json[ExpenseFields.isExpense] == 1,
  );

  Map<String, Object?> toJson() => {

    ExpenseFields.id: id,
    ExpenseFields.amount: amount,
    ExpenseFields.category: category,
    ExpenseFields.time: time.toIso8601String(),
    ExpenseFields.note: note,
    ExpenseFields.isExpense: isExpense ? 1:0,
  };
}

