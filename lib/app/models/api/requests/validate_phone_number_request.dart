class ValidatePhoneNumberFields {
  static const String phoneNumber = 'phone_number';

  static const List<String> allFields = [
    phoneNumber
    ];
}

class ValidatePhoneNumberRequest {
  String phoneNumber;

  ValidatePhoneNumberRequest({
    required this.phoneNumber,
  });

  factory ValidatePhoneNumberRequest.fromJson(Map<String, dynamic> json) =>
      ValidatePhoneNumberRequest(
        phoneNumber: json[ValidatePhoneNumberFields.phoneNumber] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        ValidatePhoneNumberFields.phoneNumber: phoneNumber,
      };
}