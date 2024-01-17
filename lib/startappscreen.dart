import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:responsive_screen_utils/responsive_screen_utils.dart';

import 'Auth/login/Userlogin.dart';

class MainScreenModule extends StatefulWidget {
  MainScreenModule({Key? key});

  @override
  State<MainScreenModule> createState() => _MainScreenModuleState();
}

class _MainScreenModuleState extends State<MainScreenModule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 100, 201, 212),
              Color.fromARGB(0, 209, 181, 209)
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.dashboard_customize,
              color: Colors.white,
              size: 160.0.r,
            ),
            SizedBox(
              height: 80.0.h,
            ),
            InkWell(
              onTap: () => Get.to(LoginPage()),
              child: Container(
                width: 150.0.w,
                height: 57.0.h,
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Color(0xFFE0C3FC), Color(0x008EC5FC)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                ),
                child: Center(
                  child: Text(
                    "login",
                    style: TextStyle(
                      color: Color.fromARGB(255, 73, 166, 241),
                      fontSize: 20.0.h,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0.h,
            ),
          ],
        ),
      ),
    );
  }
}
