import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/models/device/device_identity.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/app/models/settings/app_settings.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';
import 'package:package_info_plus/package_info_plus.dart';

class OnClocSharedHelper {
  void login() async {
    // Login Logic
    bool isLoggedIn = getBoolAsync(isLoggedInPref, defaultValue: false);
    if (isLoggedIn) {
      Get.offNamedUntil(OnClocRoutes.onClocNavigationScreen, (route) => route.isFirst);
    } else {
      logout();
    }
  }

  void logout() async {
    clearSharedPref();
    Get.offNamedUntil(OnClocRoutes.onClocLoginScreen, (route) => route.isFirst);
    toast(onClocLocale.lblLoggedOutSuccessfully);
  }

  Future<DeviceIdentity> getDeviceId() async {
    // Get the device ID based on the platform (Android, iOS, Web).
    var deviceIdentity = DeviceIdentity();
    deviceIdentity.type = platformName().toLowerCase();
    final deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo deviceInfo = await deviceInfoPlugin.androidInfo;
      deviceIdentity.uuid = deviceInfo.id;
      deviceIdentity.name = deviceInfo.device;
      deviceIdentity.manufacturer = deviceInfo.manufacturer;
      deviceIdentity.product = deviceInfo.product;
      deviceIdentity.brand = deviceInfo.brand;
      deviceIdentity.model = deviceInfo.model;
      deviceIdentity.board = deviceInfo.board;
      deviceIdentity.version = deviceInfo.version.release;
      deviceIdentity.serialNumber = deviceInfo.serialNumber;
      deviceIdentity.sdkVersion = deviceInfo.version.sdkInt.toString();
      deviceIdentity.osName = deviceInfo.type;
      deviceIdentity.osVersion = deviceInfo.version.codename;
    } else if (Platform.isIOS) {
      IosDeviceInfo deviceInfo = await deviceInfoPlugin.iosInfo;
      deviceIdentity.uuid = deviceInfo.identifierForVendor ?? 'unknown';
      deviceIdentity.name = deviceInfo.name;
      deviceIdentity.manufacturer = deviceInfo.utsname.machine;
      deviceIdentity.product = deviceInfo.utsname.release;
      deviceIdentity.brand = deviceInfo.utsname.sysname;
      deviceIdentity.model = deviceInfo.utsname.version;
      deviceIdentity.board = deviceInfo.utsname.nodename;
      deviceIdentity.version = deviceInfo.systemVersion;
      deviceIdentity.serialNumber = deviceInfo.utsname.nodename;
      deviceIdentity.sdkVersion = deviceInfo.systemVersion;
      deviceIdentity.osName = deviceInfo.utsname.sysname;
      deviceIdentity.osVersion = deviceInfo.utsname.release;
    } 
    return deviceIdentity;
  }

  Future<String> getAppVersionString() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    return 'version $version ($buildNumber)';
  }

  String getFullName() {
    return '${getStringAsync(firstNamePref)} ${getStringAsync(lastNamePref)}';
  }

  String getPhoneNumber() {
    return getStringAsync(phoneNumberPref);
  }

  int getUpdateInterval() {
    var interval = getIntAsync(locationUpdateIntervalPref);
    return interval == 0 ? 30 : interval;
  }

  bool isSettingsRefreshed() {
    return getBoolAsync(isSettingsRefreshedPref);
  }

  Duration getUpdateIntervalDuration() {
    var interval = getUpdateInterval();

    var type = getStringAsync(locationUpdateIntervalTypePref);
    log('Location update interval value is $interval type is $type');
    if (type == '') {
      return Duration(seconds: interval);
    } else {
      return type == 's'
          ? Duration(seconds: interval)
          : Duration(minutes: interval);
    }
  }

  Future<bool> refreshAppSettings() async {
    var appSettings = await onClocApiService.getAppSettings();
    bool isRefreshed = (appSettings != null);
    if (isRefreshed) {
      setAppSettings(appSettings);
    }
    return isRefreshed;
  }

  void setAppSettings(OnClocAppSettings settings) {
    setValue(appVersionPref, settings.appVersion);
    setValue(
      locationUpdateIntervalTypePref,
      settings.locationUpdateIntervalType,
    );
    setValue(locationUpdateIntervalPref, settings.locationUpdateInterval);
    setValue(appCurrencySymbolPref, settings.currencySymbol);
    setValue(appDistanceUnitPref, settings.distanceUnit);
    setValue(appCountryPhoneCodePref, settings.countryPhoneCode);
    setValue(privacyPolicyUrlPref, settings.privacyPolicyUrl);
    setValue(termsOfUseUrlPref, settings.termsOfUseUrl);
    setValue(isSettingsRefreshedPref, true);
  }
}
