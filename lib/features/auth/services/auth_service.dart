import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:talnts_app/common/network/base_client.dart';
import 'package:talnts_app/common/network/base_controller.dart';


class AuthService with BaseController {
  final introdata = GetStorage();
  BaseClient baseClient = BaseClient();

  String getToken() {
    String token = introdata.read("token");
    return token;
  }


  Map<String, String> get headers =>
      {
        "Content-Type": "application/json",
      };


  Future<dynamic> login(String email, String password) async {
    try {
      return await baseClient.post(url, '/auth/login', {
        "email": email,
        "password": password,
      });
    } catch (error) {
      return Future.error(error);
    }
  }


  Future<dynamic> forgotPassword(String email) async {
    try {
      return await baseClient.post(url, '/auth/forgot-password', {
        "email": email,
      });
    } catch (error) {
      return Future.error(error);
    }
  }


  Future<dynamic> resendOtp(String email) async {
    var response = await http
        .get(Uri.parse("$url/auth/resend-verification-email/$email"));

    var body = json.decode(response.body);
    print(body);

    if (body['status'] == true) {
      return Future.value(body['status']);
    } else {
      return Future.error(body['message']);
    }
  }
  Future<dynamic> signUp(String firstName, String lastName, String emailAddress, String username, String password) async {
    try {
      return await baseClient.post(url, '/auth/register', {
        "email": emailAddress,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "password": password,
      });
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<dynamic> resetPassword(String email, String password, int otpCode) async {
    try {
      return await baseClient.post(
          url,
          '/auth/reset-password', {
            "email": email,
            "new_password": password,
            "code": otpCode,
      });
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<dynamic> verifyEmail(String email, int otpCode) async {
    try {
      return await baseClient.post(
          url,
          '/auth/verify-email', {
        "email": email,
        "code": otpCode,
      });
    } catch (error) {
      return Future.error(error);
    }
  }

}


