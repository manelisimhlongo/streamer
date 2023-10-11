//spotify api

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:streamer/services/genre_database.dart';

class SpotifyApiClient {
  final String clientId; 
  final String clientSecret; 

  SpotifyApiClient({required this.clientId, required this.clientSecret});

  Future<String> getAccessToken() async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: 'grant_type=client_credentials',
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['access_token'];
    } else {
      throw Exception('Failed to obtain access token');
    }
  }

  Future getGenres() async {
    final accessToken = await getAccessToken();

    final response = await http.get(
      Uri.parse(
          'https://api.spotify.com/v1/recommendations/available-genre-seeds'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<String> genreStrings = List<String>.from(data['genres']);

      //inserts the data into the genre database
      for (int i = 0; i < genreStrings.length; i++) {
        Genres genre = Genres(genre: genreStrings[i]);
        GenresDatabase dbSet = GenresDatabase();
        await dbSet.insertGenre(genre);
      }
      return genreStrings;
    } else {
      throw Exception('Failed to fetch top artists');
    }
  }

  //TODO get the proper API call here
  Future getTopArtists() async {
    final accessToken = await getAccessToken();

    final response = await http.get(
      Uri.parse(
          'https://api.spotify.com/v1/recommendations/available-genre-seeds'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final artists =
          List<String>.from(data['items'].map((item) => item['name']));
      return artists;
    } else {
      throw Exception('Failed to fetch top artists');
    }
  }
}
