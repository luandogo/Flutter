import 'package:flutter/material.dart';

import 'package:user_preferences/src/share_preferences/user_preferences.dart';
import 'package:user_preferences/src/widgets/menu_widget.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = 'settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final preferences = UserPreferences();

  late String _name;
  late int _gender;
  late bool _secondaryColor;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    preferences.lastPage = SettingsPage.routeName;
    _gender = preferences.gender;
    _secondaryColor = preferences.secondaryColor;
    _textController = TextEditingController(text: preferences.userName);
  }

  _setSelectedRadio(int? value) {
    preferences.gender = value as int;
    _gender = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CreateMenu(),
        appBar: AppBar(
          title: Text('Settings'),
          backgroundColor:
              (preferences.secondaryColor) ? Colors.teal : Colors.blue,
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              child: const Text(
                'Settings',
                style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            SwitchListTile(
              value: _secondaryColor,
              title: Text('Secondary Color: ${preferences.secondaryColor}'),
              onChanged: (value) {
                setState(() {
                  _secondaryColor = value;
                  preferences.secondaryColor = value;
                });
              },
            ),
            RadioListTile(
                value: 1,
                title: const Text('Male'),
                groupValue: _gender,
                onChanged: _setSelectedRadio),
            RadioListTile(
                value: 2,
                title: const Text('Female'),
                groupValue: _gender,
                onChanged: _setSelectedRadio),
            const Divider(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                    labelText: 'Name', helperText: "User's name"),
                onChanged: (value) {
                  setState(() {
                    preferences.userName = value;
                  });
                },
              ),
            )
          ],
        ));
  }
}
