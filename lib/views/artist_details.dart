import 'package:flutter/material.dart';
import 'package:streamer/utils/colors.dart';
import 'package:streamer/views/widgets/scaffold.dart';

//view artist detail
class ArtistDetail extends StatelessWidget {
  const ArtistDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Artist Detail',
      body: Center(
        child: Text('Artist Detail'),
      ),
      footer: Container(
        height: 10,
        color: red,
      ),
    );
  }
}
