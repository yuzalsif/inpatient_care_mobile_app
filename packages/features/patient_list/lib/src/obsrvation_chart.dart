import 'package:flutter/material.dart';

class ObservationChart extends StatelessWidget {
  const ObservationChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Observation chart'),
        backgroundColor: const Color(0xFFF5F5F5),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NurseTreatmentSheetTextField(labelText: 'Weight in kg', ),
              SizedBox(height: 20,),
              NurseTreatmentSheetTextField(labelText: 'Temperature', ),
              SizedBox(height: 20,),
              NurseTreatmentSheetTextField(labelText: 'Pulse', helperText:'(36 - 37)celsius' ,),
              SizedBox(height: 12,),
              NurseTreatmentSheetTextField(labelText: 'Respiratory rate', helperText: '(60 - 100)beats/min',),
              SizedBox(height: 12,),
              NurseTreatmentSheetTextField(labelText: 'Systolic', helperText: '(12 - 16) breaths/min',),
              SizedBox(height: 100,),
              Center(child: RoundFormButton(text: 'Save', onPressed: () {}))
            ],
          ),
        ),
      ),
    );
  }
}

class NurseTreatmentSheetTextField extends StatelessWidget {
  final String labelText;
  final String? helperText;
//  final TextEditingController controller;

  NurseTreatmentSheetTextField({
    required this.labelText,
   this.helperText,
   // required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
     // controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 18, color: Color(0xff8A8383)),
        helperText: helperText,
        helperStyle: const TextStyle(fontSize: 14, color: Color(0xff545454)),
        border: InputBorder.none,
      ),
    );
  }
}


class RoundFormButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  RoundFormButton({super.key, required this.text, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return icon != null ? ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(225, 45),
        backgroundColor: const Color(0xFF3579F8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(width: 8.0), // Space between text and icon
          Icon(
            icon,
            color: Colors.white, // Predefined icon color
            size: 28, // Predefined icon size
          ),
        ],
      ),
    )
    :ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(225, 45),
        backgroundColor: const Color(0xFF3579F8), // Button expands to full width
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Border radius of 32
        ),
        elevation: 0, // Set button color to blue
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
