import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart'; // Import fluttertoast package
import 'package:luckbyer/userModul/Nottifi.dart';
import 'package:luckbyer/widget/textfieldinput.dart';
import 'package:responsive_screen_utils/responsive_screen_utils.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController shippingStatusController = TextEditingController();
  TextEditingController ticketPriceController = TextEditingController();
  File? _image;

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Method to upload the image to Firebase Storage
  Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      final storage = FirebaseStorage.instance;
      final Reference storageReference = storage
          .ref()
          .child('product_images/${DateTime.now().millisecondsSinceEpoch}');

      final UploadTask uploadTask = storageReference.putFile(imageFile);

      final TaskSnapshot storageTaskSnapshot =
          await uploadTask.whenComplete(() {});

      final String imageURL = await storageTaskSnapshot.ref.getDownloadURL();
      return imageURL;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }

  // Method to show a success toast message
  void showSuccessToast() {
    Fluttertoast.showToast(
      msg: "Product uploaded successfully!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  // Method to add a product to Firestore
  Future<void> addProductToFirestore() async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Upload the image and get its URL
      String? imageURL;
      if (_image != null) {
        imageURL = await uploadImageToFirebase(_image!);
      }

      // Define the data you want to store
      Map<String, dynamic> productData = {
        'name': nameController.text,
        'price': double.tryParse(priceController.text) ?? 0.0,
        'shipping_status': shippingStatusController.text,
        'ticket_price': double.tryParse(ticketPriceController.text) ?? 0.0,
        'image_url': imageURL, // Store the image URL in Firestore
      };

      // Add the data to Firestore
      await firestore.collection('products').add(productData);

      // Show a success message or navigate to a different screen
      // For example, you can use Get.to(UserHomescreen()) here

      // Show a success toast message
      showSuccessToast();
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error adding product to Firestore: $e');
      // You can show an error message to the user if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF22B25D),
        actions: [
          GestureDetector(
            // onTap: () => Get.to(Notificationscreen()),
            child: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          )
        ],
        title: const Text(
          'Add Products',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 35.0.h),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(17.0.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0.r),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: Color(0xFF22B25D),
                                radius: 60.0.r,
                                child: GestureDetector(
                                  onTap: () async {
                                    await _pickImage();
                                  },
                                  child: _image != null
                                      ? Image.file(
                                          _image!,
                                          fit: BoxFit.cover,
                                        )
                                      : Center(
                                          child: Icon(
                                            Icons.add_box,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    // Add your camera capture logic here
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0.h,
                    ),
                    TextFiledInput(
                      controlsDetails: nameController,
                      lable1: 'Name',
                      hinttext: 'Name',
                    ),
                    SizedBox(
                      height: 20.0.h,
                    ),
                    TextFiledInput(
                      controlsDetails: priceController,
                      lable1: 'Price',
                      hinttext: 'Price',
                    ),
                    SizedBox(
                      height: 20.0.h,
                    ),
                    TextFiledInput(
                      controlsDetails: shippingStatusController,
                      lable1: "Shipping Status",
                      hinttext: 'Shipping Status',
                    ),
                    SizedBox(
                      height: 20.0.h,
                    ),
                    TextFiledInput(
                      controlsDetails: ticketPriceController,
                      lable1: 'Ticket Price',
                      hinttext: 'Ticket Price',
                    ),
                    SizedBox(
                      height: 50.0.h,
                    ),
                    InkWell(
                      onTap: () {
                        // Call the method to add the product to Firestore
                        addProductToFirestore();
                      },
                      child: Container(
                        width: 130.0.w,
                        height: 47.0.h,
                        decoration: ShapeDecoration(
                          color: Color(0xFF22B25D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Add Product",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
