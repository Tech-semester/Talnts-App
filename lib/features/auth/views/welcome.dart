import 'package:flutter/material.dart';
import 'package:talnts_app/common/helpers/custom_svg.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/common/helpers/assets.dart';


class Welcome extends StatelessWidget {
  const Welcome({
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
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/welcome.png'),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Welcome on board!',
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
                 Text(
                  'Continue to Login',
                  style: TextStyle(
                    fontSize: 14, 
                    color: primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
    );
  }
}