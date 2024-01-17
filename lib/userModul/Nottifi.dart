import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notificationscreen extends StatefulWidget {
  Notificationscreen({Key? key}) : super(key: key);

  @override
  _NotificationscreenState createState() => _NotificationscreenState();
}

class _NotificationscreenState extends State<Notificationscreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Use Firestore for older Firebase version
  late StreamSubscription<QuerySnapshot> _subscription;

  @override
  void initState() {
    super.initState();
    initializeNotifications();
    _subscribeToProductChanges();
  }

  // Initialize the notifications plugin
  void initializeNotifications() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  // Show a sample notification
  void showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'New Product Added',
      'Check out the latest product in our store!',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  // Subscribe to changes in the "products" collection
  void _subscribeToProductChanges() {
    _subscription = _firestore.collection('products').snapshots().listen(
      (event) {
        // Handle the product data changes here
        // For example, you can check if a new product was added and show a notification
        for (final documentChange in event.docChanges) {
          if (documentChange.type == DocumentChangeType.added) {
            showNotification();
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _subscription
        .cancel(); // Cancel the Firestore listener when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Color(0xFF22B25D),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                Color.fromARGB(255, 24, 197, 216),
                Color.fromARGB(0, 255, 255, 255),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Trigger the notification manually for testing
            showNotification();
          },
          child: Text('Show Notification'),
        ),
      ),
    );
  }
}
