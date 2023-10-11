import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamer/services/auth.dart';
import 'package:streamer/services/provider_service.dart';
import 'package:streamer/utils/colors.dart';
import 'package:streamer/utils/constants.dart';
import 'package:streamer/views/widgets/buttons.dart';
import 'package:streamer/views/widgets/text_fields.dart';

class FirstLaunch extends StatefulWidget {
  const FirstLaunch({super.key});

  @override
  State<FirstLaunch> createState() => _FirstLaunchState();
}

class _FirstLaunchState extends State<FirstLaunch> {
  late TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    FirstLaunchProvider launchProvider = Provider.of<FirstLaunchProvider>(context);

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: white,
      child: AlertDialog(
        elevation: 10,
        title: Center(
            child: Text(
          'Welcome to $app_title',
          style: TextStyle(fontSize: 16),
        )),
        content: SingleChildScrollView(
          child: Column(
            children: [
              GenreDropdownMenu(),
              CustomTextField(
                hint: 'Name',
                textController: textController,
              ),
              ConfirmButton(onPress: () {
                
                  userProvider.updateId(auth!.uid);
                  userProvider.updateName(textController.text);
                  launchProvider.updateLaunch('true');
                  //TODO store in sqflite database
                 
            
              })
            ],
          ),
        ),
      ),
    );
  }
}
