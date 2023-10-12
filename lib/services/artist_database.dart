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
      'artists',
    );

    return List<Artists>.generate(maps.length, (i) {
      return Artists.fromMap(maps[i]);
    });
  }
}

class Songs {
  final String song_id;
  final String song_name;
  final String song_img;
  final String song_album;

  Songs({
    required this.song_id,
    required this.song_name,
    required this.song_img,
    required this.song_album,
  });

  factory Songs.fromMap(Map<String, dynamic> map) {
    return Songs(
      song_id: map['song_id'],
      song_name: map['song_name'],
      song_img: map['song_img'],
      song_album: map['song_album'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'song_id': song_id,
      'song_name': song_name,
      'song_img': song_img,
      'song_album': song_album,
    };
  }
}

class SongDatabase {
  late Database songDB;
  static const String tableName = 'songs';

  Future open() async {
    songDB = await openDatabase(
      join(await getDatabasesPath(), 'genre.db'),
      version: 1,
      onCreate: (Database db, int version) {
        db.execute(
          'CREATE TABLE $tableName (id TEXT PRIMARY KEY, name TEXT, img TEXT, album TEXT,)',
        );
      },
    );
  }

  Future insertSong(Songs song) async {
  await open();
    await songDB.insert(tableName, song.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Artists>> getSong() async {
    await open();
    final List<Map<String, dynamic>> maps = await songDB.query(
      'songs',
    );

    return List<Artists>.generate(maps.length, (i) {
      return Artists.fromMap(maps[i]);
    });
  }
}
