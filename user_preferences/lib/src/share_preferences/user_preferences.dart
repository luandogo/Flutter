import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  // Singleton
  static final UserPreferences _instance = UserPreferences._();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._();

  late SharedPreferences _preferences;

  initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // bool? _secondaryColor;
  // int? _gender;
  // String? _name;

  int get gender {
    return _preferences.getInt('gender') ?? 1;
  }

  set gender(int value) {
    _preferences.setInt('gender', value);
  }

  bool get secondaryColor {
    return _preferences.getBool('secondaryColor') ?? false;
  }

  set secondaryColor(bool value) {
    _preferences.setBool('secondaryColor', value);
  }

  String get userName {
    return _preferences.getString('userName') ?? '';
  }

  set userName(String value) {
    _preferences.setString('userName', value);
  }

  String get lastPage {
    return _preferences.getString('lastPage') ?? 'home';
  }

  set lastPage(String value) {
    _preferences.setString('lastPage', value);
  }
}
