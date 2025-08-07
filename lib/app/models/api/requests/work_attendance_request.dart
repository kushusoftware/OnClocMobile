class WorkAttendanceRequestFields {
  static const String serviceOfficerProfileId = 'serviceOfficerProfileId';

  static const List<String> allFields = [
    serviceOfficerProfileId
  ];
}

class WorkAttendanceRequest {
  final String serviceOfficerProfileId;

  WorkAttendanceRequest({required this.serviceOfficerProfileId});

  factory WorkAttendanceRequest.fromJson(Map<String, dynamic> json) => WorkAttendanceRequest(
        serviceOfficerProfileId:
            json[WorkAttendanceRequestFields.serviceOfficerProfileId] as String,
      );

  Map<String, dynamic> toJson() => {
    WorkAttendanceRequestFields.serviceOfficerProfileId: serviceOfficerProfileId,
  };
}
