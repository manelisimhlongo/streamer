import 'package:flutter/material.dart';
import 'package:streamer/views/widgets/scaffold.dart';

///view user profile


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Profile',
      body: Center(
        child: Text('Profile'),
      ),
      footer: Container(),
    );
  }
}
