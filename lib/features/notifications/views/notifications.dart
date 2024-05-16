import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/features/notifications/controller/notification_controller.dart';
import 'package:talnts_app/features/profile/controller/profile_controller.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final _controller = Get.find<NotificationController>();
  final ProfileController _profileController = Get.put(ProfileController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15,),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: _profileController.profileModel.profileImage ==
                          null ||
                          _profileController.profileModel.profileImage == ''
                          ? "https://pixabay.com/vectors/blank-profile-picture-mystery-man-973460/"
                          : _profileController.profileModel.profileImage!,
                      placeholder: (context, url) =>
                      const CircularProgressIndicator(color: Colors.white,),
                      errorWidget: (context, url, error) =>
                      const Icon(
                        Icons.person,
                        size: 40,
                      ),
                      imageBuilder: (context, imageProvider) =>
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Expanded(child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white, // container background color
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1, color: const Color(0xFFC4C4C4))
                    ),
                    child: TextField(
                      onChanged: (value) {
                        //searchByAll(value);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15.0),
                        suffixIcon: Icon(
                          Icons.search,
                          color: searchIconColor,
                        ),
                        hintText: 'Search',
                        hintStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                            color: searchIconColor),
                      ),
                    ),
                  )
                  ),
                  const SizedBox(width: 8,),
                  Image.asset('assets/images/dashboard.png',
                    height: 35, width: 35,)
                ],
              ),),
              const SizedBox(height: 15,),
              Expanded(
                flex: 1,
                child: RefreshIndicator(
                  displacement: 10,
                  onRefresh: () async {
                    return _controller.getAllNotifications();
                  },
                  key: _refreshIndicatorKey,
                  child: notificationList(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget notificationList() {
    if (_controller.isLoading.value) {
      return const Center(child: Text('Loading....'));
    } else if (_controller.errorMessage.value.isNotEmpty) {
      return errorWidget();
    } else if (_controller.notificationList.isEmpty) {
      return errorWidget();
    } else {
      return ListView.builder(
          itemCount: _controller.notificationList.length,
          itemBuilder: (context, index) {
            var model = _controller.notificationList[index];
            // Convert the date string to a DateTime object
            DateTime dateCreated = DateTime.parse(model.dateCreated!);
            String daySuffix = _getDaySuffix(dateCreated.day);
            String formattedDay = '${dateCreated.day}$daySuffix';
            String formattedDate = DateFormat("dd MMMM hh:mma").format(dateCreated);
            return Card(
              color: Colors.white,
              child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.only(bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: '${model.imageUrl}',
                        height: 32,
                        width: 32,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.title!.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            model.message!.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            //textAlign: TextAlign.justify,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(formattedDate,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }

  Widget loader() => const Center(child: CircularProgressIndicator());

  Widget errorWidget() {
    return const Center(
      child: Text(
        "No Notifications yet.",
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }

  // Function to get the suffix for the day (e.g., st, nd, rd, th)
  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    } else if (day % 10 == 1) {
      return 'st';
    } else if (day % 10 == 2) {
      return 'nd';
    } else if (day % 10 == 3) {
      return 'rd';
    } else {
      return 'th';
    }
  }
}
