import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/main.dart';

class OnClocSettingsController extends GetxController {
  void refreshAppSettings() async {
    await Future.delayed(const Duration(seconds: 1));
    await onClocSharedHelper.refreshAppSettings().then((value) {
      if (value) {
        toast(onClocLocale.lblAppSettingsRefreshedSuccessfully);
      } else {
        toast(onClocLocale.lblFailedToRefreshAppSettings);
      }
    });
  }
  
}