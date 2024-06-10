import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  // final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  CustomTextField({
    // required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        // labelText: labelText,
        // border: OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
