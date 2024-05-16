import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:talnts_app/common/network/app_exception.dart';
import 'package:talnts_app/common/network/base_controller.dart';
import 'package:talnts_app/features/market/services/market_services.dart';
import 'package:talnts_app/features/market/model/published_products.dart';

class MarketController extends GetxController with BaseController {
  final MarketService _marketService = MarketService();

  final introdata = GetStorage();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isListLoading = false.obs;

  List<PublishedProducts> listOfProducts = [];
  var publishedProductsList = <PublishedProducts>[].obs;
  var newPublishedProductsList = <PublishedProducts>[].obs;

  getAllPublishedProducts() {
    _marketService.getAllPublishedProducts().then((value) {
      print(value['data']);
      try {
        print("hyyyy");
        if (value['data'] != null) {
          print('hello');
          var trans = List<PublishedProducts>.from(
              (value['data']).map((x) => PublishedProducts.fromMap(x)));
          publishedProductsList.value = trans;
          print(publishedProductsList.length);
          print('Here are some published products');
          isListLoading(false);
        }
      } catch (error) {
        print(error);
      }
    }).catchError((e) {
      handleError(e);
      isLoading(false);
    });
  }
  
  getPublishedProductDetails(PublishedProducts publishedProducts){
    _marketService.getAllPublishedProductsDetails(publishedProducts.slug!).then((value){
      print(value['data']);
      try {
        print("hyyyy");
        if (value['data'] != null) {
          print('hello');
          var trans = List<PublishedProducts>.from(
              (value['data']).map((x) => PublishedProducts.fromMap(x)));
          publishedProductsList.value = trans;
          print(publishedProductsList.length);
          print('Here are some published products');
          isListLoading(false);
        }
      } catch (error) {
        print(error);
      }
    }).catchError((e) {
      handleError(e);
      isLoading(false);
    });
  }
}
