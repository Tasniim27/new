import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LocalizationService {
  final Locale locale;

  LocalizationService(this.locale);

  static LocalizationService of(BuildContext context) {
    return Localizations.of<LocalizationService>(context, LocalizationService)!;
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'mainPageTitle': 'Main Page',
      'customerListPageButton': 'Customer List',
      'customer_list': 'Customer List',
      'instructions': 'Instructions',
      'instructions_content': 'This application allows you to manage customers.',
      'english': 'English',
      'spanish': 'Spanish',
    },
    'es': {
      'mainPageTitle': 'Página Principal',
      'customerListPageButton': 'Lista de Clientes',
      'customer_list': 'Lista de Clientes',
      'instructions': 'Instrucciones',
      'instructions_content': 'Esta aplicación le permite gestionar clientes.',
      'english': 'Inglés',
      'spanish': 'Español',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class LocalizationDelegate extends LocalizationsDelegate<LocalizationService> {
  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<LocalizationService> load(Locale locale) {
    return SynchronousFuture<LocalizationService>(LocalizationService(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<LocalizationService> old) => false;
}
