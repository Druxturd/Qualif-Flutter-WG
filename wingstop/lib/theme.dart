import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData darkTheme = ThemeData(primarySwatch: Colors.green, brightness: Brightness.dark);

  ThemeData lightTheme = ThemeData(primarySwatch: Colors.green, brightness: Brightness.light);

  late ThemeData _currTheme;

  ThemeProvider({required bool isDark}) {
    _currTheme = isDark ? darkTheme : lightTheme;
  }

  void changeTheme
  () {
    _currTheme = _currTheme == darkTheme ? lightTheme : darkTheme;
    notifyListeners();
  }

  ThemeData get getTheme => _currTheme;
}