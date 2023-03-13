import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  initialDB() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'identity-k.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 3, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade ************************");
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Contact (id INTEGER PRIMARY KEY, displayName TEXT, postalAddresses TEXT, phones TEXT,  givenName TEXT, emails TEXT,  middleName TEXT,  prefix TEXT,  suffix TEXT, familyName TEXT, company TEXT, jobTitle TEXT, androidAccountType TEXT, avatar BLOB, birthday DATETIME, androidAccountTypeRaw TEXT, androidAccountName TEXT, identifier TEXT, permissionGroupId TEXT, uniquePhone TEXT,  whatsappImg TEXT )');
    print("onCreate ************************");
  }

  readData(String sql) async {
    Database? mybd = await db;
    List<Map> response = await mybd!.rawQuery(sql);
    return response;
  }

  insertData(String sql, List<Object?>? arg) async {
    Database? mybd = await db;
    int response = await mybd!.rawInsert(sql, arg);
    return response;
  }

  updateData(String sql) async {
    Database? mybd = await db;
    int response = await mybd!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mybd = await db;
    int response = await mybd!.rawDelete(sql);
    return response;
  }
}
