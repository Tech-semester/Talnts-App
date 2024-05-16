import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:talnts_app/features/dashboard/views/dashboard.dart';

import '../../../common/widgets/drawer.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 8,
        leading: GestureDetector(
          onTap: (){
            if (_scaffoldKey.currentState!.isDrawerOpen == false) {
              _scaffoldKey.currentState!.openDrawer();
            } else {
              _scaffoldKey.currentState!.openEndDrawer();
            }
          },
          child: const CircleAvatar(
              radius: 10,
              backgroundImage:
              AssetImage('assets/images/dummy.png')),
        ),
        title: searchCommunities(),
        actions: [
          GestureDetector(
            onTap: (){
              Get.to(() => const Dashboard());
            },
            child: Image.asset('assets/images/dashboard.png',
            height: 35, width: 35,),
          )
        ],
      ),
      
      body: Container(

      ),
    );
  }

  Widget searchCommunities() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color:const Color(0xfff5f6ff), // container background color
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value){
        },
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 23.0),
          prefixIcon: Icon(Icons.search, color: Color(0xff7F7F7F),),
          hintText: 'Search Communities',
          hintStyle: TextStyle(fontStyle: FontStyle.italic, fontSize: 14, color: Color(0xff7C7C7C)),// hint text inside the container
        ),
      ),

    );
  }
}
