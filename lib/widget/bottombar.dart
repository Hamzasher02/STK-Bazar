import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:luckbyer/userModul/Homescreen.dart';
import 'package:luckbyer/userModul/ProductDetailscreen.dart';
import 'package:luckbyer/userModul/Profile.dart';
import 'package:luckbyer/userModul/Settingscreen.dart';

import '../userModul/UserProfilescreen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentTab = 0;

  final List<Widget> Pages = [
    UserHomescreen(),
    SettingScreen(),
    UserProfile(),
    Profile()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = UserHomescreen();

  @override
  Widget build(BuildContext context) {
    // final Newdihkerimage = SvgPicture.asset('assets/logos/clock.svg');
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomAppBar(
          surfaceTintColor: Colors.blueAccent,
          color: Colors.white,
          height: 70,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: FittedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = UserHomescreen();
                        currentTab = 0;
                      });
                    },
                    child: Icon(
                      Icons.home,
                      color: currentTab == 0
                          ? Color(0xFF22B25D)
                          : Colors.greenAccent,
                    )),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = const Profile();
                        currentTab = 1;
                      });
                    },
                    child: Icon(
                      Icons.person_add_alt,
                      color: currentTab == 1
                          ? Color(0xFF22B25D)
                          : Colors.greenAccent,
                    )
                    // SvgPicture.asset('assets/logos/Rectangle 14.svg')
                    ),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = UserProfile();
                        currentTab = 2;
                      });
                    },
                    child: Icon(
                      Icons.person_outline_sharp,
                      color: currentTab == 2
                          ? Color(0xFF22B25D)
                          : Colors.greenAccent,
                    )),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = SettingScreen();
                        currentTab = 3;
                      });
                    },
                    child: Icon(
                      Icons.settings,
                      color: currentTab == 3
                          ? Color(0xFF22B25D)
                          : Colors.greenAccent,
                    )),
              ],
            ),
          )),
    );
  }
}
