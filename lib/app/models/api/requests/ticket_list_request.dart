class TicketListRequestFields {
  static const String serviceOfficerProfileId = 'serviceOfficerProfileId';
  static const String filterStartDate = 'filterStartDate';
  static const String filterEndDate = 'filterEndDate';

  static List<String> get allFields => [
    serviceOfficerProfileId,
    filterStartDate,
    filterEndDate,
    ];
}

class TicketListRequest {
  final String serviceOfficerProfileId;
  final DateTime filterStartDate;
  final DateTime filterEndDate;

  TicketListRequest({
    required this.serviceOfficerProfileId,
    required this.filterStartDate,
    required this.filterEndDate,
    });

  factory TicketListRequest.fromJson(Map<String, dynamic> json) => TicketListRequest(
      serviceOfficerProfileId: json[TicketListRequestFields.serviceOfficerProfileId] as String,
      filterStartDate: DateTime.parse(json[TicketListRequestFields.filterStartDate] as String),
      filterEndDate: DateTime.parse(json[TicketListRequestFields.filterEndDate] as String),
    );

  Map<String, dynamic> toJson() => {
      TicketListRequestFields.serviceOfficerProfileId: serviceOfficerProfileId,
      TicketListRequestFields.filterStartDate: filterStartDate.toIso8601String(),
      TicketListRequestFields.filterEndDate: filterEndDate.toIso8601String(),
    };
}