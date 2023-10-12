import 'package:flutter/material.dart';

// User class
class User {
  String userId;
  String name;
  String preferredGenre;

  User({
    required this.userId,
    required this.name,
    required this.preferredGenre,
  });
}

// User change notifier
class UserProvider extends ChangeNotifier {
  late User my_user;

  UserProvider(User user) {
    my_user = user;
  }

  User get user => my_user;

  void updatePreferredGenre(String newGenre) {
    my_user.preferredGenre = newGenre;
    notifyListeners();
  }

  void updateName(String name) {
    my_user.name = name;
    notifyListeners();
  }

  void updateId(String id) {
    my_user.userId = id;
    notifyListeners();
  }
}

class InitialLaunch {
  String launch;

  InitialLaunch({
    required this.launch,
  });
}

// First launch change notifier
class FirstLaunchProvider extends ChangeNotifier {
  late InitialLaunch this_launch;

  FirstLaunchProvider(InitialLaunch thisLaunch) {
    this_launch = thisLaunch;
  }

  InitialLaunch get thisLaunch => this_launch;


  void updateLaunch(String value) {
    this_launch.launch = value;
    notifyListeners();
  }
}
