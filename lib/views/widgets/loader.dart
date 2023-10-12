import 'package:flutter/material.dart';
import 'package:streamer/utils/colors.dart';


class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(blueGrey),
      ),
    );
  }
}
