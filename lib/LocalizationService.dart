import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class LocalizationService {
  static Map<String, String>? _localizedStrings;
  static Locale _locale = const Locale('en', 'US');

  static Future<void> load(Locale locale) async {
    _locale = locale;
    String jsonString = await rootBundle.loadString('assets/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  static String? translate(String key) {
    return _localizedStrings?[key];
  }

  static Locale get locale => _locale;
}
