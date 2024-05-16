import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/features/market/controller/market_controller.dart';
import 'package:talnts_app/features/market/model/published_products.dart';
import 'package:talnts_app/features/market/views/published_products_details.dart';
import 'package:talnts_app/features/profile/controller/profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:talnts_app/common/widgets/colors.dart';

class Market extends StatefulWidget {
  const Market({Key? key}) : super(key: key);

  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  final _controller = Get.put(MarketController());
  final ProfileController _profileController = Get.put(ProfileController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _controller.getAllPublishedProducts();
    _controller.newPublishedProductsList.value =
        _controller.publishedProductsList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarketController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.person,
                        size: 40,
                      ),
                      imageBuilder: (context, imageProvider) => Container(
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
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // container background color
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            width: 1, color: const Color(0xFFC4C4C4))),
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
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  Image.asset(
                    'assets/images/new_calendar.png',
                    height: 35,
                    width: 35,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Obx(() {
                if (_controller.isLoading.value) {
                  // return ShimmerLoadingList();
                  return const Center(child: CircularProgressIndicator());
                } else if (_controller.errorMessage.isNotEmpty) {
                  return const Center(child: Text('An Error Occurred'));
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: _controller.newPublishedProductsList.length,
                      itemBuilder: ((context, index) {
                        PublishedProducts _model =
                            _controller.newPublishedProductsList[index];
                        return productItems(_model);
                      }));
                }
              }),
            ),
            // buildProductList(),
            const SizedBox(
              height: 20,
            )
          ],
        )),
      );
    });
  }

  Widget loader() => const Center(child: CircularProgressIndicator());

  Widget errorWidget() {
    return const Center(
      child: Text(
        "No Published yet.",
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }

  Widget buildProductList() {
    return Obx(() {
      if (_controller.isLoading.value) {
        return Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.grey,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Container();
              },
            ));
      } else if (_controller.errorMessage.isNotEmpty) {
        return const Center(child: Text('An Error Occurred'));
      } else if (_controller.newPublishedProductsList.isEmpty) {
        return const Center(
            child: Text(
          'No Products yet',
          style: TextStyle(color: Colors.white),
        ));
      } else {
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _controller.newPublishedProductsList.length,
            itemBuilder: ((context, index) {
              PublishedProducts productModel =
                  _controller.newPublishedProductsList[index];
              return productItems(productModel);
            }));
      }
    });
  }

  // Function to calculate the duration between two dates
  String calculateDuration(String startDate, String endDate) {
    final DateTime start = DateTime.parse(startDate);
    final DateTime end = DateTime.parse(endDate);
    final Duration difference = end.difference(start);
    final int weeks = difference.inDays ~/ 7;
    return '$weeks week${weeks == 1 ? '' : 's'}';
  }

  // Function to format the date
  String formatDate(String dateString) {
    final DateTime dateTime = DateTime.parse(dateString);
    final DateFormat formatter =
        DateFormat('d\'${getOrdinalSuffix(dateTime.day)}\' MMMM');
    return formatter.format(dateTime);
  }

// Function to get ordinal suffix for the day
  String getOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  Widget productItems(PublishedProducts productModel) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PublishedProductDetails(model: productModel));
      },
      child: Container(
        height: 320,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                  tag: productModel.bootcamp!.displayImage!,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: productModel.bootcamp!.displayImage ?? "",
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )),
              const SizedBox(
                height: 5,
              ),
              Text(
                productModel.bootcamp!.classTitle ?? "Heyyy",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: productModel.seller!.imageUrl == null ||
                              productModel.seller!.imageUrl == ''
                          ? "https://pixabay.com/vectors/blank-profile-picture-mystery-man-973460/"
                          : productModel.seller!.imageUrl!,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.person,
                        size: 30,
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    productModel.seller!.firstName ?? "",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    productModel.seller!.lastName ?? "",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Image.asset(
                              'assets/images/bootcamp_icon.png',
                              height: 12,
                              width: 12,
                            ),
                          ],
                        ),
                        Text(
                          productModel.productType == "bootcamp"
                              ? "Bootcamp"
                              : productModel.productType ?? "",
                          style: TextStyle(
                              color: subTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/clock_icon.png',
                          height: 12,
                          width: 12,
                        ),
                        Text(
                          productModel.bootcamp!.startDate != null &&
                                  productModel.bootcamp!.endDate != null
                              ? calculateDuration(
                                  productModel.bootcamp!.startDate.toString(),
                                  productModel.bootcamp!.endDate.toString(),
                                )
                              : '',
                          style: TextStyle(
                              color: subTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/calendar_icon.png',
                        height: 12,
                        width: 12,
                      ),
                      Text(
                        productModel.createdAt != null
                            ? formatDate(productModel.createdAt.toString())
                            : '',
                        style: TextStyle(
                            color: subTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productModel.price == 0
                        ? "Free"
                        : "₦${productModel.price.toString()}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                        size: 25,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
