import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:talnts_app/features/market/model/published_products.dart';

import '../../../common/widgets/colors.dart';

class PublishedProductDetails extends StatefulWidget {
  const PublishedProductDetails({super.key, required this.model});

  final PublishedProducts model;

  @override
  State<PublishedProductDetails> createState() =>
      _PublishedProductDetailsState();
}

class _PublishedProductDetailsState extends State<PublishedProductDetails> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Course Details",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                    widget.model.bootcamp!.displayImage!),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.model.bootcamp!.classTitle ?? "",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/bootcamp_icon.png',
                                height: 12,
                                width: 12,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.model.productType == "bootcamp"
                                    ? "Bootcamp"
                                    : widget.model.productType ?? "",
                                style: TextStyle(
                                    color: subTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/clock_icon.png',
                                height: 12,
                                width: 12,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.model.bootcamp!.startDate != null &&
                                        widget.model.bootcamp!.endDate != null
                                    ? calculateDuration(
                                        widget.model.bootcamp!.startDate
                                            .toString(),
                                        widget.model.bootcamp!.endDate
                                            .toString(),
                                      )
                                    : '',
                                style: TextStyle(
                                    color: subTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/calendar_icon.png',
                                height: 12,
                                width: 12,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.model.createdAt != null
                                    ? formatDate(
                                        widget.model.createdAt.toString())
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
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: widget.model.seller!.imageUrl == null ||
                                      widget.model.seller!.imageUrl == ''
                                  ? "https://pixabay.com/vectors/blank-profile-picture-mystery-man-973460/"
                                  : widget.model.seller!.imageUrl!,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.person,
                                size: 30,
                              ),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                            widget.model.seller!.firstName ?? "",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.model.seller!.lastName ?? "",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.model.price == 0
                            ? "Free"
                            : "₦${widget.model.price.toString()}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "About this course",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.model.bootcamp!.courseDescription!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Category",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.model.categories!.map((categories) {
                          return Chip(
                            label: Text(categories.name!),
                            backgroundColor: Colors.grey[300],
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "More Information",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "Learning Goals",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          widget.model.bootcamp!.learningGoals!.length,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                '${index + 1}. ${widget.model.bootcamp!.learningGoals![index]}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Text(
                        "Class Requirements",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          widget.model.bootcamp!.classRequirements!.length,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                '${index + 1}. ${widget.model.bootcamp!.classRequirements![index]}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Text(
                        "What you will get",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          widget.model.bootcamp!.benefits!.length,
                              (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                '${index + 1}. ${widget.model.bootcamp!.benefits![index]}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Text(
                        "FAQ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),

                    ]))
          ],
        ),
      ),
    );
  }
}
