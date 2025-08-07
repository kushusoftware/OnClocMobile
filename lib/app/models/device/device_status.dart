class DeviceStatusFields {
  static const String batteryPercentage = 'batteryPercentage';
  static const String isGpsEnabled = 'isGpsEnabled';
  static const String isWifiEnabled = 'isWifiEnabled';
  static const String signalStrength = 'signalStrength';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String isOnLine = 'isOnline';

  static const List<String> allFields = [
    batteryPercentage,
    isGpsEnabled,
    isWifiEnabled,
    isOnLine,
    signalStrength,
    latitude,
    longitude,
  ];
}

class DeviceStatus {
  final int batteryPercentage;
  final bool isGpsEnabled;
  final bool isWifiEnabled;
  final bool isOnLine;
  final int signalStrength;
  final double latitude;
  final double longitude;

  DeviceStatus({
    required this.batteryPercentage,
    required this.isGpsEnabled,
    required this.isWifiEnabled,
    required this.isOnLine,
    required this.signalStrength,
    required this.latitude,
    required this.longitude,
  });

 factory DeviceStatus.fromJson(Map<String, dynamic> json) => DeviceStatus(
      batteryPercentage: json[DeviceStatusFields.batteryPercentage],
      isGpsEnabled: json[DeviceStatusFields.isGpsEnabled],
      isWifiEnabled: json[DeviceStatusFields.isWifiEnabled],
      isOnLine: json[DeviceStatusFields.isOnLine],
      signalStrength: json[DeviceStatusFields.signalStrength],
      latitude: json[DeviceStatusFields.latitude],
      longitude: json[DeviceStatusFields.longitude],
    );

  Map<String, dynamic> toJson() => {
      DeviceStatusFields.batteryPercentage: batteryPercentage,
      DeviceStatusFields.isGpsEnabled: isGpsEnabled,
      DeviceStatusFields.isWifiEnabled: isWifiEnabled,
      DeviceStatusFields.isOnLine: isOnLine,
      DeviceStatusFields.signalStrength: signalStrength,
      DeviceStatusFields.latitude: latitude,
      DeviceStatusFields.longitude: longitude,
    };
}