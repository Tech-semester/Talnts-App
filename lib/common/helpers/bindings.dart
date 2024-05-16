import 'package:get/get.dart';
import 'package:talnts_app/features/auth/controller/auth_controller.dart';
import 'package:talnts_app/features/community/controller/communities_controller.dart';
import 'package:talnts_app/features/notifications/controller/notification_controller.dart';
import 'package:talnts_app/features/profile/controller/profile_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<ProfileController>(ProfileController(), permanent: true);
    Get.put<CommunitiesController>(CommunitiesController(), permanent: true);
    Get.put<NotificationController>(NotificationController(), permanent: true);
  }
}
