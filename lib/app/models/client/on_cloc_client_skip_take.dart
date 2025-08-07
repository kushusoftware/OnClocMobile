import 'package:on_cloc_mobile/app/models/client/client_profile.dart';

class OnClocClientSkipTake {
  List<ClientProfile> clients = [];
  int totalCount = 0;

  OnClocClientSkipTake.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['clients'] != null) {
      json['clients'].forEach((v) {
        clients.add(ClientProfile.fromJson(v));
      });
    }
  }

}