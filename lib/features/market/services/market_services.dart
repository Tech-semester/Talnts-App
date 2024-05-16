import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/network/base_client.dart';

class MarketService {
  final introdata = GetStorage();

  BaseClient baseClient = BaseClient();

  Future<dynamic> getAllPublishedProducts() async {
    try {
      return await baseClient.get(
        "https://api.staging.talnts.app/api/v1/commerce-service",
        '/products/published-products',
      );
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<dynamic> getAllPublishedProductsDetails(String? slug) async {
    try {
      return await baseClient.get(
        "https://api.staging.talnts.app/api/v1/commerce-service",
        '/products/product/$slug',
      );
    } catch (error) {
      return Future.error(error);
    }
  }
}