import 'package:flutter/material.dart';

class NurseTreatmentSheet extends StatelessWidget {
  const NurseTreatmentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nurse treatment sheet'),
        backgroundColor: const Color(0xFFF5F5F5),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Oral medication'),
            SizedBox(height: 8,),
            ResizableTextField(),
            SizedBox(
              height: 32,
            ),
            Text('Oral infusions/Treatment'),
            SizedBox(height: 8,),
            ResizableTextField(),
            SizedBox(height: 100,),
            Center(child: RoundFormButton(text: 'Save', onPressed: () {}))
          ],
        ),
      ),
    );
  }
}

class ResizableTextField extends StatefulWidget {
  // final String labelText;
  // final TextEditingController controller;

  // ResizableTextField({
  //  // required this.labelText,
  //  // required this.controller,
  // });

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
      decoration: BoxDecoration(
        color: Colors.white, // Set container background color to white
      ),
      child: Stack(
        children: [
          TextField(
            //  controller: widget.controller,
            minLines: 1,
            maxLines: null, // Allow the TextField to grow vertically
            textAlignVertical:
                TextAlignVertical.center, // Center the text vertically
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              border: InputBorder.none,
              //labelText: widget.labelText,
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
                padding: EdgeInsets.all(8.0),
                color: Colors.transparent,
                child: CustomPaint(
                  size: Size(20, 20),
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
    final double lineLength = 15.0; // Length of the diagonal lines
    final double distanceFromBottom = 3.0; // Distance from the bottom

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
