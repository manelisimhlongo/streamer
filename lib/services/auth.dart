//firebase auth section

import 'package:firebase_auth/firebase_auth.dart';

User? auth = FirebaseAuth.instance.currentUser;

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // Sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential authResult = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = authResult.user;
      return user;
    } on FirebaseAuthException catch (error) {
      
      return error;
    }
  }

  // Register with email and password.
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential authResult =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = authResult.user;
      return user;
    } on FirebaseAuthException catch (error) {
 
      return error;
    }
  }

  // Sign out.
  Future signOut() async {
    try {
      await auth.signOut();
    } catch (error) {
      return null;
    }
  }
}
