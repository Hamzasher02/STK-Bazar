import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:responsive_screen_utils/responsive_screen_utils.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF22B25D),
        centerTitle: true,
        title: Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (_user != null)
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFF22B25D),
                          radius: 50.0,
                          child: Image.network(
                            _user!.photoURL ?? '',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              // Display a placeholder image or error message
                              return Icon(
                                Icons.person,
                                size: 100.0,
                                color: Color.fromARGB(255, 255, 255, 255),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Name:\n$_userName',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Email:\n$_userEmail',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'CNIC:\n$_usercnic',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'phone:\n$_userphone',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Address:\n$_userAddress',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(),
                  ],
                ),
              )
            else
              Text('User not signed in'),
          ],
        ),
      ),
    );
  }
}
