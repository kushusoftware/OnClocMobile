import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/locale/locale_key.dart';
import 'package:on_cloc_mobile/locale/language_en.dart';
import 'package:on_cloc_mobile/locale/language_fr.dart';

class OnClocLocalization extends LocalizationsDelegate<OnClocLocaleKey> {
  const OnClocLocalization();

  @override
  Future<OnClocLocaleKey> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguaugeEn();
      case 'fr':
        return LanguageFr();
      default:
        return LanguaugeEn();
    }
  }

  @override
  bool isSupported(Locale locale) => LanguageDataModel.languages().contains(locale.languageCode);

  @override
  bool shouldReload(covariant LocalizationsDelegate<OnClocLocaleKey> old) => false;
}