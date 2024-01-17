import 'package:flutter/material.dart';

import 'package:responsive_screen_utils/responsive_screen_utils.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF22B25D),
        title: Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0.h),
                  child: Text(
                    'WELLCOME\n',
                    style: TextStyle(
                        fontSize: 30.0.h, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                'THE LUCKY BUYER This App proivde a good service for costumer @ and fully enjoy your luck in your life ',
                style: TextStyle(fontSize: 20.0.h),
              )
            ],
          ),
        ),
      ),
    );
  }
}
