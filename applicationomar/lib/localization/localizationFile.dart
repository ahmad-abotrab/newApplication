import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalizations {
  final Locale locale;
  DemoLocalizations(this.locale);

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  Map<String, dynamic> localizedValue;

  Future load() async {
    String jsonStringValues =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    localizedValue = mappedJson.map((key, value) => MapEntry(key, value));
  }

  String translate(String key1, String key2, {String key3, String key4}) {
    if (key4 != null) {
      if (key3 != null) {
        return localizedValue[key1][key2][key3][key4];
      } else {
        return localizedValue[key1][key2][key4];
      }
    } else {
      if (key3 != null) {
        return localizedValue[key1][key2][key3];
      } else {
        return localizedValue[key1][key2];
      }
    }
  }

  static const LocalizationsDelegate<DemoLocalizations> delegate =
      _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const _DemoLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalizations> load(Locale locale) async {
    DemoLocalizations localizations = new DemoLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<DemoLocalizations> old) {
    return false;
  }
}
