class VerifyDeviceRequestFields {
  static const String deviceUuid = 'deviceUuid';
  static const String deviceType = 'deviceType';

  static const List<String> allFields = [
    deviceUuid,
    deviceType
    ];
}

class VerifyDeviceRequest {
  final String deviceUuid;
  final String? deviceType;

  VerifyDeviceRequest({
    required this.deviceUuid, 
    this.deviceType});

  factory VerifyDeviceRequest.fromJson(Map<String, dynamic> json) =>
      VerifyDeviceRequest(
        deviceUuid: json[VerifyDeviceRequestFields.deviceUuid] as String,
        deviceType: json[VerifyDeviceRequestFields.deviceType] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        VerifyDeviceRequestFields.deviceUuid: deviceUuid,
        VerifyDeviceRequestFields.deviceType: deviceType,
      };
}