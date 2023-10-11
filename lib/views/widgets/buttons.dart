import 'package:flutter/material.dart';
import 'package:streamer/utils/colors.dart';
import 'package:streamer/utils/constants.dart';

class FloatingButton extends StatelessWidget {
  final Function() onPress;
  final IconData icons;
  const FloatingButton({Key? key, required this.onPress, required this.icons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: onPress,
        backgroundColor: white,
        splashColor: blueGrey,
        child: Icon(
          icons,
        ));
  }
}

class ConfirmButton extends StatelessWidget {
  final Function() onPress;

  const ConfirmButton({Key? key, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: green,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        onPressed: onPress,
        child: Text(
          'Confirm',
          style: TextStyle(color: white),
        ));
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: red,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          'Cancel',
          style: TextStyle(color: white),
        ));
  }
}

class LogInButton extends StatefulWidget {
  final Function onTap;
  final Function onAnimationEnd;
  final double elementsOpacity;
  const LogInButton(
      {super.key,
      required this.onTap,
      required this.onAnimationEnd,
      required this.elementsOpacity});

  @override
  State<LogInButton> createState() => _LogInButtonState();
}

class _LogInButtonState extends State<LogInButton> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300),
      tween: Tween(begin: 1, end: widget.elementsOpacity),
      onEnd: () async {
        widget.onAnimationEnd();
      },
      builder: (context, value, __) => ElevatedButton(
        onPressed: () {
          widget.onTap();
        },
         style: ElevatedButton.styleFrom(
          backgroundColor: blueGrey.withOpacity(.1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        child: Opacity(
          opacity: value,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                login,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: black.withOpacity(.7),
                    fontSize: 19),
              ),
              SizedBox(width: 15),
              Icon(
                Icons.arrow_forward_ios,
                color: black.withOpacity(.7),
                size: 26,
              )
            ],
          ),
        ),
      ),
    );
  }
}
