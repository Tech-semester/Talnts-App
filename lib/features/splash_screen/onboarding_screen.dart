import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/helpers/get_storage.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/features/auth/views/login.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    LocalStorage().init();
    Timer(const Duration(seconds: 3), () => Get.off(() => const Login()));
  }

  final introdata = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_screen.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/discover_communities.png',
                    // replace with your logo image asset path
                    width: 300,
                    height: 200,
                  ),
                  Text(
                    'Discover Communities',
                    style: GoogleFonts.openSans(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Find all your amazing communities in one place',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal
                  ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
