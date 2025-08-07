const String userActivityTable = 'user_activity';

class UserActivityFields {
  static final String id = 'id';
  static final String date = 'date';
  static final String activity = 'activity';
  static final String activityType = 'activity_type';
  static final String status = 'status';
  static final String time = 'time';

  static final List<String> allFields = [
    id, 
    date, 
    activity, 
    activityType, 
    status, 
    time
  ];

}

class OnClocUserActivity {
  final int id;
  final DateTime date;
  final String activity;
  final String activityType;
  final String status;
  final String time;

  OnClocUserActivity(
      {required this.id,
      required this.date,
      required this.activity,
      required this.activityType,
      required this.status,
      required this.time});

  factory OnClocUserActivity.fromJson(Map<String, dynamic> json) => OnClocUserActivity(
        id: json[UserActivityFields.id] as int,
        date: DateTime.parse(json[UserActivityFields.date] as String),
        activity: json[UserActivityFields.activity] as String,
        activityType: json[UserActivityFields.activityType] as String,
        status: json[UserActivityFields.status] as String,
        time: json[UserActivityFields.time] as String,
      );

  Map<String, dynamic> toJson() => {
        UserActivityFields.id: id,
        UserActivityFields.date: date.toIso8601String(),
        UserActivityFields.activity: activity,
        UserActivityFields.activityType: activityType,
        UserActivityFields.status: status,
        UserActivityFields.time: time,
      };
}