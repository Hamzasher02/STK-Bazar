import 'package:flutter/material.dart';

class TextFiledInput extends StatelessWidget {
  String lable1;
  final String hinttext;
  var controlsDetails;
  TextFiledInput(
      {super.key,
      required this.controlsDetails,
      required this.lable1,
      required this.hinttext});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlsDetails,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(17)),
        fillColor: Colors.white,
        filled: true,
        label: Text(lable1),
        hintText: hinttext,
      ),
    );
  }
}
