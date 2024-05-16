import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/network/base_client.dart';

class CommunitiesService {
  final introdata = GetStorage();

  BaseClient baseClient = BaseClient();

  Future<dynamic> getAllCommunities() async {
    try {
      return await baseClient.get(
        "https://api.talnts.app/api/v1/community-service/communities",
        '/all/all',
      );
    } catch (error) {
      return Future.error(error);
    }
  }



  Future<dynamic> getAllCommunitiesById(String? communityId) async {
    try {
      return await baseClient.get(
        "https://api.talnts.app/api/v1/community-service/communities",
        '/$communityId/',
      );
    } catch (error) {
      return Future.error(error);
    }
  }

  // Delete Communities
  Future<dynamic> deleteCommunity(String? communityId) async {
    try {
      return await baseClient.delete(
        "https://api.talnts.app/api/v1/community-service/communities",
        '/$communityId/',
        {}
      );
    } catch (error) {
      return Future.error(error);
    }
  }


}