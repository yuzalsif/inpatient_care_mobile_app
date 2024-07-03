import 'package:flutter/material.dart';

class CustomInputTextField extends StatelessWidget {
  final String labelText;
  final String? helperText;
  final TextEditingController controller;

  const CustomInputTextField({super.key,
    required this.labelText,
    required this.controller,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 18, color: Color(0xff8A8383)),
        helperText: helperText,
        helperStyle: const TextStyle(fontSize: 14, color: Color(0xff545454)),
        border: InputBorder.none,
      ),
    );;
  }
}
