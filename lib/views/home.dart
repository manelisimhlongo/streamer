import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamer/services/provider_service.dart';
import 'package:streamer/utils/constants.dart';
import 'package:streamer/views/artist_list.dart';
import 'package:streamer/views/first_launch.dart';

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

  @override
  Widget build(BuildContext context) {
    FirstLaunchProvider launchProvider =
        Provider.of<FirstLaunchProvider>(context);
  

        
       
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(app_title)),
        ),
        body: Stack(
          children: [
            launchProvider.thisLaunch.launch == '' ? FirstLaunch() : Container(),
            launchProvider.thisLaunch.launch == ''
                ? Container()
                : ArtistListScreen(
                    url: '',
                    name: '',
                    artist_id: '',
                  ),
          ],
        ));
  }
}
