import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/network/app_exception.dart';
import 'package:talnts_app/common/network/base_controller.dart';
import 'package:talnts_app/common/widgets/bottom_navbar.dart';
import 'package:talnts_app/features/auth/views/login.dart';
import 'package:talnts_app/features/profile/model/profile_model.dart';
import 'package:talnts_app/features/profile/services/profile_service.dart';
import 'package:talnts_app/features/community/models/communities_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'dart:io';
import 'package:talnts_app/common/network/base_client.dart';
import 'dart:convert';
import 'package:talnts_app/features/profile/views/profile.dart';

import '../../../common/helpers/get_storage.dart';

class ProfileController extends GetxController with BaseController {
  final ProfileService _profileService = ProfileService();
  final introdata = GetStorage();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  //var image = ImageModel().obs;
  File? image;



  List<CommunitiesModel> listOfCommunities = [];

  ProfileModel _profileModel = ProfileModel();
  ProfileModel get profileModel => _profileModel;

  getProfile({required Function onsucess}) {
    _profileService.getProfile().then((value) {
      if(value['status'] == true) {
        isLoading(false);
        _profileModel = ProfileModel.fromMap(value['data']);
        print(_profileModel.bio);
        onsucess();
        isLoading(false);
        update(['Profile Page']);
      }
      }).catchError((e) {
      handleError(e);
      isLoading(false);
    });
  }


  getUserCommunities() {
    _profileService.getUserCommunities().then((value) {
      if(value['status'] == true) {
        isLoading(false);
        final communityList = List<CommunitiesModel>.from(
            (value['data']).map((x) => CommunitiesModel.fromMap(x)));
        listOfCommunities = communityList;
      } else {
        isLoading(false);
        throw FetchDataException(value['message'], '');
      }
    }).catchError((e) {
      handleError(e);
      isLoading(false);
    });
  }

  void logOut() async {
    Get.offAll(() => const Login());
    introdata.remove('access');
  }


  // void updateProfile(String firstName, String lastName, String username, String bio, File? image) async{
  //   isLoading(true);
  //   String imageUrl = await uploadImage(image!);
  //     _profileService.updateProfile(firstName, lastName, username, bio, imageUrl).then((data) {
  //       isLoading(false);
  //       if (data['status']) {
  //         Get.to(()=> const BottomBar());
  //       }
  //     }).catchError((e) {
  //       isLoading(false);
  //       print(e);
  //       handleError(e);
  //     });
  //
  // }

  void updateProfile(String firstName, String lastName, String username, String bio, String image) async {
    isLoading(true);
    _profileService.updateProfile(firstName, lastName, username, bio, image).then((data) {
      isLoading(false);
      if (data['message']=="Profile updated") {
        Get.to(() => const BottomBar());
      }
    }).catchError((e) {
      isLoading(false);
      print(e);
      handleError(e);
    });
    // Handle the case where image is null
  }
  void editNewProfile(
      String firstName,
      String lastName,
      String bio,
      File? image,
      ) async {
    isLoading(true);
    try {
      if (image != null) {
        String imageUrl = await _profileService.uploadImage(image);

        // Now update the profile with the image URL
        var profileUpdateResponse = await _profileService.editNewProfile(firstName, lastName, bio, imageUrl);

        if (profileUpdateResponse['status'] == true) {
          // Profile update successful
          isLoading(false);
          Get.offAll(() => const BottomBar());
        } else {
          // Handle other responses or unexpected data
          isLoading(false);
          print('Unexpected profile update response: $profileUpdateResponse');
        }
      } else {
        // Handle the case where image is null (if needed)
        isLoading(false);
        print('Image is null. Cannot upload null image.');
      }
    } catch (e) {
      isLoading(false);
      print('Error during profile update: $e');
      handleError(e);
    }
  }

  void editProfile(
      String firstName,
      String lastName,
      String bio,
      File? image
      ){
    //isLoading(true);
    _profileService.editProfile(firstName, lastName, bio, image).then((value){
      print('can I see');
      if(value['message'] == "Profile updated"){
        print('heeeyyyy');
        isLoading(false);
       Get.offAll(()=> const BottomBar());
      } else {
        isLoading(false);
        print('Unexpected response: $value');
        print(value);
      }
    }).catchError((e) {
      isLoading(false);
      print('Error during profile update: $e');
      handleError(e);
    });
  }



  void updateProfilePicture(String profileImage) {
    _profileService.updateProfilePicture(profileImage).then((data) {
      isLoading(false);
      if(data['status']){

      }
    }).catchError((e){
      isLoading(false);
      print(e);
      handleError(e);
    });
  }

  void uploadNewImage(File? image) async {
    try {
      isLoading(true);

      var stream = http.ByteStream(DelegatingStream.typed(image!.openRead()));
      var length = await image.length();
      var uri = Uri.parse("$url/upload-file");

      var request = http.MultipartRequest("POST", uri);
      var token = introdata.read('access');
      request.headers['Authorization'] = 'Bearer $token';

      var multipartFile = http.MultipartFile(
        'file',
        stream,
        length,
        filename: path.basename(image.path),
      );

      request.files.add(multipartFile);

      var response = await request.send();
      var imageUploadResponse = await response.stream.bytesToString();

      // Parse the response as JSON
      var jsonResponse = jsonDecode(imageUploadResponse);

      isLoading(false);

      // Return the parsed JSON response
      return jsonResponse;
    } catch (e) {
      handleError(e);
      isLoading(false);
      throw e; // Rethrow the error after handling
    }
  }

  uploadImage(File? image) async {
   isLoading(true);
    var stream = http.ByteStream(DelegatingStream.typed(image!.openRead()));
    // get file length
    var length = await image.length();
    // string to uri
    var uri = Uri.parse("$url/upload-file");
    print(uri.toString());

    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    //var token = await LocalStorage.getToken();
    var token = introdata.read('access');
    request.headers['Authorization'] = 'Bearer $token';
    print(request.headers);

    print('hello');

    // multipart that takes file.. here this "image_file" is a key of the API request
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: path.basename(image.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        isLoading(false);
      });

    }).catchError((e) {
      handleError(e);
      print(e);
      isLoading(false);
    });
    try {
      final request = http.MultipartRequest('POST', Uri.parse('$url/upload-file'));
      // Add the authorization header with the token
      var token = introdata.read('access');
      request.headers['Authorization'] = 'Bearer $token';

      if (image != null) {
        final file = await http.MultipartFile.fromPath('file', image.path);
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

  void uploadProfilePic(File image) {
    isLoading(false);
    _profileService.uploadImage(image).then((value) {
      if (value['status'] == true) {

      }

      }).catchError((e) {
  isLoading(false);
  print(e);
  handleError(e);
  });

  }






}