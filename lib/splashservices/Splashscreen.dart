import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luckbyer/Auth/login/Userlogin.dart';
import 'package:luckbyer/startappscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3), () {
      Get.offAll(LoginPage());
    });
  }

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
        )),
        child: Column(children: [Text('this splash')]),
      ),
    );
  }
}
