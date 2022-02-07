import 'package:budget_x/models/expense_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ExpensesDatabase {

  static final ExpensesDatabase instance = ExpensesDatabase._init();

  static Database? _database;
  ExpensesDatabase._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('expenses.db');
    return _database!;
  }

  Future<Database> _initDB (String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
    CREATE TABLE $expenseTable (
    ${ExpenseFields.id} $idType,
    ${ExpenseFields.amount} $integerType,
    ${ExpenseFields.category} $textType,
    ${ExpenseFields.time} $textType,
    ${ExpenseFields.note} $textType,
    ${ExpenseFields.isExpense} $boolType)
  ''');


  }

  Future<Expense> create(Expense expense) async {
    final db = await instance.database;
    final id = await db.insert(expenseTable, expense.toJson());
    print('''
      result is: $id
      Amount: ${expense.amount}
      Category: ${expense.category}
      Time: ${expense.time}
      Note: ${expense.note}
      Expense?: ${expense.isExpense}
      Total balance: ${Expense.balance}
    ''');
    return expense.copy(id: id);
  }

  Future<Expense> readExpense(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      expenseTable,
      columns: ExpenseFields.values,
      where: '${ExpenseFields.id} = ?',
      whereArgs: [id],
    );


    if(maps.isNotEmpty){
      return Expense.fromJson( maps.first );
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Expense>> readAllExpenses() async {
    final db = await instance.database;
    const orderBy = '${ExpenseFields.time} ASC';

    final result = await db.query(expenseTable, orderBy: orderBy);
    return result.map( (json) => Expense.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}