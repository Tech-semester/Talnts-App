import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talnts_app/common/helpers/utils.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/common/widgets/constants/constants.dart';
import 'package:talnts_app/features/community/models/communities_model.dart';
import 'package:talnts_app/features/search/controller/search_controller.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SearchItemController _searchController =
      Get.put(SearchItemController());
  String? selectedPlatform;
  String? selectedStatus;

  @override
  void initState() {
    _searchController.getCommunities();
    _searchController.newCommunityList.value = _searchController.communityList;
    super.initState();
  }

  OutlineInputBorder get _border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color.fromRGBO(130, 130, 130, 1),
          width: 0,
        ),
      );

  void searchByAll(String value) {
    if (value.isEmpty) {
      _searchController.newCommunityList.value =
          _searchController.communityList;
    } else {
      _searchController.newCommunityList.value = _searchController.communityList
          .where((element) => element.communityName!.contains(value.toString()))
          .toList();
    }
  }

  void filterSearch(String value){
    _searchController.newCommunityList.value = _searchController.communityList
        .where((element) =>
    communityPlatform(element.platform!) == value || communityStatus(element.status!) == value)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              'Search',
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            searchCommunities(),
            const SizedBox(
              height: 25,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Container(
                  //   width: 170,
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(25),
                  //     border: Border.all(
                  //         color: const Color.fromRGBO(130, 130, 130, 1),
                  //         width: 0.5),
                  //   ),
                  //   child: DropdownButtonFormField2(
                  //     decoration: const InputDecoration(
                  //       border: InputBorder.none,
                  //     ),
                  //     hint: const Text(
                  //       'Platform',
                  //       style:
                  //           TextStyle(color: Color.fromRGBO(130, 130, 130, 1)),
                  //     ),
                  //     icon: const Icon(
                  //       Icons.arrow_drop_down,
                  //       color: Colors.black45,
                  //     ),
                  //     iconSize: 30,
                  //     style: const TextStyle(
                  //         color: Color.fromRGBO(130, 130, 130, 1)),
                  //     buttonHeight: 40,
                  //     buttonPadding: const EdgeInsets.only(left: 1, right: 10),
                  //     items: platform
                  //         .map(
                  //           (item) => DropdownMenuItem<String>(
                  //             value: item,
                  //             child: Text(
                  //               item,
                  //               style: const TextStyle(
                  //                 fontSize: 14,
                  //               ),
                  //             ),
                  //           ),
                  //         )
                  //         .toList(),
                  //     onSaved: (value) {
                  //       selectedPlatform = value.toString();
                  //     },
                  //     onChanged: (value) {
                  //       setState(() {
                  //         selectedPlatform = value.toString();
                  //       });
                  //     },
                  //     validator: (value) {
                  //       if (value == null) {
                  //         return "Please select a type";
                  //       } else {
                  //         return null;
                  //       }
                  //     },
                  //   ),
                  // ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: const Color.fromRGBO(130, 130, 130, 1),
                          width: 0.5),
                    ),
                    child: DropdownButtonFormField2(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      hint: const Text(
                        'Platform',
                        style:
                            TextStyle(color: Color.fromRGBO(130, 130, 130, 1)),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      style: const TextStyle(
                          color: Color.fromRGBO(130, 130, 130, 1)),
                      buttonHeight: 50,
                      buttonPadding: const EdgeInsets.only(left: 1, right: 10),
                      items: platform
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onSaved: (value) {
                        selectedPlatform = value.toString();
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedPlatform = value.toString();
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please select a type";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: const Color.fromRGBO(130, 130, 130, 1),
                          width: 0.5),
                    ),
                    child: DropdownButtonFormField2(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      hint: const Text(
                        'Platform',
                        style:
                            TextStyle(color: Color.fromRGBO(130, 130, 130, 1)),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      style: const TextStyle(
                          color: Color.fromRGBO(130, 130, 130, 1)),
                      buttonHeight: 50,
                      buttonPadding: const EdgeInsets.only(left: 1, right: 10),
                      items: platform
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onSaved: (value) {
                        selectedPlatform = value.toString();
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedPlatform = value.toString();
                          filterSearch(value.toString());
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please select a type";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: const Color.fromRGBO(130, 130, 130, 1),
                          width: 0.5),
                    ),
                    child: DropdownButtonFormField2(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      hint: const Text(
                        'Status',
                        style:
                            TextStyle(color: Color.fromRGBO(130, 130, 130, 1)),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      style: const TextStyle(
                          color: Color.fromRGBO(130, 130, 130, 1)),
                      buttonHeight: 50,
                      buttonPadding: const EdgeInsets.only(left: 1, right: 10),
                      items: communityTypes
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onSaved: (value) {
                        selectedStatus = value.toString();
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedStatus = value.toString();
                          filterSearch(value.toString());
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please select a type";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Communities',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Obx(() {
                if (_searchController.isListLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (_searchController.errorMessage.isNotEmpty) {
                  return const Center(child: Text('An error occurred'));
                } else if(_searchController.newCommunityList.isEmpty){
                  return const Center(child: Text("No Community found",
                  style: TextStyle(color: Colors.black, fontSize: 16),));
                }
                else {
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: _searchController.newCommunityList.length,
                    itemBuilder: ((context, index) {
                      CommunitiesModel model =
                          _searchController.newCommunityList[index];
                      return communitiesList(model);
                    }),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchCommunities() {
    return Container(
      decoration: BoxDecoration(
        color: searchBar, // container background color
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        onChanged: (value) {
          searchByAll(value);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 23.0),
          prefixIcon: Icon(
            Icons.search,
            color: searchIconColor,
          ),
          hintText: 'Search Communities',
          hintStyle: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 14,
              color: searchIconColor),
          // hint text inside the container
          suffixIcon: Container(
            height: 62,
            decoration: BoxDecoration(
              color: statusBar, // background color for suffix icon
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: const Icon(Icons.search, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget communitiesList(CommunitiesModel model) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
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
      ),
    );
  }
}
