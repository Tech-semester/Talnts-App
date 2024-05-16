import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/common/widgets/round_button.dart';
import 'package:talnts_app/features/auth/views/register.dart';
import 'package:talnts_app/features/auth/views/reset_password.dart';

class PasswordResetLink extends StatefulWidget {
  const PasswordResetLink({Key? key,}) : super(key: key);

  @override
  State<PasswordResetLink> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<PasswordResetLink> {
  final introdata = GetStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Forgot Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: primaryColor,
                      fontWeight: FontWeight.bold,),),
                  const SizedBox(
                    height: 3,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 80,
                      color: primaryColor,
                      height: 3,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('A mail has been sent to your email address.\n'
                      'Follow the instructions to reset your password.',
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset('assets/images/email_inbox.png'),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.to(() =>const Register());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Didn\'t get a link ?',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Resend Link',
                                style: TextStyle(color: floatingActionButtonColor,
                                    fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundedButtonWidget(
                      buttonText: 'Continue',
                      width: double.infinity,
                      onpressed: (){
                       // Get.offAll(() => const ResetPassword());
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

