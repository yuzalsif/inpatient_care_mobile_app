
import 'package:flutter/material.dart';


class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  final TextEditingController managementController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 56),
      child: Column(children: [
        ResizableTextField(hintText: 'Add management', controller: managementController),
      const Spacer(),
      _buildManagementButton(text: 'Add', onPressed: () {}, icon:Icons.add )
      ],),
    );
  }
}

Widget _buildManagementButton({
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

class ResizableTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  ResizableTextField({
    required this.hintText,
    required this.controller,
  });

  @override
  _ResizableTextFieldState createState() => _ResizableTextFieldState();
}

class _ResizableTextFieldState extends State<ResizableTextField> {
  double _height = 100.0;
  final double _minHeight = 100.0;
  final double _maxHeight = 300.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: _height,
        maxHeight: _maxHeight,
      ),
      decoration: const BoxDecoration(
        color: Colors.white, // Set container background color to white
      ),
      child: Stack(
        children: [
          TextField(
            controller: widget.controller,
            minLines: 1,
            maxLines: null, // Allow the TextField to grow vertically
            textAlignVertical: TextAlignVertical.center, // Center the text vertically
            decoration:  InputDecoration(
              contentPadding: const EdgeInsets.all(8.0),
              border: InputBorder.none,
              hintText: widget.hintText,
              alignLabelWithHint: true, // Align label text at the center
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _height += details.delta.dy;
                  if (_height < _minHeight) _height = _minHeight;
                  if (_height > _maxHeight) _height = _maxHeight;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.transparent,
                child: CustomPaint(
                  size: const Size(20, 20),
                  painter: ResizeHandlePainter(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResizeHandlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2.0;

    // Increase the length of the diagonal lines and adjust their position
    const double lineLength = 15.0; // Length of the diagonal lines
    const double distanceFromBottom = 3.0; // Distance from the bottom

    // Draw the diagonal lines
    canvas.drawLine(
      Offset(size.width, size.height - distanceFromBottom - lineLength),
      Offset(size.width - lineLength, size.height - distanceFromBottom),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height - distanceFromBottom - lineLength / 2),
      Offset(size.width - lineLength / 2, size.height - distanceFromBottom),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
