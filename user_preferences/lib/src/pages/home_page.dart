import 'package:flutter/material.dart';
import 'package:user_preferences/src/share_preferences/user_preferences.dart';
import 'package:user_preferences/src/widgets/menu_widget.dart';

class HomePage extends StatelessWidget {
  static const String routeName = 'home';
  final preferences = UserPreferences();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    preferences.lastPage = HomePage.routeName;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Preferences'),
        backgroundColor:
            (preferences.secondaryColor) ? Colors.teal : Colors.blue,
      ),
      drawer: const CreateMenu(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Secondary Color: ${preferences.secondaryColor}'),
          Divider(),
          Text('Gender: ${preferences.gender}'),
          Divider(),
          Text('User Name: ${preferences.userName}'),
          Divider(),
        ],
      ),
    );
  }
}
