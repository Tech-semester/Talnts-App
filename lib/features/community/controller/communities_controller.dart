import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/network/app_exception.dart';
import 'package:talnts_app/common/network/base_controller.dart';
import 'package:talnts_app/common/widgets/bottom_navbar.dart';
import 'package:talnts_app/features/community/models/communities_model.dart';
import 'package:talnts_app/features/community/services/communities_service.dart';
import 'package:talnts_app/features/community/models/communities_details_model.dart';

class CommunitiesController extends GetxController with BaseController {
  final CommunitiesService _communitiesService = CommunitiesService();
  final introdata = GetStorage();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  List<CommunitiesModel> listOfCommunities = [];
  List<CommunitiesModel> listCommunityDetails = [];
  var communityList= <CommunitiesModel>[].obs;
  var newListOfCommunities = <CommunitiesModel>[].obs;


  getAllCommunities() {
    _communitiesService.getAllCommunities().then((value) {
      if(value['status'] == true) {
        isLoading(false);
        print('Nice one');
        final communityList = List<CommunitiesModel>.from(
            (value['data']).map((x) => CommunitiesModel.fromMap(x)));
            listOfCommunities = communityList;
        print('Nice one oh');


      } else {
        isLoading(false);
        print('Howwww');
        throw FetchDataException(value['message'], '');
      }
    }).catchError((e) {
      handleError(e);
      isLoading(false);
    });
  }



  getAllCommunitiesById(CommunitiesModel model) {
    _communitiesService.getAllCommunitiesById(model.id!).then((value) {
      if(value['message'] == "Community gotten ") {
        print('Hello');
        isLoading(false);
        final communityList = List<CommunitiesModel>.from(
            (value['data']).map((x) => CommunitiesModel.fromMap(x)));
        print(value['data']);
        listCommunityDetails = communityList;

      } else {
        isLoading(false);
        throw FetchDataException(value['message'], '');
      }
    }).catchError((e) {
      handleError(e);
      isLoading(false);
    });
  }

  deleteCommunity(CommunitiesModel model){
    _communitiesService.deleteCommunity(model.id!).then((value){
      if(value['message']== "Community Deleted"){
        isLoading(false);
        // Remove the deleted community from the list
        print(model.id);
        communityList.removeWhere((item) => item.id! == model.id!);
        Get.offAll(() => const BottomBar());
      }
    });
  }



}