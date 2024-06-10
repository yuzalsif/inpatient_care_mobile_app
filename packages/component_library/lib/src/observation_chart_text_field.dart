import 'package:flutter/material.dart';

class ResizableTextField extends StatefulWidget {
 // final String labelText;
  final TextEditingController controller;

  ResizableTextField({
   // required this.labelText,
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
      decoration: BoxDecoration(
        color: Colors.white, // Set container background color to white
      ),
      child: Stack(
        children: [
          TextField(
            controller: widget.controller,
            minLines: 1,
            maxLines: null, // Allow the TextField to grow vertically
            textAlignVertical: TextAlignVertical.center, // Center the text vertically
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
