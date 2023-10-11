import 'package:flutter/material.dart';
import 'package:streamer/utils/colors.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: black,
    );
  }
}
