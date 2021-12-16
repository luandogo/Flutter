import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;
  bool _pressedButton1 = false;
  bool _pressedButton2 = false;
  bool _pressedButton3 = false;
  bool _copiedIcon = false;
  String _createQR = '';
  String _changeName = '';
  String _changeNameScanModel = '';
  TextEditingController _clearController = TextEditingController();
  TextEditingController _changeNameController = TextEditingController();

  int get selectedMenuOpt {
    return _selectedMenuOpt;
  }

  set selectedMenuOpt(int index) {
    _selectedMenuOpt = index;
    notifyListeners();
  }

  bool get pressedButton1 {
    return _pressedButton1;
  }

  set pressedButton1(bool pressed) {
    _pressedButton1 = pressed;
    notifyListeners();
  }

  bool get pressedButton2 {
    return _pressedButton2;
  }

  set pressedButton2(bool pressed) {
    _pressedButton2 = pressed;
    notifyListeners();
  }

  bool get pressedButton3 {
    return _pressedButton3;
  }

  set pressedButton3(bool pressed) {
    _pressedButton3 = pressed;
    notifyListeners();
  }

  bool get copiedIcon {
    return _copiedIcon;
  }

  set copiedIcon(bool pressed) {
    _copiedIcon = pressed;
    notifyListeners();
  }

  String get createQR {
    return _createQR;
  }

  set createQR(String qr) {
    _createQR = qr;
    notifyListeners();
  }

  String get changeName {
    return _changeName;
  }

  set changeName(String name) {
    _changeName = name;
    notifyListeners();
  }

  String get changeNameScanModel {
    return _changeNameScanModel;
  }

  set changeNameScanModel(String name) {
    _changeNameScanModel = name;
    notifyListeners();
  }

  TextEditingController get clearController {
    return _clearController;
  }

  set clearController(TextEditingController controller) {
    _clearController = controller;
    notifyListeners();
  }

  TextEditingController get changeNameController {
    return _changeNameController;
  }

  set changeNameController(TextEditingController controller) {
    _changeNameController = controller;
    notifyListeners();
  }
}
