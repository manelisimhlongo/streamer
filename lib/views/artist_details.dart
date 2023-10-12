import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:streamer/services/spotify.dart';
import 'package:streamer/utils/colors.dart';
import 'package:streamer/views/widgets/loader.dart';

//view artist detail
class ArtistDetail extends StatefulWidget {
  final String url;
  final String name;
  final String artist_id;
  final Widget image;
  final String followers;
  const ArtistDetail(
      {super.key,
      required this.url,
      required this.name,
      required this.artist_id,
      required this.image,
      required this.followers});

  @override
  State<ArtistDetail> createState() => _ArtistDetailState();
}

class _ArtistDetailState extends State<ArtistDetail> {
  @override
  void initState() {
    callApi();
    super.initState();
  }

  Widget img() {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      color: blueGrey.withOpacity(.2),
      child: widget.image,
    );
  }

  Widget listView() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: white,
        child: SingleChildScrollView(
            child: ListView.builder(itemBuilder: (context, i) {
          return ListTile(
            leading: CachedNetworkImage(
              imageUrl: 'x',
            ),
            title: Text('song'),
            trailing: Icon(Icons.play_arrow),
          );
        })));
  }

  callApi() async {
    final spotifyClient = SpotifyApiClient(
      clientId: '7a9c71d5461e498d8e1e675a92b1793b',
      clientSecret: '4c132e62e9ca4394adca754358c08f34',
    );
    await spotifyClient.getTopTracks(widget.artist_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: SpotifyApiClient(
                    clientId: '7a9c71d5461e498d8e1e675a92b1793b',
                    clientSecret: '4c132e62e9ca4394adca754358c08f34')
                .getTopTracks(widget.artist_id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final tracks = snapshot.data;
                return Column(
                  children: [
                    img(),
                    for (int i = 0; i < tracks!.length; i++)
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: white,
                          child: CachedNetworkImage(
                            imageUrl: tracks[i]['album']['images'][0]['url'],
                          ),
                        ),
                        title: Text(tracks[i]['album']['name']),
                        subtitle: Text(tracks[i]['album']['album_type']),
                      )
                  ],
                );
              } else {
                return Loader();
              }
            }),
      ),
    );
  }
}
