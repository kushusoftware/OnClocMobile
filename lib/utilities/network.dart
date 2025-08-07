import 'dart:convert';

import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/app/services/api/api_config.dart';
import 'package:on_cloc_mobile/app/models/api/result/api_response.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';

Map<String, String> buildHeader() {
  String? token = getStringAsync(tokenPref);
  String? tenantId = getStringAsync(tenantPref);

  Map<String, String> headers = {};

  if (!token.isEmptyOrNull) {
    log('Token: $token');
    log('TenantId: $tenantId');
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'text/json',
      'Authorization': 'Bearer $token',
      'TenantId': tenantId,
    };
  } else {
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'text/json',
    };
  }

  return headers;
}

Future<Response> getRequest(String endPoint) async {
  try {
    if (!await isNetworkAvailable()) throw onClocLocale.lblNoInternetConnection;

    log('Request: $endPoint ');

    Response response = await get(
      Uri.parse(endPoint),
      headers: buildHeader(),
    ).timeout(
      const Duration(seconds: timeoutDuration),
      onTimeout: () => throw onClocLocale.lblPleaseTryAgain,
    );

    log(
      'Response: $endPoint ${response.statusCode} ${response.body.toString()}',
    );
    return response;
  } catch (e) {
    log(e);
    if (!await isNetworkAvailable()) {
      throw onClocLocale.lblNoInternetConnection;
    } else {
      toast(onClocLocale.lblPleaseTryAgain);
      throw onClocLocale.lblPleaseTryAgain;
    }
  }
}

Future<Response> postRequest(String endPoint, body) async {
  try {
    if (!await isNetworkAvailable()) throw onClocLocale.lblNoInternetConnection;

    log('Request: $endPoint $body');

    Response response = await post(
      Uri.parse(endPoint),
      body: jsonEncode(body),
      headers: buildHeader(),
    ).timeout(
      const Duration(seconds: timeoutDuration),
      onTimeout: () => throw onClocLocale.lblPleaseTryAgain,
    );

    log(
      'Response: $endPoint ${response.statusCode} ${response.body.toString()}',
    );
    return response;
  } catch (e) {
    log(e);
    if (!await isNetworkAvailable()) {
      throw onClocLocale.lblNoInternetConnection;
    } else {
      throw onClocLocale.lblPleaseTryAgain;
    }
  }
}

Future<Response> postRequestWithQuery(String endPoint, String query) async {
  try {
    if (!await isNetworkAvailable()) throw onClocLocale.lblNoInternetConnection;

    String url = '$endPoint$query';

    Response response = await get(
      Uri.parse(url),
      headers: buildHeader(),
    ).timeout(
      const Duration(seconds: timeoutDuration),
      onTimeout: () => throw onClocLocale.lblPleaseTryAgain,
    );

    log(
      'Response: $endPoint?$query ${response.statusCode} ${response.body.toString()}',
    );
    log(response.body);
    return response;
  } catch (e) {
    log(e);
    if (!await isNetworkAvailable()) {
      throw onClocLocale.lblNoInternetConnection;
    } else {
      toast(onClocLocale.lblPleaseTryAgain);
      throw onClocLocale.lblPleaseTryAgain;
    }
  }
}

Future<bool> multipartRequest(String endPoint, String filePath) async {
  try {
    if (!await isNetworkAvailable()) throw onClocLocale.lblNoInternetConnection;

    MultipartRequest request = MultipartRequest('POST', Uri.parse(endPoint));

    MultipartFile file = await MultipartFile.fromPath('file', filePath);

    request.files.add(file);

    request.headers.addAll(buildHeader());

    log('Multipart Request: $request');

    var response = await request.send();

    log('"Multipart Response: $endPoint Status ${response.statusCode}}');

    return response.statusCode == 200;
  } catch (e) {
    log(e);
    if (!await isNetworkAvailable()) {
      throw onClocLocale.lblNoInternetConnection;
    } else {
      toast(onClocLocale.lblPleaseTryAgain);
      throw onClocLocale.lblPleaseTryAgain;
    }
  }
}

Future<StreamedResponse> multipartRequestWithData(
  String endPoint,
  String filePath,
  Map<String, String> data,
) async {
  try {
    if (!await isNetworkAvailable()) throw onClocLocale.lblNoInternetConnection;

    MultipartRequest request = MultipartRequest('POST', Uri.parse(endPoint));

    request.fields.addAll(data);

    MultipartFile file = await MultipartFile.fromPath('file', filePath);

    request.files.add(file);

    request.headers.addAll(buildHeader());

    log('Multipart Request: $request');

    var response = await request.send();

    log('"Multipart Response: $endPoint Status ${response.statusCode}}');

    return response;
  } catch (e) {
    log(e);
    if (!await isNetworkAvailable()) {
      throw onClocLocale.lblNoInternetConnection;
    } else {
      toast(onClocLocale.lblPleaseTryAgain);
      throw onClocLocale.lblPleaseTryAgain;
    }
  }
}

Future<ApiResponse?> handleResponse(Response response) async {
  if (response.statusCode.isSuccessful()) {
    var resModel = ApiResponse.fromJson(jsonDecode(response.body));
    return resModel;
  } else if (response.statusCode == 401) {
    onClocSharedHelper.logout();
    throw ('Please login again');
  } else if (response.statusCode == 400) {
    var resModel = ApiResponse.fromJson(jsonDecode(response.body));
    return resModel;
  } else {
    return null;
  }
}
