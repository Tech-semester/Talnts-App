import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/helpers/utils.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/features/community/controller/communities_controller.dart';
import 'package:talnts_app/features/community/models/communities_model.dart';
import 'package:talnts_app/features/community/views/community_details.dart';
import 'package:talnts_app/features/community/views/create_community.dart';

import '../models/communities_details_model.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final introdata = GetStorage();

  File? image;

  final CommunitiesController _communitiesController =
      Get.put(CommunitiesController());

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _communitiesController.getAllCommunities();
       //_communitiesController.getAllCommunitiesById(CommunitiesModel());
      _refreshIndicatorKey.currentState?.show();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const CreateCommunity());
        },
        backgroundColor: floatingActionButtonColor,
        child: const Icon(
          Icons.add,
          size: 30,
          color: Colors.white,
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              _communitiesController.getAllCommunities();
              return Future<void>.delayed(const Duration(seconds: 5));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Communities',
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Obx(() {
                    if (_communitiesController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (_communitiesController.errorMessage.isNotEmpty) {
                      return const Center(child: Text('An error occurred'));
                    } else {
                      return ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount:
                            _communitiesController.listOfCommunities.length,
                        itemBuilder: ((context, index) {
                          CommunitiesModel communityModel =
                              _communitiesController.listOfCommunities[index];
                          return communitiesList(communityModel);
                        }),
                      );
                    }
                  }),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          )),
    );
  }

  Widget communitiesList(CommunitiesModel model) {
    return GestureDetector(
      onTap: () {
        Get.to(() => CommunityDetails(commModel: model));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.communityName!,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
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
