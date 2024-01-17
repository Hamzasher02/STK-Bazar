import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:luckbyer/userModul/paymentscreem.dart';

import 'chartscreen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, dynamic> productData;

  ProductDetailScreen({required this.productData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF22B25D),
        title: Text(
          'Product Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              // Implement shopping cart functionality
              Get.to(CartScreen());
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(productData['image_url'] ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 233, 233, 232),
                      borderRadius: BorderRadius.circular(17.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Product: ${productData['name']}' ?? '',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'PKR ${productData['price']}',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 12, 12, 12),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'Ticket Price: ${productData['ticket_price']}',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 19, 18, 18),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'Shipping Status: ${productData['shipping_status']}',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'Description:',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            productData['description'] ?? '',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigate to payment gateway screen
                          double ticketPrice =
                              productData['ticket_price'] ?? 0.0;
                          Get.to(PaymentScreen());
                        },
                        child: Container(
                          width: 150.0,
                          height: 57.0,
                          decoration: BoxDecoration(
                            color: Color(0xFF22B25D),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Buy Ticket",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Icon(
                                  Icons.payment,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Create a Product object and add it to the cart
                          final product = Product(
                            image: productData['image_url'] ?? '',
                            name: productData['name'] ?? '',
                            price: productData['price'] ?? 0,
                          );
                          CartScreen.cartItems.add(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Product added to cart'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: Container(
                          width: 150.0,
                          height: 57.0,
                          decoration: BoxDecoration(
                            color: Color(0xFF22B25D),
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Icon(
                                  Icons.add_shopping_cart_sharp,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
