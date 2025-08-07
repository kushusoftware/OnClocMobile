class JobAllocationRequestFields{
    static const String serviceOfficerProfileId = 'serviceOfficerProfileId';
    static const String filterStartDate = 'filterStartDate';
    static const String filterEndDate = 'filterEndDate';

    static const List<String> allFields = [
      serviceOfficerProfileId,
      filterStartDate,
      filterEndDate,
    ];
}

class JobAllocationRequest {
  final String serviceOfficerProfileId;
  final DateTime filterStartDate;
  final DateTime filterEndDate;

  JobAllocationRequest({
    required this.serviceOfficerProfileId,
    required this.filterStartDate,
    required this.filterEndDate,
  });

  factory JobAllocationRequest.fromJson(Map<String, dynamic> json) => JobAllocationRequest(
      serviceOfficerProfileId: json[JobAllocationRequestFields.serviceOfficerProfileId] as String,
      filterStartDate: DateTime.parse(json[JobAllocationRequestFields.filterStartDate] as String),
      filterEndDate: DateTime.parse(json[JobAllocationRequestFields.filterEndDate] as String),
    );

  Map<String, dynamic> toJson() => {
      JobAllocationRequestFields.serviceOfficerProfileId: serviceOfficerProfileId,
      JobAllocationRequestFields.filterStartDate: filterStartDate.toIso8601String(),
      JobAllocationRequestFields.filterEndDate: filterEndDate.toIso8601String(),
    };
}