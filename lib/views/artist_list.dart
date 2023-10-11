import 'package:flutter/material.dart';
import 'package:streamer/views/artist_details.dart';

//view artist list screen
class ArtistListScreen extends StatefulWidget {
  final String url;
  final String name;
  final String artist_id;
  const ArtistListScreen(
      {super.key,
      required this.url,
      required this.name,
      required this.artist_id});

  @override
  State<ArtistListScreen> createState() => _ArtistListScreenState();
}

class _ArtistListScreenState extends State<ArtistListScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 100,
        itemBuilder: (context, i) {
          return ListTile(
              leading: Icon(Icons.music_note_outlined),
              title: Text('Artist Name'),
              subtitle: Text('No. ${i + 1}'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => ArtistDetail(
                              url: widget.url,
                              name: widget.name,
                              artist_id: widget.artist_id,
                            ))));
              });
        });
  }
}
