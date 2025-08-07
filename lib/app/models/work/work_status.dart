class WorkStatusFields {
  static const String status = 'string';
  static const String accuracy = 'accuracy';
  static const String activity = 'activity';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String altitude = 'altitude';
  static const String heading = 'heading';
  static const String locationAccuracy= 'locationAccuracy';
  static const String speed = 'speed';
  static const String time = 'time';
  static const String isMock = 'isMock';
  static const String batteryPercentage = 'batteryPercentage';
  static const String isGpsEnabled = 'isGpsEnabled';
  static const String isWifiEnabled = 'isWifiEnabld';
  static const String signalStrength = 'signalStrength';
  
   static const List<String> allFields = [
    status,
    accuracy,
    activity,
    latitude,
    longitude,
    altitude,
    heading,
    locationAccuracy,
    speed,
    time,
    isMock,
    batteryPercentage,
    isGpsEnabled,
    isWifiEnabled,
    signalStrength
  ];
}

class WorkStatus {
  final String status;
  final int accuracy;
  final String activity;
  final double latitude;
  final double longitude;
  final double altitude;
  final double heading;
  final double locationAccuracy;
  final double speed;
  final int time;
  final bool isMock;
  final int batteryPercentage;
  final bool isGpsEnabled;
  final bool isWifiEnabled;
  final int signalStrength;

  WorkStatus({
    required this.status,
    required this.accuracy,
    required this.activity,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.heading,
    required this.locationAccuracy,
    required this.speed,
    required this.time,
    required this.isMock,
    required this.batteryPercentage,
    required this.isGpsEnabled,
    required this.isWifiEnabled,
    required this.signalStrength
  });

  factory WorkStatus.fromJson(Map<String, dynamic> json) => 
    WorkStatus(
      status: json[WorkStatusFields.status] as String, 
      accuracy: (json[WorkStatusFields.accuracy] as num).toInt(), 
      activity: json[WorkStatusFields.activity] as String, 
      latitude: (json[WorkStatusFields.latitude] as num).toDouble(), 
      longitude: (json[WorkStatusFields.longitude] as num).toDouble(), 
      altitude: (json[WorkStatusFields.altitude] as num).toDouble(), 
      heading: (json[WorkStatusFields.heading] as num).toDouble(), 
      locationAccuracy: (json[WorkStatusFields.locationAccuracy] as num).toDouble(), 
      speed: (json[WorkStatusFields.speed] as num).toDouble(), 
      time: (json[WorkStatusFields.time] as num).toInt(), 
      isMock: json[WorkStatusFields.isMock] as bool, 
      batteryPercentage: (json[WorkStatusFields.batteryPercentage] as num).toInt(), 
      isGpsEnabled: json[WorkStatusFields.isGpsEnabled] as bool, 
      isWifiEnabled: json[WorkStatusFields.isWifiEnabled] as bool, 
      signalStrength: (json[WorkStatusFields.signalStrength] as num).toInt()
    );

  Map<String, dynamic> toJson() => 
    {
      WorkStatusFields.status: status, 
      WorkStatusFields.accuracy: accuracy, 
      WorkStatusFields.activity: activity, 
      WorkStatusFields.latitude: latitude, 
      WorkStatusFields.longitude: longitude, 
      WorkStatusFields.altitude: altitude, 
      WorkStatusFields.heading: heading, 
      WorkStatusFields.locationAccuracy: locationAccuracy, 
      WorkStatusFields.speed: speed, 
      WorkStatusFields.time: time, 
      WorkStatusFields.isMock: isMock, 
      WorkStatusFields.batteryPercentage: batteryPercentage, 
      WorkStatusFields.isGpsEnabled: isGpsEnabled, 
      WorkStatusFields.isWifiEnabled: isWifiEnabled,
      WorkStatusFields.signalStrength: signalStrength
    };
}