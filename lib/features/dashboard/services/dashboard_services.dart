import 'package:get_storage/get_storage.dart';

import '../../../common/network/base_client.dart';

class DashboardServices {
  final introdata = GetStorage();
  BaseClient baseClient = BaseClient();

  Future<dynamic> getDashboardStatistics() async {
    try {
      return await baseClient.get(
        "https://api.staging.talnts.app/api/v1/commerce-service",
        '/products/my-buyer-dashboard-stats',
      );
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<dynamic> getAllPurchasedProducts() async {
    try {
      return await baseClient.get(
        "https://api.staging.talnts.app/api/v1/commerce-service",
        '/products/my-purchases/?search=ongoing',
      );
    } catch (error) {
      return Future.error(error);
    }
  }
}
