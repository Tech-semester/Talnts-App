import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talnts_app/common/helpers/utils.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/features/community/controller/communities_controller.dart';
import 'package:talnts_app/features/community/models/communities_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/helpers/get_storage.dart';
import '../../../common/widgets/flat_button.dart';
import '../models/communities_details_model.dart';

class CommunityDetails extends StatefulWidget {
  const CommunityDetails({Key? key, required this.commModel}) : super(key: key);

  final CommunitiesModel commModel;

  @override
  State<CommunityDetails> createState() => _CommunityDetailsState();
}

class _CommunityDetailsState extends State<CommunityDetails> {
  final LocalStorage _localStorage = LocalStorage();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final introdata = GetStorage();

  final CommunitiesController _communitiesController =
      Get.put(CommunitiesController());

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
     // _communitiesController.getAllCommunitiesById(CommunitiesModel());
      _refreshIndicatorKey.currentState?.show();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     color: Colors.black,
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   title: Expanded(
      //     child: Text(
      //       widget.commModel.communityName!,
      //       style: const TextStyle(
      //           color: Colors.black,
      //           fontSize: 16,
      //           fontWeight: FontWeight.bold),
      //     ),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.more_vert),
      //       color: grey,
      //     ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.commModel.communityName!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (BuildContext context) {
                        bool isCreator = widget.commModel.creatorId ==
                            _localStorage.getUserId();
                        List<PopupMenuEntry<String>> menuItems = isCreator
                            ? [
                                const PopupMenuItem<String>(
                                  value: 'edit',
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'delete',
                                  child: Text('Delete',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16)),
                                ),
                              ]
                            : [
                                const PopupMenuItem<String>(
                                  value: 'report',
                                  child: Text('Report',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16)),
                                ),
                              ];

                        return menuItems;
                      },
                      onSelected: (String value) {
                        switch (value) {
                          case 'edit':
                            break;
                          case 'delete':
                            deleteDialog(context);
                            break;
                          case 'report':
                            break;
                        }
                      },
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: widget.commModel.creator!.imageUrl!,
                          height: 22,
                          width: 22,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.commModel.creator!.fullName,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: containerBackground,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(widget.commModel.communityDescription!)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: containerBackground,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Platform',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            communityType(widget.commModel.platform!),
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            communityPlatform(widget.commModel.platform!),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: containerBackground,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Community Status',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(communityStatus(widget.commModel.status!))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (widget.commModel.status == "open_community")
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: containerBackground,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Invite Link/Instructions',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            final url = widget.commModel.inviteLink!;
                            launchURL(url);
                          },
                          child: Text(
                            widget.commModel.inviteLink!,
                            style: TextStyle(
                              color: floatingActionButtonColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                if (widget.commModel.status == "closed_community")
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: containerBackground,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Invite Link/Instructions',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            final url = widget.commModel.instructions!;
                            launchURL(url);
                          },
                          child: Text(
                            widget.commModel.instructions!,
                            style: TextStyle(
                              color: floatingActionButtonColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, universalLinksOnly: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  deleteDialog(BuildContext context) {
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
                  height: height * 0.2,
                  width: width * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text('Delete',
                        style: TextStyle(fontSize: 20, color: red, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,),
                      const SizedBox(
                        height:25,
                      ),
                      const Text('Are you sure you want to delete this\n community? This cannot be reversed',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  _communitiesController.deleteCommunity(widget.commModel);
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
