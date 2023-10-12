//spotify api

import 'package:http/http.dart' as http;
import 'package:streamer/services/artist_database.dart';
import 'dart:convert';
import 'package:streamer/services/genre_database.dart';
import 'package:streamer/utils/constants.dart';

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
      Uri.parse('$spotify_url/recommendations/available-genre-seeds'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List genreStrings = List<String>.from(data['genres']);

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

  Future getTopArtists(genreId) async {
    final accessToken = await getAccessToken();

    final response = await http.get(
      Uri.parse(
          '$spotify_url/search?q=remaster%2520track%3ADoxy%2520genre%3A$genreId&type=artist&limit=50&offset=100'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      List artists = body['artists']['items'];

      for (int i = 0; i < artists.length; i++) {
        ArtistDatabase dbSet = ArtistDatabase();

        var val = Artists(
            id: artists[i]['id'],
            name: artists[i]['name'],
            url: artists[i]['external_urls']['spotify'],
            image: artists[i]['images'].isEmpty
                ? 'nothing'
                : artists[i]['images'][0]['url'],
            followers: artists[i]['followers']['total'].toString());
        await dbSet.insertArtist(val);
      }

      return artists;
    } else {
      throw Exception('Failed to fetch top artists');
    }
  }
}
