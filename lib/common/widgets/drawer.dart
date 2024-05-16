import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:talnts_app/features/auth/controller/auth_controller.dart';

import '../helpers/custom_svg.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GetBuilder<AuthController>(
          id: '',
          builder: (authController) {
            return Scaffold(
              body: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.black.withOpacity(.05),
                          child: _authController.profileModel.profileImage == '' || _authController.profileModel.profileImage == null
                              ? Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset('assets/images/dummy.png'),
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: SizedBox(
                              width: Get.width,
                              height: Get.height,
                              child: Image.network(
                                _authController.profileModel.profileImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                            height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
