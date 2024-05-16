import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/network/base_client.dart';

class NotificationService {
  final introdata = GetStorage();
  BaseClient baseClient = BaseClient();

  Future<dynamic> getAllNotifications() async {
    try {
      return await baseClient.get(
        "https://api.talnts.app/api/v1/user-service",
        '/notifications/',
      );
    } catch (error) {
      return Future.error(error);
    }
  }
}
