import 'package:flutter/material.dart';
import 'package:streamer/services/genre_database.dart';

class GenresProvider {
  final GenresDatabase db;

  GenresProvider(this.db);

  Future<List<String>> getGenreList() async {
    final genres = await db.getGenres();
    return genres.map((genre) => genre.genre).toList();
  }
}

class GenreDropdownWidget extends StatefulWidget {
  const GenreDropdownWidget({super.key});

  @override
  _GenreDropdownWidgetState createState() => _GenreDropdownWidgetState();
}

class _GenreDropdownWidgetState extends State<GenreDropdownWidget> {
  List<String> genres = [];
  String? selectedGenre;

  final GenresProvider genresProvider = GenresProvider(GenresDatabase());

  @override
  void initState() {
    super.initState();
    loadGenres();
  }

  Future<void> loadGenres() async {
    final genreList = await genresProvider.getGenreList();
    setState(() {
      genres = genreList;
    });
  }

  //TODO build breaks when selected. fix

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        value: selectedGenre,
        items: genres.map((String genre) {
          return DropdownMenuItem<String>(
            value: genre,
            child: Text(genre),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedGenre = newValue!;
          });
        });
  }
}
