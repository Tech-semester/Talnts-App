import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:talnts_app/common/helpers/custom_svg.dart';
import 'package:talnts_app/common/helpers/dialog_box.dart';
import 'package:talnts_app/common/helpers/utils.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/common/widgets/flat_button.dart';
import 'package:talnts_app/features/auth/controller/auth_controller.dart';
import 'package:talnts_app/features/community/views/create_community.dart';
import 'package:talnts_app/features/profile/controller/profile_controller.dart';
import 'package:talnts_app/features/profile/views/edit_profile.dart';

import '../../community/models/communities_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = true;
  late Timer _timer;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  final ProfileController _profileController = Get.put(ProfileController());
  final AuthController _authController = Get.find<AuthController>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();


  //File? image;

  @override
  initState() {
    _profileController.getUserCommunities();
    _profileController.getProfile(onsucess: onsuccess);
    super.initState();
  }

  void onsuccess() {
    setState(() {});
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        id: 'Profile Page',
        builder: (controller) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 24,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const EditProfile());
                        },
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                              fontSize: 15,
                              color: floatingActionButtonColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CachedNetworkImage(
                      imageUrl: _profileController.profileModel.profileImage ==
                          null ||
                          _profileController.profileModel.profileImage == ''
                          ? "https://pixabay.com/vectors/blank-profile-picture-mystery-man-973460/"
                          : _profileController.profileModel.profileImage!,
                      placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                      const Icon(
                        Icons.person,
                        size: 120,
                      ),
                      imageBuilder: (context, imageProvider) =>
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${_profileController.profileModel.firstName ??
                        ""} ${_profileController.profileModel.lastName ?? ""}',
                    style: TextStyle(
                        fontSize: 20,
                        color: floatingActionButtonColor,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '@${_profileController.profileModel.userName ?? ""}',
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    _profileController.profileModel.bio ?? "",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Communities',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  Flexible(
                    child: Obx(() {
                      if (_profileController.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (_profileController.errorMessage.isNotEmpty) {
                        return const Center(child: Text('An error occurred'));
                      } else if (_profileController.listOfCommunities.isEmpty) {
                        return Center(
                          child: emptyCommunityList(),
                        );
                      } else {
                        return ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount:
                          _profileController.listOfCommunities.length,
                          itemBuilder: ((context, index) {
                            CommunitiesModel model =
                            _profileController.listOfCommunities[index];
                            return CommunitiesList(model:model);
                          }),
                        );
                      }
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      logoutDialog(context);
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: 20,
                          color: red,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget emptyCommunityList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomSvg(assetName: 'assets/images/none.svg',
        height: 200, width: 200,),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'You have no community',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        const SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () {
            Get.to(const CreateCommunity());
          },
          child: Text(
            'Create a Community now!',
            style: TextStyle(
                color: floatingActionButtonColor,
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
  logoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Builder(
            builder: (context) {
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;
              return Container(
                  color: Colors.white,
                  height: height * 0.30,
                  width: width * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text('Logout',
                        style: TextStyle(fontSize: 20, color: red, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,),
                      const SizedBox(
                        height:25,
                      ),
                      const Text('Are you sure you want to logout?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                                onTap: (){
                                _profileController.logOut();
                                },
                                child: Text('Yes',
                                  style: TextStyle(color: statusBar, fontWeight: FontWeight.bold),),
                              )
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Flatbutton(
                                text: 'No',
                                onpressed: (){
                                  Navigator.of(context).pop(false);
                                },
                                textStyle: const TextStyle(fontSize: 12),
                              )
                          ),
                        ],
                      ),
                    ],
                  ));
            },
          ),
        ));
  }
}

class CommunitiesList extends StatelessWidget {
  final CommunitiesModel model;
  const CommunitiesList({required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                    model.communityName!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
              Text(
                'View',
                style: TextStyle(
                    color: floatingActionButtonColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.end,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: '${model.creator?.imageUrl}',
                  height: 22,
                  width: 22,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '${model.creator?.fullName}',
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                communityType(model.platform!),
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                communityPlatform(model.platform!),
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                    communityStatus(model.status!),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ))
            ],
          ),
        ],
      ),
    );
  }


}
