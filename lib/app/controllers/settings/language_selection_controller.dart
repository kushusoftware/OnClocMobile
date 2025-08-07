import 'package:get/get.dart';

class OnClocLanguageSelectionController extends GetxController {
  final RxString _selectedLanguage = ''.obs;

  String get selectedLanguage => _selectedLanguage.value;
}