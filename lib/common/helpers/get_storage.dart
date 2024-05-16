import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final introdata = GetStorage();

  void init() {
    introdata.writeIfNull("display", false);
    introdata.writeIfNull("loggedinbefore", false);
    introdata.write("access", '');
    introdata.write("user_id", '');
  }

  static getToken() {
    return GetStorage().read("access");
  }

   getUserId() {
    return GetStorage().read("user_id");
  }

  static deleteToken() {
    return GetStorage().remove("access");
  }

}
