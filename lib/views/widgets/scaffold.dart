import 'package:flutter/material.dart';
import 'package:streamer/utils/colors.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Widget footer;
  final String title;

  const CustomScaffold(
      {super.key,
      required this.body,
      required this.footer,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        backgroundColor: white,
      ),
      backgroundColor: white,
      body: body,
      bottomNavigationBar: footer,
    );
  }
}
