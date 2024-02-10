import 'package:flutter/material.dart';

class AppLocale extends ChangeNotifier {
  Locale _currentLocale;

  AppLocale(this._currentLocale);

  Locale get currentLocale => _currentLocale;

  void changeLocale(Locale newLocale) {
    _currentLocale = newLocale;
    notifyListeners();
  }
}
