import 'package:dio/dio.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/services/api/api_config.dart';
import 'package:on_cloc_mobile/app/models/api/result/api_response.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';

// This class is responsible for handling network requests and responses.
class OnClocNetworkService {
  // This class is a singleton to ensure only one instance is used throughout the app.
  final dio = Dio();

  String baseUrl = baseOnClocWebApiUrl;

  Map<String, dynamic> buildHeader() {
    // This method builds the headers for the network request.
    bool isLoggedIn = getBoolAsync(isLoggedInPref, defaultValue: false);
    String? token = getStringAsync(tokenPref);
    var headers = <String, dynamic>{};
    if (isLoggedIn && !token.isEmptyOrNull) {
      headers = {
        'Content-Type': Headers.jsonContentType,
        'Accept': Headers.jsonContentType,
        'Authorization': 'Bearer $token',
      };
    } else {
      headers = {
        'Content-Type': Headers.jsonContentType,
        'Accept': Headers.jsonContentType,
      };
    }
    return headers;
  }

  Future<Response<dynamic>> post(String endPoint, dynamic payload) async {
    // Check if the network is available before making the request.
    if (!await isNetworkAvailable()) throw onClocLocale.lblNoInternetConnection;
    // POST request to the specified endpoint with the given payload.
    final dio = Dio();
    final headers = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((key, value) => value == null);
    final data = <String, dynamic>{};
    // If payload is null, initialize it as an empty map.
    data.addAll(payload ?? <String, dynamic>{});
    final extras = <String, dynamic>{};
    final options = _setStreamType(
      Options(
            method: 'POST',
            headers: headers,
            extra: extras,
            responseType: ResponseType.json,
          )
          .compose(
            dio.options,
            endPoint,
            queryParameters: queryParameters,
            data: data,
          )
          .copyWith(
            baseUrl: _combineBaseUrls(dio.options.baseUrl, baseUrl),
            connectTimeout: const Duration(seconds: timeoutDuration),
          ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Called before the request is sent.
          options.headers.addAll(buildHeader());
          return handler.next(options); // continue
        },
        onResponse: (response, handler) {
          // Called when the response is received.
          return handler.next(response); // continue
        },
        onError: (DioException e, handler) {
          // Called when an error occurs.
          if (e.response?.statusCode == 400) {
            toast('Bad request. Please check your input.');
          }
          else if (e.response?.statusCode == 401) {
            onClocSharedHelper.logout();
          }
          else if (e.response?.statusCode == 403) {
            toast('You are not authorized to access this resource.');
          }
          else if (e.response?.statusCode == 404) {
            toast('Resource not found. Please check the URL.');
          }
          else if (e.response?.statusCode == 500) {
            toast('Server error. Please try again later.');
          }
          return handler.next(e); // continue
        },
      ),
    );
    return await dio.fetch(options);
  }

  Future<Response<dynamic>> get(String endPoint, dynamic query) async {
    // Check if the network is available before making the request.
    if (!await isNetworkAvailable()) throw onClocLocale.lblNoInternetConnection;
    // GET request to the specified endpoint with the given query parameters.
    final dio = Dio();
    final headers = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((key, value) => value == null);
    const Map<String, dynamic>? data = null;
    final extras = <String, dynamic>{};
    if(query != null) {
      queryParameters.addAll(query);
    }
    final options = _setStreamType(
      Options(method: 'GET', headers: headers, extra: extras)
          .compose(
            dio.options,
            endPoint,
            queryParameters: queryParameters,
            data: data,
          )
          .copyWith(baseUrl: _combineBaseUrls(dio.options.baseUrl, baseUrl)),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Called before the request is sent.
          options.headers.addAll(buildHeader());
          return handler.next(options); // continue
        },
        onResponse: (response, handler) {
          // Called when the response is received.
          return handler.next(response); // continue
        },
        onError: (DioException e, handler) {
          // Called when an error occurs.
          if (e.response?.statusCode == 400) {
            toast('Bad request. Please check your input.');
          }
          else if (e.response?.statusCode == 401) {
            onClocSharedHelper.logout();
          }
          else if (e.response?.statusCode == 403) {
            toast('You are not authorized to access this resource.');
          }
          else if (e.response?.statusCode == 404) {
            toast('Resource not found. Please check the URL.');
          }
          else if (e.response?.statusCode == 500) {
            toast('Server error. Please try again later.');
          }
          return handler.next(e); // continue
        },
      ),
    );
    return await dio.fetch(options);
  }

  Future<ApiResponse> handleOnClocResponse(Response<dynamic> response) async {
    // This method handles the response from the network request.
    if (response.statusCode == 200 && response.statusMessage == 'OK') {
      // If the response is successful, parse the data.
      ApiResponse apiResponse = ApiResponse.fromJson(response.data);
      return apiResponse;
    } else {
      if (response.statusCode == 401) {
        onClocSharedHelper.logout();
      }
      throw ('Please login again');
    }
  }

  Future<List<dynamic>> processResultList(Response<dynamic> response) async {
    // This method processes the response and returns a ResultList.
    if (response.statusCode == 200 && response.statusMessage == 'OK') {
      // If the response is successful, parse the data.
      List<dynamic> resultList = response.data as List<dynamic>;
      return resultList;
    } else {
      if (response.statusCode == 401) {
        onClocSharedHelper.logout();
      }
      throw ('Please login again');
    }
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }
    final url = Uri.parse(baseUrl);
    if (url.isAbsolute) {
      return url.toString();
    }
    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
