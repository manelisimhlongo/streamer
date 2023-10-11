import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:streamer/services/auth.dart';
import 'package:streamer/utils/colors.dart';
import 'package:streamer/utils/constants.dart';
import 'package:streamer/views/home.dart';
import 'package:streamer/views/widgets/buttons.dart';
import 'package:streamer/views/widgets/text_fields.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key, });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  double elementsOpacity = 1;
  bool loadingBallAppear = false;
  double loadingBallSize = 1;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  Widget welcomeText() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: 300),
        tween: Tween(begin: 1, end: elementsOpacity),
        builder: (context, value, __) => Opacity(
          opacity: value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                welcome,
                style: TextStyle(
                    color: black, fontSize: 32, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                login,
                style: TextStyle(color: black.withOpacity(0.7), fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFields() {
    return Column(
      children: [
        EmailField(
            fadeEmail: elementsOpacity == 0, emailController: emailController),
        SizedBox(height: 40),
        PasswordField(
            fadePassword: elementsOpacity == 0,
            passwordController: passwordController),
        SizedBox(height: 60),
      ],
    );
  }

  Widget buttons() {
    return Column(
      children: [
        LogInButton(
          elementsOpacity: elementsOpacity,
          onTap: () async {
            AuthService()
                .signInWithEmailAndPassword(
                    emailController.text, passwordController.text)
                .then((value) {
              if (value.runtimeType == FirebaseAuthException) {
                Fluttertoast.showToast(msg: value.code);
              }
              if (value.runtimeType == User) {
                setState(() {
                  elementsOpacity = 0;
                });
              }
            });
          },
          onAnimationEnd: () async {
            await Future.delayed(Duration(milliseconds: 500));
            setState(() {
              loadingBallAppear = true;
            });
          },
        ),
        SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      body: FirebaseAuth.instance.currentUser?.uid != null
          ? Home( )
          : SafeArea(
              bottom: false,
              child: loadingBallAppear
                  ? Home()
                  : Container(
                      color: blueGrey.withOpacity(.5),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50.0),
                          child: SingleChildScrollView(
                            child: SizedBox(
                              width: 450,
                              child: Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22.0)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 48),
                                    Center(
                                      child: Icon(Icons.flutter_dash_outlined,
                                          size: 80, color: black),
                                    ),
                                    welcomeText(),
                                    SizedBox(height: 24),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [textFields(), buttons()],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
    );
  }
}
