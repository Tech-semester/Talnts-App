import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/features/dashboard/views/calendar.dart';
import 'package:talnts_app/features/dashboard/views/learning_dashboard.dart';
import 'package:talnts_app/features/dashboard/views/purchased_bootcamps.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChange);
    super.initState();
  }

  void _onTabChange() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            iconSize: 35,
            color: Colors.black,
            onPressed: () {
              //Navigator.pop(context);
            },
          ),
          centerTitle: false,
          title: Row(
            children: [
              Image.asset(
                'assets/images/app_logo.png',
                height: 35,
                width: 35,
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                'Focus Mode',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                _buildTabBar(),
                Expanded(
                    child: TabBarView(
                  controller: _tabController,
                  children: [
                    LearningDashboard(),
                    PurchasedBootcamp(),
                    Calendar()
                  ],
                ))
              ],
            )));
  }

  Widget _buildTabBar() {
    return Material(
      color: Colors.white,
      child: TabBar(
        labelPadding: const EdgeInsets.all(0),
        indicatorColor: primaryColor,
        labelColor: primaryColor,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: const Color(0xFF474747),
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 3.0,
              color: primaryColor,
            ),
          ),
        ),
        controller: _tabController,
        tabs: [
          Tab(
            child: _buildTabBarItem(
              "assets/images/new_dashboard.png",
              "Dashboard",
              _currentIndex == 0,
            ),
          ),
          Tab(
            child: _buildTabBarItem(
              "assets/images/purchased_tag.png",
              "Purchased",
              _currentIndex == 1,
            ),
          ),
          Tab(
            child: _buildTabBarItem(
              "assets/images/calendar_icon.png",
              "Calendar",
              _currentIndex == 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBarItem(String iconPath, String label, bool isSelected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          iconPath,
          height: 20,
          width: 20,
          color: isSelected ? primaryColor : null,
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? primaryColor : const Color(0xFF474747),
          ),
        ),
      ],
    );
  }
}
