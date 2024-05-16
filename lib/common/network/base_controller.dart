import 'package:talnts_app/common/network/app_exception.dart';
import 'package:talnts_app/common/network/dialog_help.dart';


mixin BaseController {
  void handleError(error) {
    if (error is BadRequestException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message);
    } else if (error is FetchDataException) {
      var message = error.message;
      //  showSnackBar(content: message!);
      DialogHelper.showErrorDialog(description: message);
    } else if (error is ApiNotRespondingException) {
      DialogHelper.showErrorDialog(description: 'Oops! It took longer to respond.');
    }else{
      DialogHelper.showErrorDialog(
        title: 'Error',
        description: "An error occurred, please try again",
      );
    }
  }
  String handleErrorMessage(e) {
    String errorMess = '';
    e is BadRequestException ||
        e is FetchDataException ||
        e is ApiNotRespondingException
        ? errorMess = e.message!
        : 'An error occurred';
    return errorMess;
  }


  showLoading([String? message]) {
    DialogHelper.showLoading(message);
  }

  hideLoading() {
    DialogHelper.hideLoading();
  }
}
