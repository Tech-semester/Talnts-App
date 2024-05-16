import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/features/dashboard/model/purchased_products.dart';
import 'package:talnts_app/features/dashboard/services/dashboard_services.dart';
import 'package:talnts_app/features/market/model/published_products.dart';

import '../../../common/network/base_controller.dart';

class DashboardController extends GetxController with BaseController {
  final DashboardServices _dashboardServices = DashboardServices();
  final introdata = GetStorage();
  var isLoading = false.obs;
  var isListLoading = false.obs;
  var errorMessage = ''.obs;
  var dashboardStatistics = {}.obs;
  List<PurchasedProduct> listOfPurchasedProducts = [];
  var purchasedProductsList = <PurchasedProduct>[].obs;
  var newPurchasedProductsList = <PurchasedProduct>[].obs;

  @override
  void onInit() {
    getDashboardStatistics();
    getAllPurchasedProducts();
    super.onInit();
  }

  Future<void> getDashboardStatistics() async {
    errorMessage.value = '';
    isLoading(true);
    try {
      var value = await _dashboardServices.getDashboardStatistics();
      if (value['message'] == "Buyer Dashboard data") {
        dashboardStatistics.value = value['data'];
      }
    } catch (e) {
      errorMessage.value = handleErrorMessage(e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> getAllPurchasedProducts() async {
    errorMessage.value = '';
    isListLoading(true);
    try {
      var value = await _dashboardServices.getAllPurchasedProducts();
      if (value['message'] == "My Purchased Products") {
        var dataList = value['data']; // Store the data list
        var trans = List<PurchasedProduct>.from(dataList.map((x) {
          try {
            return PurchasedProduct.fromJson(x); // Use fromJson constructor
          } catch (e) {
            // Log the error and the entire list of data
            print('Error occurred while parsing PurchasedProduct:');
            print('Entire list of data: $dataList');
            print('Error: $e');
            // Return null to mark the item as invalid
            return null;
          }
        }).where((item) => item != null)); // Filter out null items
        purchasedProductsList.value = trans;
        print(purchasedProductsList.length);
        print('Here are some published products');
      }
    } catch (e) {
      print('Error occurred: $e');
      handleError(e);
    } finally {
      isListLoading(false);
    }
  }

}
