

import 'package:get_storage/get_storage.dart';

import '../../../common/network/base_client.dart';

class SearchService {

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


}