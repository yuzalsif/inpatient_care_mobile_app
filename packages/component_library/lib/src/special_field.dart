import 'package:flutter/material.dart';

class SpecialField extends StatefulWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?>? onChanged;

  SpecialField({
    required this.title,
    required this.value,
    this.onChanged,
  });

  @override
  _SpecialFieldState createState() => _SpecialFieldState();
}

class _SpecialFieldState extends State<SpecialField> {
  late bool _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          activeColor: Colors.blue, 
          value: _currentValue,
          onChanged: (bool? newValue) {
            setState(() {
              _currentValue = newValue ?? false;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          },
        ),
         Text(widget.title, style: TextStyle(fontSize: 16),),
        
      ],
    );
  }
}