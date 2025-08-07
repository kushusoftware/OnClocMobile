import 'package:battery_plus/battery_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/models/api/requests/register_device_request.dart';
import 'package:on_cloc_mobile/app/models/api/requests/verify_device_request.dart';
import 'package:on_cloc_mobile/app/models/device/device_identity.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';

class OnClocDeviceVerificationController extends GetxController {
  RxBool isLoading = false.obs;

  Rx<DeviceVerificationStatus> deviceStatus =
      DeviceVerificationStatus.verifying.obs;

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future init() async {
    deviceStatus.value = DeviceVerificationStatus.verifying;
    await verifyDevice();
  }

  Future verifyDevice() async {
    await Future.delayed(const Duration(seconds: 3));
    DeviceIdentity device = await onClocSharedHelper.getDeviceId();
    VerifyDeviceRequest request = VerifyDeviceRequest(
      deviceUuid: device.uuid!,
      deviceType: platformName().toLowerCase(),
    );
    await setValue(isDeviceVerifiedPref, false);
    var response = await onClocApiService.verifyDevice(request);
    if (response.isRegistered && response.isEnabled) {
      deviceStatus.value = DeviceVerificationStatus.verified;
      await setValue(isDeviceVerifiedPref, true);
      toast(onClocLocale.lblVerificationCompleted);
    } else if (!response.isRegistered && response.isEnabled) {
      deviceStatus.value = DeviceVerificationStatus.notRegistered;
    } else if (response.isRegistered && !response.isEnabled) {
      deviceStatus.value = DeviceVerificationStatus.alreadyRegistered;
      toast(onClocLocale.lblDeviceRegistrationDisabled);
    } else {
      deviceStatus.value = DeviceVerificationStatus.failed;
      toast(onClocLocale.lblUnableToCheckDeviceStatus);
    }
  }

  Future registerDevice() async {
    isLoading.value = true;
    var battery = Battery();
    var connectivityResult = await (Connectivity().checkConnectivity());
    bool isGpsEnabled = await Geolocator.isLocationServiceEnabled();
    bool isWifiEnabled = connectivityResult.any((e) => e == ConnectivityResult.wifi);
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
    DeviceIdentity deviceIdentity = await onClocSharedHelper.getDeviceId();
    if (deviceIdentity.uuid == 'unknown') {
      toast('Unable to get device id');
      isLoading.value = false;
      return;
    }

    try {
      RegisterDeviceRequest request = RegisterDeviceRequest(
        uuid: deviceIdentity.uuid,
        name: deviceIdentity.name,
        type: deviceIdentity.type,
        manufacturer: deviceIdentity.manufacturer,
        product: deviceIdentity.product,
        brand: deviceIdentity.brand,
        model: deviceIdentity.model,
        board: deviceIdentity.board,
        version: deviceIdentity.version,
        serialNumber: deviceIdentity.serialNumber,
        sdkVersion: deviceIdentity.sdkVersion,
        osName: deviceIdentity.osName,
        osVersion: deviceIdentity.osVersion,
        batteryPercentage: await battery.batteryLevel,
        isGpsEnabled: isGpsEnabled,
        isWifiEnabled: isWifiEnabled,
        signalStrength: 5,
        latitude: position.latitude,
        longitude: position.longitude,
      );
      // Register Device
      var response = await onClocApiService.registerDevice(request);
      if (response) {
        isLoading.value = false;
        await setValue(isDeviceVerifiedPref, true);
        toast(onClocLocale.lblDeviceRegisteredSuccessfully);
        onClocSharedHelper.login();
      } else {
        toast(onClocLocale.lblUnableToRegisterDevice);
      }
    } catch (e) {
      log(e.toString());
    }
    isLoading.value = false;
  }
}

enum DeviceVerificationStatus {
  pending,
  verifying,
  verified,
  alreadyRegistered,
  notRegistered,
  failed,
}
