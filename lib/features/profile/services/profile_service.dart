import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/network/base_client.dart';
import 'dart:io';
import 'package:talnts_app/features/profile/model/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ProfileService {
  final introdata = GetStorage();

  BaseClient baseClient = BaseClient();

  Future<dynamic> getProfile() async {
    try {
      return await baseClient.get(
        url,
        '/auth/profile',
      );
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<dynamic> getUserCommunities() async {
    try {
      return await baseClient.get(
        "https://api.talnts.app/api/v1/community-service",
        '/communities/',
      );
    } catch (error) {
      return Future.error(error);
    }
  }


  Future<dynamic> updateProfile(String firstName, String lastName, String username, String bio, String profileImage) async {
    // try {
    //   return await baseClient.put(
    //       url,
    //       '/auth/profile',
    //     {
    //       "first_name": firstName,
    //       "last_name": lastName,
    //       "username": username,
    //       "bio": bio,
    //       "image_url": profileImage
    //     }
    //   );
    // } catch (error) {
    //   return Future.error(error);
    // }
    // try {
    //   String? imageBase64;
    //
    //   if (profileImage != null) {
    //     // Convert the image to a base64 encoded string
    //     final bytes = await profileImage.readAsBytes();
    //     imageBase64 = base64Encode(bytes);
    //   }
    //
    //   final response = await baseClient.put(
    //       url,
    //       '/auth/profile',
    //       {
    //         "first_name": firstName,
    //         "last_name": lastName,
    //         "username": username,
    //         "bio": bio,
    //         "image_base64": imageBase64, // Send the image as a base64 encoded string
    //       }
    //   );
    //
    //   return response;
    // } catch (error) {
    //   return Future.error(error);
    // }
  }

  Future<dynamic> updateProfilePicture(String profileImage) async {
    try {
      return await baseClient.put(
          url,
          '/auth/profile',
          {
            "image_url": profileImage
          });
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<dynamic> uploadImage(File image) async {
    try {
      return await baseClient.post(
          "https://user-service.talnts.app/api/v1",
          '/upload-file',
          {
            "file": image
          }
      );
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<dynamic> editNewProfile(String firstName, String lastName, String bio, String? image) async {
    try {
      return await baseClient.post(url, '/auth/profile', {
        "first_name": firstName,
        "last_name": lastName,
        "bio": bio,
        "image_url": image,
      });
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<dynamic> editProfile(String firstName, String lastName, String bio, File? image) async {
    try {
      final request = http.MultipartRequest('PUT', Uri.parse('$url/auth/profile'));
      // Add the authorization header with the token
      var token = introdata.read('access');
      request.headers['Authorization'] = 'Bearer $token';


      request.fields['first_name'] = firstName;
      request.fields['last_name'] = lastName;
      request.fields['bio'] = bio;


      if (image != null) {
        final file = await http.MultipartFile.fromPath('image_url', image.path,  filename: 'filename.jpg',
          contentType: MediaType('image', 'jpeg'),);
        request.files.add(file);
      }


      final response = await request.send();
      final responseString = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(responseString);


      return jsonResponse;
    } catch (error) {
      return Future.error(error);
    }
  }




}