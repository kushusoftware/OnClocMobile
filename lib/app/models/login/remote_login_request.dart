class LoginRequestFields {
  static const String username = 'username';
  static const String password = 'password';

  static const List<String> allFields = [
    username,
    password,
  ];
}

class RemoteLoginRequest {
  final String username;
  final String password;

  RemoteLoginRequest({
    required this.username,
    required this.password,
  });

  factory RemoteLoginRequest.fromJson(Map<String, dynamic> json) =>
      RemoteLoginRequest(
        username: json[LoginRequestFields.username] as String,
        password: json[LoginRequestFields.password] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        LoginRequestFields.username: username,
        LoginRequestFields.password: password,
      };
}