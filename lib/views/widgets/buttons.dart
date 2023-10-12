import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamer/services/genre_database.dart';
import 'package:streamer/services/provider_service.dart';
import 'package:streamer/utils/colors.dart';
import 'package:streamer/utils/constants.dart';
import 'package:streamer/views/widgets/loader.dart';

//reusable floatinf action button
class FloatingButton extends StatelessWidget {
  const FloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Center(child: Text('Change Genre')),
                  content: GenreDropdownMenu(),
                  actions: [
                    CustomButton(
                      text: 'Confirm',
                      backgroundColor: green,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
        },
        backgroundColor: white,
        splashColor: blueGrey,
        child: Icon(
          Icons.menu,
        ));
  }
}

//reusable confirm button
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

//reusable cancel button
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

//reusable cancel button
class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final Function() onPressed;
  final String text;
  const CustomButton(
      {Key? key,
      required this.backgroundColor,
      required this.onPressed,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: white),
        ));
  }
}

//custom login button
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

//cutom drop down button
class GenreDropdownMenu extends StatefulWidget {
  const GenreDropdownMenu({super.key});

  @override
  State<GenreDropdownMenu> createState() => _GenreDropdownMenuState();
}

class _GenreDropdownMenuState extends State<GenreDropdownMenu> {
  var selectedGenre;
  change(val) {
    setState(() {

      selectedGenre = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return FutureBuilder<dynamic>(
        future: GenresDatabase().getGenres(),
        builder: (context, snapshot) {
          UserProvider userProvider = Provider.of<UserProvider>(context);
          if (snapshot.hasData) {
            final List<Genres> genres = snapshot.data;

            return DropdownButton<String>(
              hint: Text('Choose A Genre',
                  style: TextStyle(color: black, fontSize: 14)),
              underline: Container(),
              items: genres
                  .map((Genres genre) => DropdownMenuItem(
                        onTap: () {
                          change(genre.genre);
                        },
                        value: genre.genre,
                        child: Text(
                          genre.genre,
                          style: TextStyle(color: black),
                        ),
                      ))
                  .toList(),
              value:
                  selectedGenre, 
              onChanged: (String? newValue) {
                setState(() {
            
                  userProvider.updatePreferredGenre(newValue!);
                  selectedGenre = newValue;
                });
              },
            );
          } else {
            return Loader();
          }
        },
      );
    });
  }
}
