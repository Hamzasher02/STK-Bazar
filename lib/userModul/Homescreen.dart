import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:luckbyer/userModul/Drwaer.dart';
import 'package:luckbyer/userModul/Nottifi.dart';
import 'package:responsive_screen_utils/responsive_screen_utils.dart';
import 'ProductDetailscreen.dart';

class UserHomescreen extends StatefulWidget {
  const UserHomescreen({super.key});

  @override
  State<UserHomescreen> createState() => _UserHomescreenState();
}

class _UserHomescreenState extends State<UserHomescreen> {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF22B25D),
        title: Text(
          'SKT BazzaR',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              // onTap: () => Get.to(Notificationscreen()),
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      drawer: Drwaerscreen(),
      drawerDragStartBehavior: DragStartBehavior.down,
      drawerScrimColor: Color(0xFF22B25D),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(84, 255, 255, 255),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: TextEditingController(text: searchQuery),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        suffixIconColor: Color(0xFF22B25D),
                        semanticCounterText: String.fromCharCode(12),
                        suffixIconConstraints: BoxConstraints.tight(
                          // ignore: invalid_use_of_visible_for_testing_member
                          Magnifier.kDefaultMagnifierSize,
                        ),
                        fillColor: Color.fromARGB(255, 171, 193, 218),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(17.0.r),
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: productsCollection
                        .where('name', isGreaterThanOrEqualTo: searchQuery)
                        .where('name', isLessThan: searchQuery + 'z')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<QueryDocumentSnapshot> products =
                            snapshot.data!.docs;

                        return SizedBox(
                          height: 600.0.h,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0.w,
                                mainAxisSpacing: 10.0.h,
                              ),
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final productData = products[index].data()
                                    as Map<String, dynamic>;

                                return InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => ProductDetailScreen(
                                        productData: productData,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 7,
                                            blurStyle: BlurStyle.normal,
                                            color: Color(0xFF22B25D))
                                      ],
                                      color: Color.fromARGB(255, 194, 191, 191),
                                      borderRadius:
                                          BorderRadius.circular(17.0.r),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 150.0.h, // Adjust as needed
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      productData[
                                                              'image_url'] ??
                                                          ''),
                                                ),
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(17),
                                                    topRight:
                                                        Radius.circular(17))),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                214, 248, 248, 248),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                productData['name'] ?? '',
                                                style: TextStyle(
                                                  fontSize: 14.0.h,
                                                  color: const Color.fromARGB(
                                                      255, 20, 20, 20),
                                                ),
                                              ),
                                              Text(
                                                '${productData['price'] ?? 0}',
                                                style: TextStyle(
                                                  fontSize: 10.0.h,
                                                  color: const Color.fromARGB(
                                                      255, 58, 57, 57),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 2,
                                                    bottom: 4,
                                                    left: 10,
                                                    right: 10),
                                                child: Container(
                                                  height: 40,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF22B25D),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              17)),
                                                  child: Center(
                                                    child: Text(
                                                      'TC Rs.: ${productData['ticket_price'] ?? 0}',
                                                      style: TextStyle(
                                                        fontSize: 15.0.h,
                                                        color: Colors.white,
                                                      ),
                                                    ),
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
                              },
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
