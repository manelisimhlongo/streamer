import 'package:flutter/material.dart';
import 'package:streamer/views/widgets/scaffold.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Home',
      body: Center(
        child: Text('Home'),
      ),
      footer: Container(),
    );
  }
}
