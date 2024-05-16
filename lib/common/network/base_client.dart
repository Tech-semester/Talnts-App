import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:talnts_app/common/helpers/get_storage.dart';
import 'package:talnts_app/common/helpers/simple_log_printer.dart';
import 'package:talnts_app/common/network/app_exception.dart';

const String _authUrl = "https://api.talnts.app/api/v1/user-service";
String get url => _authUrl;

//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjgwNzkzODU3LCJqdGkiOiIwOTJlYmQxNzU2ZjU0NDA2YjBjNGM3ZjIwNDM4YTI2MSIsInVzZXJfaWQiOiI5Njc4MTg5OC1jOGRlLTQzNzgtOWRjYi0xYmU0MmQyYWUxMjMifQ.5pNyLmTjY0N740tn6Zdw_EhGLsGGh4Tko1RyS22WpCg

class BaseClient {
  static const int TIME_OUT_DURATION = 180;
  final introdata = GetStorage();

  Map<String, String> headers = {
    "Content-Type": "application/json",
    };

  Map<String, String> authorization = {
    "Authorization": "Bearer Token",
  };

  //GET
  Future<dynamic> get(String baseUrl, String api) async {
    var token = await LocalStorage.getToken();
    var uri = Uri.parse(baseUrl + api);

    if (token != null) {
      authorization = {"Content-Type": "application/json", 'Authorization': "Bearer $token"};
      print("Bearer $token");
      //authorization = {"Authorization": 'Bearer $token'};
    }
    try {
      if (kDebugMode) {
        getLogger().d(''' URL:: $uri,
         print:: ${json.encode(authorization)},
         header:: ${json.encode(authorization)}''');

    }

      var response = await http
          .get(uri, headers: authorization)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));

      if (kDebugMode) {
        getLogger().d(
            'Received Response status code is :${response.statusCode} and response body is  ${response.body} ');
      }

      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }


  //POST
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj, {String? access,List<File>? files}) async {
    var token = introdata.read('token');
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);

    if (token != null) {
      headers = {
        "Content-Type": "application/json",
        'authorization': token,
      };
      }
    try {
      if (kDebugMode) {
        getLogger().d(''' URL:: $uri,
        print:: ${json.encode(headers)},
         body:: ${json.encode(payloadObj)}''');
      }
      Response response;
      if(files != null){
        var request = http.MultipartRequest("POST", uri);
        request.fields.addAll(payloadObj);
        request.headers.addAll(headers);
        for (var element in files) {
          var contentType = lookupMimeType(element.path);
          request.files.add(await http.MultipartFile.fromPath(
            "files",
            element.path,
            filename: element.path.split('/').last,
            contentType: MediaType.parse(contentType!),
          ));
        }
        response = await request.send().then((value) => http.Response.fromStream(value));
      }else{
        response = await http.post(uri, body: payload, headers: headers).timeout(const Duration(seconds: TIME_OUT_DURATION));
      }

      if (kDebugMode) {
        getLogger()
            .d('''Received Response status code is : ${response.statusCode}, 
        response body ::  ${response.body} ''');
      }
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  Future<dynamic> put2(
      String baseUrl,
      String api,
      dynamic payloadObj,
      ) async {
    var token = await LocalStorage.getToken();
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);

    if (token != null) {
      headers = {"Content-Type": "application/json", 'Authorization': "Bearer $token"};
    }
    try {
      if (kDebugMode) {
        getLogger().d(''' URL:: $uri,
         body:: ${json.encode(payloadObj)}''');
      }

      var response = await http
          .put(uri, body: payloadObj, headers: headers)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      if (kDebugMode) {
        getLogger()
            .d('''Received Response status code is : ${response.statusCode}, 
          response body ::  ${response.body} ''');
      }
      //   print('''response code:: ${response.statusCode},
      //   response body:: ${response.body}
      // ''');
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //DELETE
  Future<dynamic> delete(
      String baseUrl,
      String api,
      dynamic payloadObj,
      ) async {
    var token = await LocalStorage.getToken();
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);

    if (token != null) {
      headers = {"Content-Type": "application/json", 'Authorization': "Bearer $token"};
    }
    try {
      if (kDebugMode) {
        getLogger().d(''' URL:: $uri,
         header:: ${json.encode(headers)}''');
      }

      var response = await http
          .delete(uri, body: payload, headers: headers)
          .timeout(const Duration(seconds: TIME_OUT_DURATION));
      if (kDebugMode) {
        getLogger()
            .d('''Received Response status code is : ${response.statusCode}, 
          response body ::  ${response.body} ''');
      }
      //   print('''response code:: ${response.statusCode},
      //   response body:: ${response.body}
      // ''');
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }


  //PUT
  Future<dynamic> put(
      String baseUrl,
      String api,
      dynamic payloadObj,
      {String? access,List<File>? files}
      ) async {
    var token = await LocalStorage.getToken();
    var uri = Uri.parse(baseUrl + api);
    var payload = json.encode(payloadObj);

    if (token != null) {
      authorization = {"Content-Type": "application/json", 'Authorization': "Bearer $token"};
      print("Bearer $token");
    }
    try {
      if (kDebugMode) {
        getLogger().d(''' URL:: $uri,
         body:: ${json.encode(payloadObj)}''');
      }
      Response response;
      if(files != null){
        var request = http.MultipartRequest("POST", uri);
        request.fields.addAll(payloadObj);
        request.headers.addAll(headers);
        for (var element in files) {
          var contentType = lookupMimeType(element.path);
          request.files.add(await http.MultipartFile.fromPath(
            "files",
            element.path,
            filename: element.path.split('/').last,
            contentType: MediaType.parse(contentType!),
          ));
        }
        response = await request.send().then((value) => http.Response.fromStream(value));
      }else{
        response = await http.put(uri, body: payload, headers: authorization).timeout(const Duration(seconds: TIME_OUT_DURATION));
      }

      if (kDebugMode) {
        getLogger()
            .d('''Received Response status code is : ${response.statusCode}, 
        response body ::  ${response.body} ''');
      }
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }



  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        return responseJson;
    //break;
      case 201:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        return responseJson;
    // break;
      case 400:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw BadRequestException(responseJson['message'] ?? 'An error occurred',
            response.request!.url.toString());
      case 401:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw BadRequestException(
            responseJson['message'], response.request!.url.toString());
      case 403:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw UnAuthorizedException(
            responseJson['message'], response.request!.url.toString());
      case 404:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw BadRequestException(responseJson['error'] ?? 'An error occurred',
            response.request!.url.toString());
      case 422:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw BadRequestException(responseJson['message'] ?? 'An error occurred',
            response.request!.url.toString());
      case 503:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw BadRequestException(responseJson['error'] ?? 'An error occurred',
            response.request!.url.toString());
      case 500:
      default:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw FetchDataException(responseJson['message'] ?? 'An error occurred',
            response.request!.url.toString());
    }
  }




}

