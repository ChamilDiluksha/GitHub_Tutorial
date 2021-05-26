import 'dart:io';
import 'package:github_tutorial/Models/gitmodel.dart';
import 'package:github_tutorial/Models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'GitCommandData.db';
  static const _databaseVersion = 1;

  static const String ID = 'id';
  static const String USERNAME = 'username';
  static const String PASSWORD = 'password';
  static const String TABLE = 'users';

  /* create a singleton class - private constructor*/
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute(''' 
    CREATE TABLE ${Gitmodel.gittable} (
      ${Gitmodel.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Gitmodel.colCommand} TEXT NOT NULL,
      ${Gitmodel.colDescription} TEXT NOT NULL
    )    
    ''');

    await db.execute('''
      CREATE TABLE $TABLE ( 
        $ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $USERNAME TEXT NOT NULL,
        $PASSWORD TEXT NOT NULL
      )
    ''');
  }

  /*insert data - method*/
  Future<int> insertCommands(Gitmodel gitmodel) async {
    Database db = await database;
    return await db.insert(Gitmodel.gittable, gitmodel.toMap());
  }

  /*retrieve data - method*/
  Future<List<Gitmodel>> retrieveCommands() async {
    Database db = await database;
    List<Map> commands = await db.query(Gitmodel.gittable);
    return commands.length == 0
    ? []
    : commands.map((e) => Gitmodel.fromMap(e)).toList();
  }

  /*update data - method*/
  Future<int> updateCommands(Gitmodel gitmodel) async {
    Database db = await database;
    return await db.update(Gitmodel.gittable, gitmodel.toMap(),
        where: '${Gitmodel.colId}=?', whereArgs: [gitmodel.id]);
  }

  /*delete data - method*/
  Future<int> deleteCommands(int id) async {
    Database db = await database;
    return await db.delete(Gitmodel.gittable,
        where: '${Gitmodel.colId}=?', whereArgs: [id]);
  }

  Future<int> insertContact(User user) async {
    Database db = await database;

    return await db.insert(TABLE, user.toMap());
  }


  Future<List<User>> fetchUsers() async {
    Database db = await database;

    List<Map> contacts = await db.query(TABLE);

    return contacts.length == 0
    ? []
    : contacts.map((e) => User.fromMap(e)).toList();
  }

  Future <bool> getUserbyEmail (String username, String password) async {

    final db = await database;
    var result = await db.query(TABLE, where: "username = ?", whereArgs: [username]);

    print(result.first);
    if(result.isNotEmpty){
      if(result.first['password'] == password){
        final token = await SharedPreferences.getInstance();
        token.setString('Name', result.first['username']);
        return true;
      }
    }
    // result.isNotEmpty?  print(result.first['password']): print("empty");
    return false;

  }
}
