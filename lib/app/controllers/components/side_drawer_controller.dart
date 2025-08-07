import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/controllers/theme/theme_controller.dart';

class OnClocSideDrawerController extends GetxController {
  final OnClocThemeController themeController = Get.put(OnClocThemeController());

  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = themeController.isDarkMode;
  }
}