class UserProfileFields {
  static const String userId = 'id';
  static const String serviceOfficerProfileId = 'serviceOfficerProfileId';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String email = 'email';
  static const String avatarUrl = 'avatarUrl';
  static const String address = 'address';
  static const String phoneNumber = 'phoneNumber';
  static const String alternateNumber = 'alternateNumber';
  static const String status = 'status';
  static const String token = 'token';
  static const String tenantId = 'tenantId';
  static const String requiresTfa = 'requiresTfa';

  static const List<String> allFields = [
    userId,
    serviceOfficerProfileId,
    firstName,
    lastName,
    email,
    avatarUrl,
    address,
    phoneNumber,
    alternateNumber,
    status,
    token,
    tenantId,
    requiresTfa,
  ];
}

class OnClocUserProfile {
  final String userId;
  final String serviceOfficerProfileId;
  final String firstName;
  final String lastName;
  final String email;
  final String avatarUrl;
  final String? address;
  final String phoneNumber;
  final String? alternateNumber;
  final String status;
  final String token;
  final String? tenantId;
  final bool requiresTfa;

  OnClocUserProfile({
    required this.userId,
    required this.serviceOfficerProfileId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatarUrl,
    this.address,
    required this.phoneNumber,
    this.alternateNumber,
    required this.status,
    required this.token,
    this.tenantId,
    this.requiresTfa = false,
  });

  factory OnClocUserProfile.fromJson(Map<String, dynamic> json) =>
      OnClocUserProfile(
        userId: (json[UserProfileFields.userId] as String?).toString(),
        serviceOfficerProfileId: (json[UserProfileFields.serviceOfficerProfileId] as String?).toString(),
        firstName: (json[UserProfileFields.firstName] as String?).toString(),
        lastName: (json[UserProfileFields.lastName] as String?).toString(),
        email: (json[UserProfileFields.email] as String?).toString(),
        avatarUrl: (json[UserProfileFields.avatarUrl] as String?).toString(),
        address: (json[UserProfileFields.address] as String?).toString(),
        phoneNumber: (json[UserProfileFields.phoneNumber] as String?).toString(),
        alternateNumber: (json[UserProfileFields.alternateNumber] as String?).toString(),
        status: (json[UserProfileFields.status] as String?).toString(),
        token: (json[UserProfileFields.token] as String?).toString(),
        tenantId: (json[UserProfileFields.tenantId] as String?).toString(),
        requiresTfa: (json[UserProfileFields.requiresTfa] as bool?) ?? false,
      );

  Map<String, dynamic> toJson() => {
    UserProfileFields.userId: userId,
    UserProfileFields.serviceOfficerProfileId: serviceOfficerProfileId,
    UserProfileFields.firstName: firstName,
    UserProfileFields.lastName: lastName,
    UserProfileFields.email: email,
    UserProfileFields.avatarUrl: avatarUrl,
    UserProfileFields.address: address,
    UserProfileFields.phoneNumber: phoneNumber,
    UserProfileFields.alternateNumber: alternateNumber,
    UserProfileFields.status: status,
    UserProfileFields.token: token,
    UserProfileFields.tenantId: tenantId,
    UserProfileFields.requiresTfa: requiresTfa,
  };
}
