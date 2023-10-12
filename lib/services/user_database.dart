import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//User Data
class UserData {
  final String name;
  final String initialLogin;
  final String uid;
  UserData({required this.name, required this.initialLogin, required this.uid});

  factory UserData.fromJson(String genre) {
    return UserData(name: '', initialLogin: '', uid: '');
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: '',
      initialLogin: '',
      uid: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'initalLogin': initialLogin, 'uid': uid};
  }
}

// User database class
class UserDatabase {
  late Database userDB;
  static const String tableName = 'user';

  Future open() async {
    userDB = (await openDatabase(
      join(await getDatabasesPath(), 'genres.db'),
      version: 1,
      onCreate: (Database db, int version) {
        db.execute(
          'CREATE TABLE $tableName(uid TEXT PRIMARY KEY , name TEXT, initialLogin TEXT)',
        );
      },
    ));
  }

  Future<List<UserData>> getUserData() async {
    await open();
    final List<Map<String, dynamic>> maps = await userDB.query(tableName);
    return List.generate(maps.length, (i) {
      return UserData.fromMap(maps[i]);
    });
  }
}
