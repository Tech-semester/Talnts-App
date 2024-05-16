import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/features/auth/views/login.dart';
import 'package:talnts_app/common/widgets/bottom_navbar.dart';
import 'package:talnts_app/features/splash_screen/onboarding_screen.dart';

class Root extends StatelessWidget {
  Root({Key? key}) : super(key: key);
  final introdata = GetStorage();

  @override
  Widget build(BuildContext context) {
    return introdata.read("display") ?  introdata.read('token') == '' ? const Login(): const BottomBar(): const OnboardingScreen();
  }
}
