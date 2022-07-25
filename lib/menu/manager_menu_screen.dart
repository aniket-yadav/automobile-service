import 'package:automobileservice/menu/menu_header.dart';
import 'package:automobileservice/utils/session_manager.dart';
import 'package:automobileservice/view/add_feedback.dart';
import 'package:automobileservice/view/admin/services.dart';
import 'package:automobileservice/view/login.dart';
import 'package:flutter/material.dart';

class ManagerMenuScreen extends StatefulWidget {
  final VoidCallback? closeDrawer;
  const ManagerMenuScreen({Key? key, this.closeDrawer}) : super(key: key);

  @override
  State<ManagerMenuScreen> createState() => _ManagerMenuScreenState();
}

class _ManagerMenuScreenState extends State<ManagerMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFF2F9FB),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const MenuHeader(),
            const SizedBox(
              height: 8,
            ),
            Divider(
              color: const Color(0xff444444).withOpacity(0.8),
              thickness: 0.2,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  InkWell(
                    onTap: () {
                      widget.closeDrawer!();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.account_circle_outlined,
                            color: Color(0xFF107189),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      widget.closeDrawer!();
                      Navigator.of(context).pushNamed(Services.routeName);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.featured_play_list_outlined,
                            color: Color(0xFF107189),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Services",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      widget.closeDrawer!();
                      Navigator.of(context).pushNamed(AddFeedback.routeName);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.feedback,
                            color: Color(0xFF107189),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Feedback",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      SessionManager.signOut();
                      if (!(await SessionManager.hasUser())) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Login.routeName, (Route<dynamic> route) => false);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.logout,
                            color: Color(0xFF107189),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "logout",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
