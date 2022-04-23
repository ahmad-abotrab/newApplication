import '/localization/localizationFile.dart';


import 'package:flutter/cupertino.dart';

class Language {
  final int id;
  final String name;
  final String flag;
  final String languageCode;
  Language(this.id, this.name, this.flag, this.languageCode);

  static List<Language> langList(BuildContext context) {
    return <Language>[
      Language(
          1, '🇸🇾', DemoLocalizations.of(context).translate("LoginPage",'Lang_1'), 'ar'),
      Language(
          2, '🇺🇸', DemoLocalizations.of(context).translate("LoginPage",'Lang_2'), 'en')
    ];
  }
}
