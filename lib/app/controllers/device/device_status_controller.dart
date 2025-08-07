import 'package:get/get.dart';

class OnClocDeviceStatusController extends GetxController {
  int locationCount = 0, activityCount = 0;
  String locationStatus = '', backgroundStatus = '', locationUpdateDuration = '', trackingStartedAt = '';

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() async {
    // Initialize your variables and fetch data here
  }
}