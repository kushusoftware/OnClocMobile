class ClientProfileFields {
  static const String clientProfileId = 'clientProfileId';
  static const String clientName = 'clientName';
  static const String avatarUrl = 'avatarUrl';
  static const String address = 'address';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String phoneNumber = 'phoneNumber';
  static const String contactPerson = 'contactPerson';
  static const String email = 'email';
  static const String city = 'city';
  static const String status = 'status';

  static const List<String> allFields = [
    clientProfileId,
    clientName,
    avatarUrl,
    address,
    latitude,
    longitude,
    phoneNumber,
    contactPerson,
    email,
    city,
    status,
  ];
}

class ClientProfile{
  final String clientProfileId;
  final String clientName;
  final String avatarUrl;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? phoneNumber;
  final String? contactPerson;
  final  String? email;
  final String? city;
  final String? status;

  ClientProfile({
    required this.clientProfileId,
    required this.clientName,
    required this.avatarUrl,
    this.address,
    this.latitude,
    this.longitude,
    this.phoneNumber,
    this.contactPerson,
    this.email,
    this.city,
    this.status
});

  factory ClientProfile.fromJson(Map<String, dynamic> json) => ClientProfile(
        clientProfileId: json[ClientProfileFields.clientProfileId] as String,
        clientName: json[ClientProfileFields.clientName] as String,
        avatarUrl: json[ClientProfileFields.avatarUrl] as String,
        address: json[ClientProfileFields.address] as String?,
        latitude: (json[ClientProfileFields.latitude] as num?)?.toDouble(),
        longitude: (json[ClientProfileFields.longitude] as num?)?.toDouble(),
        phoneNumber: json[ClientProfileFields.phoneNumber] as String?,
        contactPerson: json[ClientProfileFields.contactPerson] as String?,
        email: json[ClientProfileFields.email] as String?,
        city: json[ClientProfileFields.city] as String?,
        status: json[ClientProfileFields.status] as String?,
      );
  
  Map<String, dynamic> toJson() => {
        ClientProfileFields.clientProfileId: clientProfileId,
        ClientProfileFields.clientName: clientName,
        ClientProfileFields.avatarUrl: avatarUrl,
        ClientProfileFields.address: address,
        ClientProfileFields.latitude: latitude,
        ClientProfileFields.longitude: longitude,
        ClientProfileFields.phoneNumber: phoneNumber,
        ClientProfileFields.contactPerson: contactPerson,
        ClientProfileFields.email: email,
        ClientProfileFields.city: city,
        ClientProfileFields.status: status,
      };
}