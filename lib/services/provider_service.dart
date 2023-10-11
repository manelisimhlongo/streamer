import 'package:flutter/material.dart';

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
}
