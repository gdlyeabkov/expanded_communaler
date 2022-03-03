import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models.dart';

class DatabaseHandler {

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'flutter_communaler.db'),
      onCreate: (database, version) async {
        await database.execute(
            "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, login TEXT, password TEXT, address TEXT, phone TEXT, name TEXT, email INTEGER, gender TEXT, firstname TEXT, secondname TEXT, thirdname TEXT, born TEXT)"
        );
        await database.execute(
            "CREATE TABLE IF NOT EXISTS amounts(id INTEGER PRIMARY KEY, provider TEXT, number TEXT, status TEXT, email INTEGER, datetime TEXT, cost INTEGER, user INTEGER)"
        );
      },
      version: 1,
    );
  }

  Future<int> insertUsers(List<User> users) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var user in users){
      result = await db.insert('users', user.toMap());
    }
    return result;
  }

  Future<int> addNewUsers(String login, String password, String address, String phone, String name, int email, String gender, String firstname, String secondname, String thirdname, String born) async {
    User firstUser = User(
      login: login,
      password: password,
      address: address,
      phone: phone,
      name: name,
      email: email,
      gender: gender,
      firstname: firstname,
      secondname: secondname,
      thirdname: thirdname,
      born: born
    );
    List<User> listOfUsers = [firstUser];
    return await insertUsers(listOfUsers);
  }

  Future<List<User>> retrieveUsers() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('users');
    var returnedUsers = queryResult.map((e) => User.fromMap(e)).toList();
    return returnedUsers;
  }

  Future<void> updateUserData(int userId, String firstName, String secondName, String thirdName, String born, String gender) async {
    final db = await initializeDB();
    Map<String, dynamic> values = Map<String, dynamic>();
    values = {
      'firstname': firstName,
      'secondname': secondName,
      'thirdname': thirdName,
      'born': born,
      'gender': gender
    };
    await db.update(
      'users',
      values,
      where: 'id = ?',
      whereArgs: [userId]
    );
  }

  Future<void> updateUserPassword(int userId, String password) async {
    final db = await initializeDB();
    Map<String, dynamic> values = Map<String, dynamic>();
    values = {
      'password': password,
    };
    await db.update(
        'users',
        values,
        where: 'id = ?',
        whereArgs: [userId]
    );
  }

  Future<int> insertAmounts(List<Amount> amounts) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var amount in amounts){
      result = await db.insert('amounts', amount.toMap());
    }
    return result;
  }

  Future<int> addNewAmounts(String provider, String number, String status, int email, String datetime, int cost, int user) async {
    Amount firstAmount = Amount(
        provider: provider,
        number: number,
        status: status,
        email: email,
        datetime: datetime,
        cost: cost,
        user: user
    );
    List<Amount> listOfAmounts = [firstAmount];
    return await insertAmounts(listOfAmounts);
  }

  Future<List<Amount>> retrieveAmounts() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('amounts');
    var returnedAmounts = queryResult.map((e) => Amount.fromMap(e)).toList();
    return returnedAmounts;
  }

  Future<void> updateAmountCost(int amountId, int cost) async {
    final db = await initializeDB();
    Map<String, dynamic> values = Map<String, dynamic>();
    values = {
      'cost': cost
    };
    await db.update(
      'amounts',
      values,
      where: 'id = ?',
      whereArgs: [amountId]
    );
  }

}