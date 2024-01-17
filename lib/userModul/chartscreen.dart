import 'dart:ui';

import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  static List<Product> cartItems = [];

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF22B25D),
        title: Text(
          'Shopping Cart',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: CartScreen.cartItems.isNotEmpty
          ? ListView.builder(
              itemCount: CartScreen.cartItems.length,
              itemBuilder: (context, index) {
                final product = CartScreen.cartItems[index];
                return Card(
                  child: ListTile(
                    leading: product != null && product.image != null
                        ? Image.network('${product.image}')
                        : Icon(Icons.production_quantity_limits),
                    title: Text(product.name),
                    subtitle: Text('Price: PKR ${product.price}'),
                  ),
                );
              },
            )
          : Center(
              child: Text('Your cart is empty.'),
            ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final Image? image;

  Product({required this.name, required this.price, required this.image});
}
