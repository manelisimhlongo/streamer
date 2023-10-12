import 'package:flutter/material.dart';
import 'package:streamer/services/artist_database.dart';
import 'package:streamer/utils/colors.dart';
import 'package:streamer/views/artist_details.dart';
import 'package:streamer/views/widgets/buttons.dart';
import 'package:streamer/views/widgets/loader.dart';
import 'package:cached_network_image/cached_network_image.dart';

//view artist list screen
class ArtistListScreen extends StatefulWidget {
  const ArtistListScreen({
    super.key,
  });

  @override
  State<ArtistListScreen> createState() => _ArtistListScreenState();
}

class _ArtistListScreenState extends State<ArtistListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(),
      body: FutureBuilder(
          future: ArtistDatabase().getArtists(),
          builder: (context, AsyncSnapshot<List<Artists>> snapshot) {
            if (snapshot.hasData) {
              final artistsList = snapshot.data;
              return ListView.builder(
                  itemCount: artistsList?.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                        leading: artistsList![i].image == 'nothing'
                            ? CircleAvatar(
                                backgroundColor: white,
                                child: Icon(
                                  Icons.person,
                                  color: black,
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: white,
                                child: CachedNetworkImage(
                                  imageUrl: artistsList[i].image,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )),
                        title: Text(artistsList[i].name),
                        subtitle:
                            Text('Followers: ${artistsList[i].followers}'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ArtistDetail(
                                        url: artistsList[i].url,
                                        name: artistsList[i].name,
                                        artist_id: artistsList[i].id,
                                        image: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: artistsList[i].image,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                        followers: artistsList[i].followers,
                                      ))));
                        });
                  });
            } else {
              return Loader();
            }
          }),
    );
  }
}
