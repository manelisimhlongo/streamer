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
  //await dotenv.load(fileName: '.env');
  final spotifyClient = SpotifyApiClient(
    clientId: '7a9c71d5461e498d8e1e675a92b1793b',
    clientSecret: '4c132e62e9ca4394adca754358c08f34',
  );

  await spotifyClient.getGenres();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(
            User(
              userId: '',
              name: '',
              preferredGenre: '',
            ),
          ),
        ),
        ChangeNotifierProvider(
            create: (context) =>
                FirstLaunchProvider(InitialLaunch(launch: ''))),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: app_title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: blueGrey),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: app_title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

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
