class ServiceDeskFields {
  static const String serviceDeskId = 'serviceDeskId';
  static const String name = 'name';
  static const String description = 'description';
  static const String serviceDeskMemberId = 'serviceDeskMemberId';

  static const List<String> allFields = <String>[
    serviceDeskId,
    name,
    description,
    serviceDeskMemberId,
  ];
}

class ServiceDesk {
  final int serviceDeskId;
  final String name;
  final String description;
  final String serviceDeskMemberId;

  ServiceDesk({
    required this.serviceDeskId,
    required this.name,
    required this.description,
    required this.serviceDeskMemberId,
  });

  factory ServiceDesk.fromJson(Map<String, dynamic> json) => ServiceDesk(
        serviceDeskId: (json[ServiceDeskFields.serviceDeskId] as num).toInt(),
        name: (json[ServiceDeskFields.name] as String).toString(),
        description: (json[ServiceDeskFields.description] as String).toString(),
        serviceDeskMemberId: (json[ServiceDeskFields.serviceDeskMemberId] as String).toString(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        ServiceDeskFields.serviceDeskId: serviceDeskId,
        ServiceDeskFields.name: name,
        ServiceDeskFields.description: description,
        ServiceDeskFields.serviceDeskMemberId: serviceDeskMemberId,
      };
}