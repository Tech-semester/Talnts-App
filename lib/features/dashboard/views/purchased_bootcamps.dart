import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/dashboard_controller.dart';

class PurchasedBootcamp extends StatelessWidget {
  final DashboardController _dashboardController =
      Get.put(DashboardController());

  PurchasedBootcamp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(() {
          return Column(
            children: [
              const SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount:
                  _dashboardController.purchasedProductsList.length,
                  itemBuilder: (context, index) {
                    final product =
                    _dashboardController.purchasedProductsList[index];
                    return Card(
                      elevation: 8,
                      color: Colors.white,
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Hero(
                                  tag: product
                                      .product!.bootcamp!.displayImage!,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: product.product!.bootcamp!
                                          .displayImage ??
                                          "",
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              const SizedBox(height: 8),
                              Text(
                                product.product!.bootcamp!.classTitle!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: product.product!.instructors
                                          .isNotEmpty
                                          ? product.product!.instructors
                                          .first.data.imageUrl ??
                                          ''
                                          : "https://pixabay.com/vectors/blank-profile-picture-mystery-man-973460/",
                                      placeholder: (context, url) =>
                                      const CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                      errorWidget: (context, url, error) =>
                                      const Icon(
                                        Icons.person,
                                        color: Colors.black54,
                                        size: 30,
                                      ),
                                      imageBuilder:
                                          (context, imageProvider) =>
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '${product.product!.seller.firstName ?? ''} ${product.product!.seller.lastName ?? ''}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20,),
            ],
          );
        }),
      ),
    );
  }
}
