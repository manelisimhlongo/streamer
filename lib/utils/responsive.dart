import 'package:flutter/widgets.dart';

class Responsive {
  static const double phoneScreen = 600;
  static const double desktopScreen = 1200;

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width <= phoneScreen;
  }

  static bool isMediumScreen(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > phoneScreen && width <= desktopScreen;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > desktopScreen;
  }
}
