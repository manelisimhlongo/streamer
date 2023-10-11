import 'package:flutter/material.dart';

class ArtistListScreen extends StatelessWidget {
  const ArtistListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, i) {
      return ListTile(
        leading: Icon(Icons.music_note_outlined),
        title: Text('Artist Name'),
        subtitle: Text('No. ' + (i + 1).toString()),
      );
    });
  }
}
