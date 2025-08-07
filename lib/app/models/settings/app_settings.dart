import 'package:nb_utils/nb_utils.dart';

class AppSettingsFields {
  static const String appVersion = 'appVersion';
  static const String locationUpdateIntervalType = 'locationUpdateIntervalType';
  static const String locationUpdateInterval = 'locationUpdateInterval';
  static const String currency = 'currency';
  static const String currencySymbol = 'currencySymbol';
  static const String distanceUnit = 'distanceUnit';
  static const String countryPhoneCode = 'countryPhoneCode';
  static const String privacyPolicyUrl = 'privacyPolicyUrl';
  static const String termsOfUseUrl = 'termsOfUseUrl';

  static const List<String> allFields = [
    appVersion,
    locationUpdateIntervalType,
    locationUpdateInterval,
    currency,
    currencySymbol,
    distanceUnit,
    countryPhoneCode,
    privacyPolicyUrl,
    termsOfUseUrl,
  ];
}

class OnClocAppSettings {
  final String? appVersion;
  final String? locationUpdateIntervalType;
  final double? locationUpdateInterval;
  final String? currency;
  final String? currencySymbol;
  final String? distanceUnit;
  final String? countryPhoneCode;
  final String? privacyPolicyUrl;
  final String? termsOfUseUrl;

  OnClocAppSettings({
    this.appVersion,
    this.locationUpdateIntervalType,
    this.locationUpdateInterval,
    this.currency,
    this.currencySymbol,
    this.distanceUnit,
    this.countryPhoneCode,
    this.privacyPolicyUrl,
    this.termsOfUseUrl,
  });

  factory OnClocAppSettings.fromJson(Map<String, dynamic> json) =>
      OnClocAppSettings(
        appVersion: json[AppSettingsFields.appVersion] as String?,
        locationUpdateIntervalType:
            json[AppSettingsFields.locationUpdateIntervalType] as String?,
        locationUpdateInterval:
            (json[AppSettingsFields.locationUpdateInterval] as String?).toDouble(),
        currency: json[AppSettingsFields.currency] as String?,
        currencySymbol: json[AppSettingsFields.currencySymbol] as String?,
        distanceUnit: json[AppSettingsFields.distanceUnit] as String?,
        countryPhoneCode: json[AppSettingsFields.countryPhoneCode] as String?,
        privacyPolicyUrl: json[AppSettingsFields.privacyPolicyUrl] as String?,
        termsOfUseUrl: json[AppSettingsFields.termsOfUseUrl] as String?,
      );

  Map<String, dynamic> toJson() => {
    AppSettingsFields.appVersion: appVersion,
    AppSettingsFields.locationUpdateIntervalType: locationUpdateIntervalType,
    AppSettingsFields.locationUpdateInterval: locationUpdateInterval,
    AppSettingsFields.currency: currency,
    AppSettingsFields.currencySymbol: currencySymbol,
    AppSettingsFields.distanceUnit: distanceUnit,
    AppSettingsFields.countryPhoneCode: countryPhoneCode,
    AppSettingsFields.privacyPolicyUrl: privacyPolicyUrl,
    AppSettingsFields.termsOfUseUrl: termsOfUseUrl,
  };
}
