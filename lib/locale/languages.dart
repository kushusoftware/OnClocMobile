import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';

List<LanguageDataModel> supportedLanguages() => [
  LanguageDataModel(
    id: 1,
    name: 'English',
    languageCode: 'en',
    fullLanguageCode: 'en-GB',
    flag: onClocFlagGB,
  ),
  LanguageDataModel(
    id: 2,
    name: 'French',
    languageCode: 'fr',
    fullLanguageCode: 'fr-FR',
    flag: onClocFlagFR,
  ),
];
