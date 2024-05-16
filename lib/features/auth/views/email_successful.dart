import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/features/auth/views/login.dart';

class EmailSuccessful extends StatelessWidget {
  const EmailSuccessful({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
            padding:
            const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/reset_success.png'),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Email Verified Successfully!',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: (){
                    Get.offAll(() => const Login());
                  },
                  child: Text(
                    'Continue to Login',
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}