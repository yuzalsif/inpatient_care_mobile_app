import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {

 const CustomSearchBar({super.key, 
    this.controller,
     this.onChanged,
 });


 final TextEditingController? controller;
   final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
       // borderRadius: BorderRadius.circular(8),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 1,
        //     blurRadius: 5,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
      ),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Search for a patient',
          icon: Icon(Icons.search),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
