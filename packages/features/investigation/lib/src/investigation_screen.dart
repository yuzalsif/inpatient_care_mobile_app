import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class InvestigationScreen extends StatefulWidget {
  const InvestigationScreen({super.key});

  @override
  State<InvestigationScreen> createState() => _InvestigationScreenState();
}

class _InvestigationScreenState extends State<InvestigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Request Investigation',
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
            labelText: 'Test',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: Spacing.medium,
        ),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Remarks',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: Spacing.xxLarge,
        ),
        RoundFormButton(label: "Request", onPressed: () {})
      ],
    );
  }
}
