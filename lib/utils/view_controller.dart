import 'package:flutter/material.dart';
import 'package:streamer/utils/colors.dart';
import 'package:streamer/utils/page_data.dart';
import 'package:streamer/utils/responsive.dart';
import 'package:streamer/views/artist_list.dart';
import 'package:streamer/views/home.dart';
import 'package:streamer/views/profile.dart';
import 'package:streamer/views/widgets/footer.dart';
import 'package:streamer/views/widgets/menu.dart';

class MainScreen extends StatefulWidget {
  final String page;

  const MainScreen({super.key, required this.page});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? currentPage;

  @override
  initState() {
    viewDecider();
    // checkFirstLogin();
    super.initState();
  }

  viewDecider() {
    currentPage ??= widget.page;
  }

  viewController() {
    //todo add a unit test & widget test here

    if (currentPage == 'Home') {
      return Home();
    }
    if (currentPage == 'Profile') {
      return Profile();
    }
    if (currentPage == 'Artist') {
      return ArtistListScreen();
    }
  }

  myDrawer() {
    return Drawer(
      elevation: 0,
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
                setState(() {
                  currentPage = pages[i];
                });
              },
            ),
        ],
      ),
    );
  }

  bodyView() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: myDrawer(),
      ),
      Expanded(
        flex: 5,
        child: Scaffold(
          body: viewController(),
          bottomNavigationBar: Footer(),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isLargeScreen(context)
        ? bodyView()
        : MyScaffold(
            body: viewController(),
          );
  }
}

class MyScaffold extends StatelessWidget {
  final Widget body;
  const MyScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        iconTheme: IconThemeData(color: black),
      ),
      drawer: SideMenu(),
      body: body,
      bottomNavigationBar: Footer(),
    );
  }
}
