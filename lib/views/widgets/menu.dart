import 'package:flutter/material.dart';
import 'package:streamer/utils/colors.dart';
import 'package:streamer/utils/page_data.dart';
import 'package:streamer/utils/view_controller.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: white,
      child: ListView(
        children: [
          DrawerHeader(
            child: FlutterLogo(),
          ),
          for (int i = 0; i < pages.length; i++)
            ListTile(
              title: Text(pages[i]),
              leading: Icon(
                icons[i],
                color: black,
              ),
              onTap: () {
                //TODO change this to pop and change view
                Navigator.pop(context);

                setState(() {
                  MainScreen(page: pages[i]);
                });
              },
            ),
        ],
      ),
    );
  }
}
