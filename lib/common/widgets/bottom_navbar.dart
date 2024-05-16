import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talnts_app/common/helpers/custom_svg.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/features/auth/controller/auth_controller.dart';
import 'package:talnts_app/features/community/views/communities.dart';
import 'package:talnts_app/features/dashboard/views/dashboard.dart';
import 'package:talnts_app/features/market/views/market.dart';
import 'package:talnts_app/features/notifications/views/notifications.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int pageIndex = 0;
  final AuthController _authControllerController = Get.put(AuthController());

  List<Widget> pages = const [
    Market(),
    Community(),
    Notifications(),
    Dashboard()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        currentIndex: pageIndex,
        onTap: (val) {
          setState(() {
            pageIndex = val;
          });
        },
        selectedItemColor: primaryColor,
        unselectedItemColor: grey,
        backgroundColor: Colors.white,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
            label: 'Market',
            icon: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: CustomSvg(
                assetName: 'assets/images/market.svg',
                height: 20,
                width: 20,
                color: pageIndex == 0 ? primaryColor : Colors.grey,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Communities',
            icon: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: CustomSvg(
                assetName: 'assets/images/community.svg',
                height: 20,
                width: 20,
                color: pageIndex == 1 ? primaryColor : Colors.grey,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Notifications',
            icon: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: CustomSvg(
                assetName: 'assets/images/notifications.svg',
                height: 20,
                width: 20,
                color: pageIndex == 2 ? primaryColor : Colors.grey,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Dashboard',
            icon: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: CustomSvg(
                assetName: 'assets/images/dashboard.svg',
                height: 20,
                width: 20,
                color: pageIndex == 3 ? primaryColor : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
