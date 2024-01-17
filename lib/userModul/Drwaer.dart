import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:luckbyer/Auth/login/Userlogin.dart';
import 'package:luckbyer/userModul/About.dart';
import 'package:luckbyer/userModul/Contcatscreen.dart';
import 'package:luckbyer/userModul/Homescreen.dart';
import 'package:responsive_screen_utils/responsive_screen_utils.dart';

class Drwaerscreen extends StatefulWidget {
  const Drwaerscreen({super.key});

  @override
  State<Drwaerscreen> createState() => _DrwaerscreenState();
}

class _DrwaerscreenState extends State<Drwaerscreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  String _userName = '';
  String _userEmail = '';
  String _usercnic = '';
  String _userphone = '';
  String _userAddress = '';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentSnapshot<Map<String, dynamic>> userData =
          await _firestore.collection('users').doc(user.uid).get();
      if (userData.exists) {
        setState(() {
          _user = user;
          _userName = userData.data()?['name'] ?? '';
          _userEmail = userData.data()?['email'] ?? '';
          _usercnic = userData.data()?['cnic'] ?? '';
          _userphone = userData.data()?['phone_number'] ?? '';
          _userAddress = userData.data()?['Address'] ?? '';
        });
      }
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to your login or home screen after successful logout
      // You can use Navigator.pushReplacement to prevent the user from going back to the previous screen.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoginPage()), // Replace LoginScreen with your login screen.
      );
    } catch (e) {
      print('Error during logout: $e');
      // Handle logout error, if any.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFF22B25D),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 80.0.r,
                  ),
                  radius: 60.0.r,
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              'Email: $_userEmail',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          SizedBox(
            height: 20.0.h,
          ),
          Divider(
            color: Color(0xFF22B25D),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              onTap: () => Get.to(UserHomescreen()),
              leading: Icon(
                Icons.home,
                color: Color(0xFF22B25D),
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: 20.0.h,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              onTap: () => Get.to(AboutScreen()),
              leading: Icon(
                Icons.info_outline_rounded,
                color: Color(0xFF22B25D),
              ),
              title: Text(
                'About Us',
                style: TextStyle(
                  fontSize: 20.0.h,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: Icon(
                Icons.settings,
                color: Color(0xFF22B25D),
              ),
              title: Text(
                'Setting',
                style: TextStyle(
                  fontSize: 20.0.h,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              onTap: () => Get.to(ContactScreen()),
              leading: Icon(
                Icons.contact_phone_outlined,
                color: Color(0xFF22B25D),
              ),
              title: Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20.0.h,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              onTap: () => Get.to(ContactScreen()),
              leading: Icon(
                Icons.logout,
                color: Color(0xFF22B25D),
              ),
              title: InkWell(
                onTap: () {
                  signOut();
                },
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 20.0.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
