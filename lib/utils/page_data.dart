import 'package:flutter/material.dart';
import 'package:streamer/views/artist_list.dart';
import 'package:streamer/views/home.dart';
import 'package:streamer/views/profile.dart';

String home = 'Home';
String profile = 'Profile';
String artists = 'Artist';

List<String> pages = [home, profile, artists];

List<IconData> icons = [
  Icons.home_outlined,
  Icons.person_outlined,
  Icons.music_note_outlined
];

List page_nav = [Home(), Profile(), ArtistListScreen()];
