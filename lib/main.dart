import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:streamer/services/provider_service.dart';
import 'package:streamer/services/spotify.dart';
import 'package:streamer/utils/colors.dart';
import 'package:streamer/utils/constants.dart';
import 'package:streamer/views/login.dart';
import 'firebase_options.dart';
//TODO include env

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final spotifyClient = SpotifyApiClient(
    clientId: '',
    clientSecret: '',
  );

  await spotifyClient.getGenres();

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(
        User(userId: 'user123', name: 'John Doe', preferredGenre: 'Pop'),
      ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: app_title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: blueGrey),
        useMaterial3: true,
      ),
      home: MyHomePage(title: app_title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginScreen());
  }
}
