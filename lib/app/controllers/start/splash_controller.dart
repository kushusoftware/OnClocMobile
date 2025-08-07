import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';

class OnClocSplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() async {
    await Future.delayed(const Duration(seconds: 1));
    final connectivityResult = await (Connectivity().checkConnectivity());
    bool isAnyConnection = connectivityResult.any(
      (element) =>
          element == ConnectivityResult.mobile ||
          element == ConnectivityResult.wifi,
    );

    if (isAnyConnection) {
      await onClocSharedHelper.refreshAppSettings();
      if (getBoolAsync(isLoggedInPref)) {
        if (getBoolAsync(isDeviceVerifiedPref)) {
          // Offline Sync
          Get.offNamed(OnClocRoutes.onClocNavigationScreen);
        } else {
          Get.offNamed(OnClocRoutes.onClocDeviceVerificationScreen);
        }
      } else {
        //await offlineSync();
        Get.offNamed(OnClocRoutes.onClocLoginScreen);
      }
    } else {
      Get.toNamed(OnClocRoutes.onClocOfflineModeScreen);
    }
  }

  Future<void> offlineSync() async {
    var count = await onClocOfflineSyncService.getSyncCount();
    if (count != 0) {
      await onClocOfflineSyncService.sync();
    }
  }
}
