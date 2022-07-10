import 'dart:ui' show lerpDouble;
import 'package:automobileservice/view/add_feedback.dart';
import 'package:automobileservice/view/admin/feedbacks.dart';
import 'package:automobileservice/view/admin/map_screen.dart';
import 'package:automobileservice/view/admin/service_centers.dart';
import 'package:automobileservice/view/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManagerDashboard extends StatefulWidget {
  static const routeName = '/managerDashboard';
  const ManagerDashboard({
    Key? key,
  }) : super(key: key);

  @override
  _ManagerDashboardState createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard>
    with WidgetsBindingObserver {
  int _pageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: _pageIndex,
      keepPage: false,
    );

    super.initState();
  }

  double? _getIndicatorPosition(int index) {
    var isLtr = Directionality.of(context) == TextDirection.ltr;
    if (isLtr) {
      return lerpDouble(-1.0, 1.0, index / 4);
    } else {
      return lerpDouble(1.0, -1.0, index / 4);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        int currentPos = _pageController.page?.round() ?? 0;
        if (currentPos == 0) {
          return true;
        } else {
          onTabTapped(0);
          return false;
        }
      },
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: 58,
          child: Stack(
            children: [
              BottomNavigationBar(
                  onTap: onTabTapped,
                  unselectedIconTheme: const IconThemeData(
                    color: Colors.black,
                  ),
                  selectedIconTheme: const IconThemeData(
                    color: Color(0xFF107189),
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 11.0,
                    color: Colors.black,
                  ),
                  selectedLabelStyle: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.black,
                  showUnselectedLabels: true,
                  currentIndex: _pageIndex,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: "Profile",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.person_3_fill),
                      label: "Driver",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.map),
                      label: "Map",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.person_crop_square_fill),
                      label: "Employee",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.time_to_leave),
                      label: "Vehicle",
                    )
                  ]),
              Positioned(
                top: 0,
                width: width,
                child: AnimatedAlign(
                  alignment: Alignment(_getIndicatorPosition(_pageIndex)!, 0),
                  curve: Curves.linear,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    color: const Color(0xFF107189),
                    width: width / 5,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: PageView(
            onPageChanged: onPageChanged,
            controller: _pageController,
            allowImplicitScrolling: false,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              Profile(),
              ServiceCenters(),
              MapScreen(),
              AddFeedback(),
              Feedbacks(),
            ],
          ),
        ),
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

  void onTabTapped(int index) async {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }
}
