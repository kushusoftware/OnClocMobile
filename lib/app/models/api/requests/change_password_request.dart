class ChangePasswordFields {
  static const String oldPassword = 'oldPassword';
  static const String newPassword = 'newPassword';

  static const List<String> allFields = [
    oldPassword,
    newPassword,
  ];
}

class ChangePasswordRequest {
  final String oldPassword;
  final String newPassword;

  ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      ChangePasswordRequest(
        oldPassword: json[ChangePasswordFields.oldPassword] as String,
        newPassword: json[ChangePasswordFields.newPassword] as String,
      );

  Map<String, dynamic> toJson() => {
        ChangePasswordFields.oldPassword: oldPassword,
        ChangePasswordFields.newPassword: newPassword,
      };
}