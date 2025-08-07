const String workTrackingTable = 'work_tracking';

class WorkTrackingFields {
  static const String id = 'id';
  static const String serviceOfficerProfileId = 'serviceOfficerProfileId';
  static const String workTrackingId = 'workTrackingId';
  static const String workAttendanceId = 'workAttendanceId';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String accuracy = 'accuracy';
  static const String altitude = 'altitude';
  static const String heading = 'heading';
  static const String speed = 'speed';
  static const String time = 'time';
  static const String activity = 'activity';
  static const String status = 'status';
  static const String isMock = 'isMock';
  static const String batteryPercentage = 'batteryPercentage';
  static const String signalStrength = 'signalStrength';
  static const String isGpsEnabled = 'isGpsEnabled';
  static const String isWifiEnabled = 'isWifiEnabled';
  static const String isSynced = 'isSynced';
  static const String createdAt = 'createdAt';

  static const List<String> allFields = [
    id,
    serviceOfficerProfileId,
    workTrackingId,
    workAttendanceId,
    latitude,
    longitude,
    accuracy,
    altitude,
    heading,
    speed,
    time,
    activity,
    status,
    isMock,
    batteryPercentage,
    signalStrength,
    isGpsEnabled,
    isWifiEnabled,
    isSynced,
  ];
}

class WorkTracking {
  final int? id;
  final String serviceOfficerProfileId;
  final String? workTrackingId;
  final String? workAttendanceId;
  final double? latitude;
  final double? longitude;
  final double? accuracy;
  final double? altitude;
  final double? heading;
  final double? speed;
  final double? time;
  final String? activity;
  final String? status;
  final bool? isMock;
  final int? batteryPercentage;
  final int? signalStrength;
  final bool? isGpsEnabled;
  final bool? isWifiEnabled;
  final bool isSynced;
  final DateTime createdAt;

  WorkTracking({
    this.id,
    required this.serviceOfficerProfileId,
    this.workTrackingId,
    this.workAttendanceId,
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.altitude,
    this.heading,
    this.speed,
    this.time,
    this.activity,
    this.status,
    this.isMock,
    this.batteryPercentage,
    this.signalStrength,
    this.isGpsEnabled,
    this.isWifiEnabled,
    required this.isSynced,
    required this.createdAt,
  });

  WorkTracking copy({
    int? id,
    String? serviceOfficerProfileId,
    String? workTrackingId,
    String? workAttendanceId,
    double? latitude,
    double? longitude,
    double? accuracy,
    double? altitude,
    double? heading,
    double? speed,
    double? time,
    String? activity,
    String? status,
    bool? isMock,
    int? batteryPercentage,
    int? signalStrength,
    bool? isGpsEnabled,
    bool? isWifiEnabled,
    bool? isSynced,
    DateTime? createdAt,
  }) =>
      WorkTracking(
        id: id ?? this.id,
        serviceOfficerProfileId: serviceOfficerProfileId ?? this.serviceOfficerProfileId,
        workTrackingId: workTrackingId ?? this.workTrackingId,
        workAttendanceId: workAttendanceId ?? this.workAttendanceId,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        accuracy: accuracy ?? this.accuracy,
        altitude: altitude ?? this.altitude,
        heading: heading ?? this.heading,
        speed: speed ?? this.speed,
        time: time ?? this.time,
        activity: activity ?? this.activity,
        status: status ?? this.status,
        isMock: isMock ?? this.isMock,
        batteryPercentage: batteryPercentage ?? this.batteryPercentage,
        signalStrength: signalStrength ?? this.signalStrength,
        isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
        isWifiEnabled: isWifiEnabled ?? this.isWifiEnabled,
        isSynced: isSynced ?? this.isSynced ? true : false,
        createdAt: createdAt ?? DateTime.now()
      );

  factory WorkTracking.fromJson(Map<String, dynamic> json) => WorkTracking(
    id: json[WorkTrackingFields.id] as int?,
    serviceOfficerProfileId: json[WorkTrackingFields.serviceOfficerProfileId] as String,
    workTrackingId: json[WorkTrackingFields.workTrackingId] as String,
    workAttendanceId: json[WorkTrackingFields.workAttendanceId] as String,
    latitude: json[WorkTrackingFields.latitude] as double,
    longitude: json[WorkTrackingFields.longitude] as double,
    accuracy: json[WorkTrackingFields.accuracy] as double?,
    altitude: json[WorkTrackingFields.altitude] as double?,
    heading: json[WorkTrackingFields.heading] as double?,
    speed: json[WorkTrackingFields.speed] as double?,
    time: json[WorkTrackingFields.time] as double?,
    activity: json[WorkTrackingFields.activity] as String?,
    status: json[WorkTrackingFields.status] as String?,
    isMock: json[WorkTrackingFields.isMock] == 1 ? true : false,
    batteryPercentage: json[WorkTrackingFields.batteryPercentage] as int?,
    signalStrength: json[WorkTrackingFields.signalStrength] as int?,
    isGpsEnabled: json[WorkTrackingFields.isGpsEnabled] == 1 ? true : false,
    isWifiEnabled: json[WorkTrackingFields.isWifiEnabled] == 1 ? true : false,
    isSynced: (json[WorkTrackingFields.isSynced] == 1) ? true : false,
    createdAt: DateTime.parse(json[WorkTrackingFields.createdAt].toString()),
  );

  Map<String, dynamic> toJson() => {
    WorkTrackingFields.id: id,
    WorkTrackingFields.serviceOfficerProfileId: serviceOfficerProfileId,
    WorkTrackingFields.workTrackingId: workTrackingId,
    WorkTrackingFields.workAttendanceId: workAttendanceId,
    WorkTrackingFields.latitude: latitude,
    WorkTrackingFields.longitude: longitude,
    WorkTrackingFields.accuracy: accuracy,
    WorkTrackingFields.altitude: altitude,
    WorkTrackingFields.heading: heading,
    WorkTrackingFields.speed: speed,
    WorkTrackingFields.time: time,
    WorkTrackingFields.activity: activity,
    WorkTrackingFields.status: status,
    WorkTrackingFields.isMock: isMock == true ? 1 : 0,
    WorkTrackingFields.batteryPercentage: batteryPercentage,
    WorkTrackingFields.signalStrength: signalStrength,
    WorkTrackingFields.isGpsEnabled: isGpsEnabled == true ? 1 : 0,
    WorkTrackingFields.isWifiEnabled: isWifiEnabled == true ? 1 : 0,
    WorkTrackingFields.isSynced: isSynced == true ? 1 : 0,
    WorkTrackingFields.createdAt: createdAt.toIso8601String(),
  };
}
