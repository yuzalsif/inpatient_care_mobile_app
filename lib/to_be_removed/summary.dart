import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Add Summary',
          style: TextStyle(
            color: Color(0xFF1E1E1E),
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: Spacing.xxLarge,
        ),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Summary',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: Spacing.xxLarge,
        ),
        RoundFormButton(label: "Add summary", onPressed: () {})
      ],
    );
  }
}
