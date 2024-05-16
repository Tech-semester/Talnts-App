import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/network/base_controller.dart';
import 'package:talnts_app/features/community/models/communities_model.dart';
import 'package:talnts_app/features/search/services/search_service.dart';

class SearchItemController extends GetxController with BaseController {
  final SearchService _searchService = SearchService();
  final introdata = GetStorage();
  var isLoading = false.obs;
  var isListLoading = false.obs;
  var errorMessage = ''.obs;

  var communityList = <CommunitiesModel>[].obs;
  var newCommunityList = <CommunitiesModel>[].obs;

 void  getCommunities(){
    isListLoading(true);
    _searchService.getAllCommunities().then((value){
      if(value['status']== true){
        isListLoading(false);
        var listOfCommunities = List<CommunitiesModel>.from((value['data']).map((x)=> CommunitiesModel.fromMap(x)));
        communityList.value = listOfCommunities;
        isListLoading(false);
      }
    }).catchError((error){
      isListLoading(false);
      handleError(error);
    });
  }
}