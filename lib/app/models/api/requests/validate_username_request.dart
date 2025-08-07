class ValidateUsernameFields {
  static const String username = 'username';

  static const List<String> allFields = <String>[
    username,
  ];
}

class ValidateUsernameRequest {
  final String username;

  ValidateUsernameRequest({
    required this.username,
  });

  factory ValidateUsernameRequest.fromJson(Map<String, dynamic> json) =>
      ValidateUsernameRequest(
        username: json[ValidateUsernameFields.username] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        ValidateUsernameFields.username: username,
      };
}