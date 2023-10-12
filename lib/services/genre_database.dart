import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Genre class
class Genres {
  final String genre;
  Genres({required this.genre});

  factory Genres.fromJson(String genre) {
    return Genres(
      genre: genre,
    );
  }

  factory Genres.fromMap(Map<String, dynamic> map) {
    return Genres(
      genre: map['genre'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'genre': genre,
    };
  }
}

// Genre database class
class GenresDatabase {
  late Database genreDB;
  static const String tableName = 'genres';

  Future open() async {
    genreDB = await openDatabase(
      join(await getDatabasesPath(), 'genres.db'),
      version: 1,
      onCreate: (Database db, int version) {
        db.execute(
          'CREATE TABLE $tableName(genre TEXT PRIMARY KEY )',
        );
      },
    );
  }

  Future<void> insertGenre(Genres genre) async {
    await open();
    await genreDB.insert(
      tableName,
      genre.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<Genres>> getGenres() async {
    await open();
    final List<Map<String, dynamic>> maps = await genreDB.query('genres');
    return List.generate(maps.length, (i) {
      return Genres.fromMap(maps[i]);
    });
  }

 
}
