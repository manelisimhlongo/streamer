import 'package:flutter/material.dart';

//view artist detail
class ArtistDetail extends StatefulWidget {
  final String url;
  final String name;
  final String artist_id;
  const ArtistDetail(
      {super.key,
      required this.url,
      required this.name,
      required this.artist_id});

  @override
  State<ArtistDetail> createState() => _ArtistDetailState();
}

class _ArtistDetailState extends State<ArtistDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Artist Detail'),
      ),
    );
  }
}
