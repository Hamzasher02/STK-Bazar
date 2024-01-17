import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF22B25D),
        centerTitle: true,
        title: Text(
          "Contact Us",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                launchWhatsApp(
                    "03135975671"); // Replace with your WhatsApp number
              },
              child: Text("Chat on WhatsApp"),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                sendEmail(
                    "example@email.com"); // Replace with your email address
              },
              child: Text("Send Email"),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                makePhoneCall("03135975671"); // Replace with your phone number
              },
              child: Text("Make Phone Call"),
            ),
          ],
        ),
      ),
    );
  }

  void launchWhatsApp(String phone) async {
    final whatsappUrl = "https://wa.me/$phone";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Could not launch WhatsApp.';
    }
  }

  void sendEmail(String email) async {
    final emailUrl = "mailto:$email";
    if (await canLaunch(emailUrl)) {
      await launch(emailUrl);
    } else {
      throw 'Could not send email.';
    }
  }

  void makePhoneCall(String phone) async {
    final phoneUrl = "tel:$phone";
    if (await canLaunch(phoneUrl)) {
      await launch(phoneUrl);
    } else {
      throw 'Could not make a phone call.';
    }
  }
}
