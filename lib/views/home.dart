
import 'package:flutter/material.dart';
import 'package:streamer/utils/colors.dart';
import 'package:streamer/views/widgets/buttons.dart';
import 'package:streamer/views/widgets/scaffold.dart';
import 'package:streamer/views/widgets/welcome_alert.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dialog(context) {
    return showDialog(
        context: (context),
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('Welcome')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Select Genre:',
                          style: TextStyle(fontSize: 18),
                        ),
                        
                        SizedBox(height: 10),
                        GenreDropdownWidget(), 
                        SizedBox(height: 20),
                        /*Text(
                'Selected Genre: ${selectedGenre ?? 'None'}',
                style: TextStyle(fontSize: 16),
              ),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Home',
      body: Center(
        child: ConfirmButton(onPress: () {
          dialog(context);
        }),
      ),
      footer: Container(
        height: 10,
        color: red,
      ),
    );
  }
}
