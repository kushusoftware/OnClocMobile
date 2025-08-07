class VerifyDeviceResponseFields{
  static const String deviceUuid = 'deviceUuid';
  static const String isRegistared = 'isRegistered';
  static const String isEnabled = 'isEnabled';

  static const List<String> allFields = [
    deviceUuid, 
    isRegistared, 
    isEnabled];
}
class VerifyDeviceResponse {
  final String deviceUuid;
  final bool isRegistered;
  final bool isEnabled;

  VerifyDeviceResponse({
    required this.deviceUuid,
    required this.isRegistered,
    required this.isEnabled});

  factory VerifyDeviceResponse.fromJson(Map<String, dynamic> json) =>
      VerifyDeviceResponse(
        deviceUuid: json[VerifyDeviceResponseFields.deviceUuid].toString(),
        isRegistered: json[VerifyDeviceResponseFields.isRegistared] as bool,
        isEnabled: json[VerifyDeviceResponseFields.isEnabled] as bool,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        VerifyDeviceResponseFields.deviceUuid: deviceUuid,
        VerifyDeviceResponseFields.isRegistared: isRegistered,
        VerifyDeviceResponseFields.isEnabled: isEnabled,
      };
}