import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamer/services/auth.dart';
import 'package:streamer/services/provider_service.dart';
import 'package:streamer/services/spotify.dart';
import 'package:streamer/utils/constants.dart';
import 'package:streamer/views/artist_list.dart';
import 'package:streamer/views/first_launch.dart';
import 'package:streamer/views/login.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> genres = [];
  String? selectedGenre;

  callApi(genre) async {
    final spotifyClient = SpotifyApiClient(
      clientId: '7a9c71d5461e498d8e1e675a92b1793b',
      clientSecret: '4c132e62e9ca4394adca754358c08f34',
    );

    await spotifyClient.getTopArtists(genre);
  }

  @override
  Widget build(BuildContext context) {
    FirstLaunchProvider launchProvider =
        Provider.of<FirstLaunchProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    userProvider.user.preferredGenre == ''
        ? null
        : callApi(userProvider.user.preferredGenre);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.exit_to_app_outlined),
            onPressed: () {
              AuthService().signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            },
          ),
          title: Center(child: Text(app_title)),
        ),
        body: Stack(
          children: [
            launchProvider.thisLaunch.launch == ''
                ? FirstLaunch()
                : Container(),
            launchProvider.thisLaunch.launch == ''
                ? Container()
                : ArtistListScreen(),
          ],
        ));
  }
}
