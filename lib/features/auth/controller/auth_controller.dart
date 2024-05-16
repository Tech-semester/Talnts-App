import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/helpers/utils.dart';
import 'package:talnts_app/common/network/base_controller.dart';
import 'package:talnts_app/common/widgets/bottom_navbar.dart';
import 'package:talnts_app/features/auth/services/auth_service.dart';
import 'package:talnts_app/features/auth/views/email_successful.dart';
import 'package:talnts_app/features/auth/views/otp_screen.dart';
import 'package:talnts_app/features/auth/views/reset_successful.dart';
import 'package:talnts_app/features/auth/views/verify_email.dart';
import 'package:talnts_app/features/profile/services/profile_service.dart';

import '../../profile/model/profile_model.dart';
import '../views/login.dart';

class AuthController extends GetxController with BaseController {
  String? pubspecPackageName = 'talnts_app';
  final AuthService _authService = AuthService();
  final ProfileService _profileService = ProfileService();

  var isLoading = false.obs;
  var isSuccess = false.obs;
  final introdata = GetStorage();

  ProfileModel _profileModel = ProfileModel();

  ProfileModel get profileModel => _profileModel;

  getProfile({required Function onsucess}) {
    _profileService.getProfile().then((value) {
      if (value['status'] == true) {
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

  void login({required String email, required String password}) {
    isLoading(true);
    _authService.login(email, password).then((value) {
      isLoading(false);
      introdata.write('access', value['data']['access']);
      introdata.write('user_id', value['data']['user']['user_id']);
      if (value['status'] == true) {
        isLoading(false);
        Get.off(() => const BottomBar());
      }
    }).catchError((e) {
      isLoading(false);
      print(e);
      handleError(e);
    });
  }

  void forgotPassword({required String email}) {
    isLoading(true);
    _authService.forgotPassword(email).then((value) {
      if (value['status'] == true) {
        isLoading(false);
        Get.to(() => PasswordResetOtpScreen(emailAddress: email));
      }
    }).catchError((e) {
      isLoading(false);
      print(e);
      handleError(e);
    });
  }

  void resendOtp(String email) {
    print(email);
    _authService.resendOtp(email).then((value) {
      print('success');
    }).catchError((e) {
      print(e);
      showSnackBar(content: e);
    });
  }

  void resetPassword(String email, String password, int otpCode) {
    isLoading(true);
    _authService.resetPassword(email, password, otpCode).then((value) {
      isLoading(false);
      if (value['status'] == true) {
        Get.to(() => const ResetSuccessful());
      }
    }).catchError((e) {
      isLoading(false);
      print(e);
      handleError(e);
    });
  }

  void verifyEmail(String email, int otpCode) {
    isLoading(true);
    _authService.verifyEmail(email, otpCode).then((value) {
      isLoading(false);
      if (value['status'] == true) {
        Get.to(() => const EmailSuccessful());
      }
    }).catchError((e) {
      isLoading(false);
      print(e);
      handleError(e);
    });
  }

  void register(
      {required String firstName,
      required String lastName,
      required String emailAddress,
      required String username,
      required String password}) {
    isLoading(true);
    _authService
        .signUp(firstName, lastName, emailAddress, username, password)
        .then((value) {
      if (value['status'] == true) {
        Get.to(() => VerifyEmail(emailAddress: emailAddress));
      }
    }).catchError((e) {
      isLoading(false);
      print(e);
      handleError(e);
    });
  }

  void logOut() {
    Get.offAll(() => const Login());
    introdata.remove('access');
  }
}
