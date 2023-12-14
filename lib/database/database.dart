import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import '../database/transactionmodel_class.dart';
class DBHelper {

  static Database _db;
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'transactions.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate );
    return db;
  }

  _onCreate(Database db, int version) async {
    await  db.execute(
      "CREATE TABLE myTransaction (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, amount NUMBER NOT NULL, date DATETIME)",
    );
  }


  Future<TransactionModelClass> insert(TransactionModelClass friendsModel) async {
    var dbClient = await db;
    await dbClient.insert('myTransaction', friendsModel.toMap());
    return friendsModel;
  }


  Future<List<TransactionModelClass>> getCartListWithUserId() async {
    var dbClient = await db;

    final List<Map<String, Object>> queryResult = await dbClient.query('myTransaction' );
    return queryResult.map((e) => TransactionModelClass.fromMap(e)).toList();

  }

  // Deleting Data From Database
  Future<int> delete(int id) async{
    var dbClient = await db;
    return await dbClient.delete(
        'myTransaction',
        where: 'id = ?',
        whereArgs: [id]
    );
  }

  // Update Data In Database
  Future<int> update(TransactionModelClass friendsModel) async{
    var dbClient = await db;
    return await dbClient.update(
        "myTransaction",
        friendsModel.toMap(),
        where: 'id = ?',
        whereArgs: [friendsModel.id]
    );
  }

}