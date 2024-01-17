import 'dart:ffi';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_screen_utils/responsive_screen_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  String imageUrl = ''; // To store the selected image URL

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageUrl = pickedFile.path; // Store the local image path
      });
    }
  }

  void saveUserData() async {
    // Get the current user's ID from Firebase Authentication.
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userId = currentUser.uid;

      // Create a map to store the updated user data.
      final Map<String, dynamic> updatedUserData = {
        'email': currentUser.email,

        // Update the fields the user is editing
        'name': nameController.text,
        'phone_number': phoneController.text,
        'address': addressController.text,
        'cnic': cnicController.text,
        'zip_code': zipCodeController.text,
        'profile_image': imageUrl,
        'rool': 'Buyer',
        // Store the selected image URL
      };

      // Update the user data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .set(updatedUserData);

      Get.snackbar('Success', 'User data saved successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF22B25D),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          // ... your existing code ...

          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 20.0.w),
            child: Container(
              // ... your existing code ...

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Circular Avatar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          pickImage(); // Open image picker when the user taps the avatar
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0xFF22B25D),
                          radius: 50.0,
                          backgroundImage: imageUrl.isNotEmpty
                              ? FileImage(File(imageUrl))
                              : null,
                          child: imageUrl.isEmpty
                              ? Icon(
                                  Icons.camera_alt,
                                  size: 40.0,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  // Text Fields for user data
                  TextFormField(
                    controller: nameController,
                    keyboardAppearance: Brightness.dark,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsetsDirectional.all(14),
                        labelText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(17.0.r))),
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    keyboardAppearance: Brightness.dark,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsetsDirectional.all(14),
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(17.0.r))),
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  TextFormField(
                    controller: addressController,
                    keyboardAppearance: Brightness.dark,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsetsDirectional.all(14),
                        labelText: 'Address',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(17.0.r))),
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  TextFormField(
                    controller: cnicController,
                    keyboardType: TextInputType.number,
                    keyboardAppearance: Brightness.dark,
                    maxLength: 13,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsetsDirectional.all(14),
                        labelText: 'CNIC',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(17.0.r))),
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    keyboardAppearance: Brightness.dark,
                    maxLength: 6,
                    controller: zipCodeController,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsetsDirectional.all(14),
                        labelText: 'Zip Code',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(17.0.r))),
                  ),
                  SizedBox(
                    height: 10.0.h,
                  ),
                  // Save button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xFF22B25D)),
                        ),
                        onPressed: () {
                          saveUserData(); // Call a function to update user data
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
