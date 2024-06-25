import 'package:flutter/material.dart';

class ObservationChartScreen extends StatelessWidget {
  ObservationChartScreen({super.key});

  final TextEditingController weightController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController pulseController = TextEditingController();
  final TextEditingController respiratoryRateController =
      TextEditingController();
  final TextEditingController systolicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          title: const Text(
            'Observation chart',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xff1E1E1E)),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildObservationChartTextField(
                labelText: 'Weight in kg',
                controller: weightController,
              ),
              const SizedBox(
                height: 24,
              ),
              _buildObservationChartTextField(
                labelText: 'Temperature',
                controller: temperatureController,
              ),
              const SizedBox(
                height: 24,
              ),
              _buildObservationChartTextField(
                labelText: 'Pulse',
                controller: pulseController,
                helperText: '(36 - 37) Celsius',
              ),
              const SizedBox(
                height: 24,
              ),
              _buildObservationChartTextField(
                labelText: 'Respiratory rate',
                controller: respiratoryRateController,
                helperText: '(60-100) beats/min',
              ),
              const SizedBox(
                height: 24,
              ),
              _buildObservationChartTextField(
                labelText: 'Systolic',
                controller: systolicController,
                helperText: '(12 - 16) breaths/min',
              ),
              const SizedBox(
                height: 100,
              ),
              _buildObservationChartButton(text: 'Save', onPressed: () {})
            ],
          ),
        ));
  }
}

Widget _buildObservationChartTextField({
  required labelText,
  required TextEditingController controller,
  String? helperText,
}) {
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
  );
}

Widget _buildObservationChartButton({
  required String text,
  required VoidCallback onPressed,
  IconData? icon,
}) {
  return icon != null
      ? ElevatedButton(
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
      : ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(225, 45),
            backgroundColor:
                const Color(0xFF3579F8), // Button expands to full width
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
