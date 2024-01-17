import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:luckbyer/adminModul/AddProducts.dart';
import 'package:luckbyer/adminModul/participatelist.dart';
import 'package:luckbyer/userModul/Homescreen.dart';

class BottomBara extends StatefulWidget {
  const BottomBara({super.key});

  @override
  State<BottomBara> createState() => _BottomBaraState();
}

class _BottomBaraState extends State<BottomBara> {
  int currentTab = 0;

  final List<Widget> Pages = [
    UserHomescreen(),
    UserListScreen(),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF22B25D),
        focusColor: Color.fromARGB(255, 221, 243, 230),
        hoverColor: Colors.greenAccent,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => Get.to(AddProduct()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          surfaceTintColor: Colors.blueAccent,
          color: Color(0xFF22B25D),
          height: 70,
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: FittedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                      color:
                          currentTab == 0 ? Colors.white : Colors.greenAccent,
                    )),
                SizedBox(
                  width: 200,
                ),
                MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = UserListScreen();
                        currentTab = 1;
                      });
                    },
                    child: Icon(
                      Icons.person_2_sharp,
                      color:
                          currentTab == 1 ? Colors.white : Colors.greenAccent,
                    )
                    // SvgPicture.asset('assets/logos/Rectangle 14.svg')
                    ),
              ],
            ),
          )),
    );
  }
}
