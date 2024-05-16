import 'package:get/get.dart';
import 'package:talnts_app/common/widgets/colors.dart';

void showSnackBar({ required String content, String? title}) {
  Get.showSnackbar(
    GetSnackBar(
      title: title ?? 'Error',
      message: content,
      duration: const Duration(seconds: 3),
      backgroundColor: primaryColor,
    ),
  );
}

  String communityPlatform(String data){
    if(data == 'whatsapp') {
      return "Whatsapp";
    } else if (data == 'telegram') {
      return "Telegram";
    } else if (data == 'discord') {
      return "Discord";
    } else if( data == 'slack') {
      return "Slack";
    } else {
      return "";
    }
  }

  String communityStatus(String data) {
      if(data == 'open_community') {
        return "Open Community";
      } else if(data == 'closed_community'){
        return "Closed Community";
      } else {
        return "";
      }
  }

  String communityType(String data) {
    if(data == 'whatsapp') {
      return "assets/images/whatsapp_icon.png";
    } else if (data == 'telegram') {
      return "assets/images/telegram_icon.png";
    } else if (data == 'discord') {
      return "assets/images/discord_icon.png";
    } else if( data == 'slack') {
      return "assets/images/slack_icon.png";
    } else {
      return "";
    }
  }

