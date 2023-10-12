import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Artists {
  final String id;
  final String name;
  final String url;
  final String image;
  final String followers;

  Artists({
    required this.name,
    required this.url,
    required this.id,
    required this.image,
    required this.followers,
  });

  factory Artists.fromMap(Map<String, dynamic> map) {
    return Artists(
        name: map['name'],
        url: map['url'],
        id: map['id'],
        image: map['image'],
        followers: map['followers']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'image': image,
      'followers': followers
    };
  }
}

class ArtistDatabase {
  late Database artistDB;
  static const String tableName = 'artists';

  Future open() async {
    artistDB = await openDatabase(
      join(await getDatabasesPath(), 'genre.db'),
      version: 1,
      onCreate: (Database db, int version) {
        db.execute(
          'CREATE TABLE $tableName (id TEXT PRIMARY KEY, name TEXT, url TEXT, image TEXT, followers TEXT)',
        );
      },
    );
  }

  Future insertArtist(Artists artist) async {
    await open();
    await artistDB.insert(tableName, artist.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Artists>> getArtists() async {
    await open();
    final List<Map<String, dynamic>> maps = await artistDB.query(
      tableName,
    );

    return List<Artists>.generate(maps.length, (i) {
      return Artists.fromMap(maps[i]);
    });
  }
}
