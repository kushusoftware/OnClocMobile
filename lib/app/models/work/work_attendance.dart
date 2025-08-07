class WorkAttendanceFields {
  static const String status = 'status';
  static const String checkInAt = 'checkInAt';
  static const String checkOutAt = 'checkOutAt';
  static const String userStatus = 'userStatus';
  static const String shiftStartAt = 'shiftStartTime';
  static const String shiftEndAt = 'shiftEndTime';
  static const String isLate = 'isLate';
  static const String isOnLeave = 'isOnLeave';
  static const String isOnBreak = 'isOnBreak';
  static const String breakStartedAt = 'breakStartedAt';
  static const String travelledDistance = 'travelledDistance';
  static const String attendanceType = 'attendanceType';
  static const String trackedHours = 'trackedHours';
  static const String isSiteEmployee = 'isSiteEmployee';
  static const String siteName = 'siteName';
  static const String siteAttendanceType = 'siteAttendanceType';

  static const List<String> allFields = [
    status,
    checkInAt,
    checkOutAt,
    userStatus,
    shiftStartAt,
    shiftEndAt,
    isLate,
    isOnLeave,
    isOnBreak,
    breakStartedAt,
    travelledDistance,
    attendanceType,
    trackedHours,
    isSiteEmployee,
    siteName,
    siteAttendanceType
  ];
}

class WorkAttendance {
  final String? status;
  final String? checkInAt;
  final String? checkOutAt;
  final String? userStatus;
  final String? shiftStartAt;
  final String? shiftEndAt;
  final bool? isLate;
  final bool? isOnLeave;
  final bool? isOnBreak;
  final String? breakStartedAt;
  final num? travelledDistance;
  final String? attendanceType;
  final num? trackedHours;
  final bool? isSiteEmployee;
  final String? siteName;
  final String? siteAttendanceType;

  WorkAttendance(
      {this.status,
      this.checkInAt,
      this.checkOutAt,
      this.userStatus,
      this.shiftStartAt,
      this.shiftEndAt,
      this.isLate,
      this.isOnLeave,
      this.isOnBreak,
      this.breakStartedAt,
      this.travelledDistance,
      this.trackedHours,
      this.attendanceType,
      this.isSiteEmployee,
      this.siteName,
      this.siteAttendanceType});

  factory WorkAttendance.fromJson(Map<String, dynamic> json) =>
      WorkAttendance(
        status: json[WorkAttendanceFields.status] as String?,
        checkInAt: json[WorkAttendanceFields.checkInAt] as String?,
        checkOutAt: json[WorkAttendanceFields.checkOutAt] as String?,
        userStatus: json[WorkAttendanceFields.userStatus] as String?,
        shiftStartAt: json[WorkAttendanceFields.shiftStartAt] as String?,
        shiftEndAt: json[WorkAttendanceFields.shiftEndAt] as String?,
        isLate: json[WorkAttendanceFields.isLate] as bool?,
        isOnLeave: json[WorkAttendanceFields.isOnLeave] as bool?,
        isOnBreak: json[WorkAttendanceFields.isOnBreak] as bool?,
        breakStartedAt: json[WorkAttendanceFields.breakStartedAt] as String?,
        travelledDistance:
            (json[WorkAttendanceFields.travelledDistance] as num?)?.toDouble(),
        attendanceType: json[WorkAttendanceFields.attendanceType] as String?,
        trackedHours:
            (json[WorkAttendanceFields.trackedHours] as num?)?.toDouble(),
        isSiteEmployee: json[WorkAttendanceFields.isSiteEmployee] as bool?,
        siteName: json[WorkAttendanceFields.siteName] as String?,
        siteAttendanceType:
            json[WorkAttendanceFields.siteAttendanceType] as String?,
      );

  Map<String, dynamic> toJson() => {
        WorkAttendanceFields.status: status,
        WorkAttendanceFields.checkInAt: checkInAt,
        WorkAttendanceFields.checkOutAt: checkOutAt,
        WorkAttendanceFields.userStatus: userStatus,
        WorkAttendanceFields.shiftStartAt: shiftStartAt,
        WorkAttendanceFields.shiftEndAt: shiftEndAt,
        WorkAttendanceFields.isLate: isLate,
        WorkAttendanceFields.isOnLeave: isOnLeave,
        WorkAttendanceFields.isOnBreak: isOnBreak,
        WorkAttendanceFields.breakStartedAt: breakStartedAt,
        WorkAttendanceFields.travelledDistance: travelledDistance,
        WorkAttendanceFields.attendanceType: attendanceType,
        WorkAttendanceFields.trackedHours: trackedHours,
        WorkAttendanceFields.isSiteEmployee: isSiteEmployee,
        WorkAttendanceFields.siteName: siteName,
        WorkAttendanceFields.siteAttendanceType: siteAttendanceType,
      };
}