import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/network/base_controller.dart';
import 'package:talnts_app/features/notifications/model/notification_model.dart';
import 'package:talnts_app/features/notifications/services/notification_service.dart';

class NotificationController extends GetxController with BaseController {
  final NotificationService _notificationService = NotificationService();
  final introdata = GetStorage();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  List<NotificationModel> notificationList = [];
  var notificationListModel = <NotificationModel>[].obs;

  Future<void> getAllNotifications() async {
    errorMessage.value = '';
    notificationList.isEmpty ? isLoading(true) : isLoading(false);
    try {
      var value = await _notificationService.getAllNotifications();
      if (value['status'] == true) {
        isLoading(false);
        var trans = List<NotificationModel>.from(
            (value['data']).map((x) => NotificationModel.fromMap(x)));
        notificationList = trans;
        notificationListModel.value = trans;
      }
    } catch (e) {
      // handleError(e);
      errorMessage.value = handleErrorMessage(e);
      isLoading(false);
    }
  }
}
