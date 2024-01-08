import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDb();
      return _db;
    } else {
      return _db;
    }
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "moataz.db");
    Database myDb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return myDb;
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("upgrade ==================================");
    await db.execute("ALTER TABLE notes ADD COLUMN subTitle TEXT");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE notes (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    note TEXT NOT NULL)
    ''');
    print("Created notes in database ==================================");
  }

  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }


  // shortcuts methods


  read(String table, Map<String, Object?> values) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.query(table);
    return response;
  }

  insert(String table, Map<String, Object?> values) async {
    Database? myDb = await db;
    int response = await myDb!.insert(table, values);
    return response;
  }

  delete(String table, String myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.delete(table, where: myWhere);
    return response;
  }

  update(String table, Map<String, Object?> values, String myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.update(table, values, where: myWhere);
    return response;
  }
}
