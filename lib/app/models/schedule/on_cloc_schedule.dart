class ScheduleFields {
  static const String id = 'id';
  static const String title = 'title';
  static const String description = 'description';
  static const String startDate = 'startDate';
  static const String endDate = 'endDate';
  static const String status = 'status';
  static const String clientName = 'clientName';
  static const String address = 'address';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';

  static const List<String> allFields = [
    id,
    title,
    description,
    startDate,
    endDate,
    status,
    clientName,
    address,
    latitude,
    longitude,
  ];
}

class OnClocSchedule {
  final String? title;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? status;
  final String? clientName;
  final String? address;
  final double? latitude;
  final double? longitude;

  OnClocSchedule(
      {this.title,
      this.description,
      this.startDate,
      this.endDate,
      this.status,
      this.clientName,
      this.address,
      this.latitude,
      this.longitude});

  factory OnClocSchedule.fromJson(Map<String, dynamic> json) => OnClocSchedule(
        title: json[ScheduleFields.title] as String?,
        description: json[ScheduleFields.description] as String?,
        startDate: json[ScheduleFields.startDate] as String?,
        endDate: json[ScheduleFields.endDate] as String?,
        status: json[ScheduleFields.status] as String?,
        clientName: json[ScheduleFields.clientName] as String?,
        address: json[ScheduleFields.address] as String?,
        latitude: (json[ScheduleFields.latitude] as num?)?.toDouble(),
        longitude: (json[ScheduleFields.longitude] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        ScheduleFields.title: title,
        ScheduleFields.description: description,
        ScheduleFields.startDate: startDate,
        ScheduleFields.endDate: endDate,
        ScheduleFields.status: status,
        ScheduleFields.clientName: clientName,
        ScheduleFields.address: address,
        ScheduleFields.latitude: latitude,
        ScheduleFields.longitude: longitude,
      };
}
