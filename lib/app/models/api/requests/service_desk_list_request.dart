class ServiceDeskListRequestFields {
  static const String serviceOfficerProfileId = 'serviceOfficerProfileId';

  static const List<String> allFields = [
    serviceOfficerProfileId,
  ];
}

class ServiceDeskListRequest {
  final String serviceOfficerProfileId;

  ServiceDeskListRequest({
    required this.serviceOfficerProfileId,
  });

  factory ServiceDeskListRequest.fromJson(Map<String, dynamic> json) => ServiceDeskListRequest(
      serviceOfficerProfileId: json[ServiceDeskListRequestFields.serviceOfficerProfileId] as String,
    );
  
  Map<String, dynamic> toJson() => {
        ServiceDeskListRequestFields.serviceOfficerProfileId: serviceOfficerProfileId,
      };
}