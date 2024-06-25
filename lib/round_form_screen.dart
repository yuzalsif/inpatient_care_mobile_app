import 'package:flutter/material.dart';

import 'package:component_library/component_library.dart';
import 'package:investigation/investigation.dart';
import 'package:management/management.dart';
import 'package:summary/summary.dart';

class RoundFormScreen extends StatefulWidget {
  const RoundFormScreen({super.key});

  @override
  State<RoundFormScreen> createState() => _RoundFormScreenState();
}

class _RoundFormScreenState extends State<RoundFormScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.all(Spacing.medium),
          child: _PatientCard(
            patientName: 'John Doe',
            age: '25',
            gender: "Male",
          ),
        ),
        TabBar(
          tabs: const [
            Text('Summary'),
            Text('Diagnosis'),
            Text('Management'),
          ],
          indicatorColor: const Color(0xFF3579F8).withOpacity(0.9),
          unselectedLabelStyle: TextStyle(
              color: const Color(0xFF1E1E1E).withOpacity(0.8),
              fontWeight: FontWeight.w500),
          labelStyle: const TextStyle(
              color: Color(0xFF1E1E1E), fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: Spacing.mediumLarge),
        const TabBarView(children: [
          SummaryScreen(),
          InvestigationScreen(),
          ManagementScreen(),
        ])
      ]),
    );
  }
}

class _PatientCard extends StatelessWidget {
  final String patientName;
  final String gender;
  final String age;

  const _PatientCard({
    required this.patientName,
    required this.age,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.small),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 107, maxHeight: 107),
            child: Image.asset('assets/images/patient.png'),
          ),
          const SizedBox(width: Spacing.mediumLarge),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _PatientCardInfoRow(label: 'Name:', value: patientName),
            _PatientCardInfoRow(label: 'Age:', value: age),
            _PatientCardInfoRow(label: 'Sex:', value: gender),
          ])
        ],
      ),
    );
    ;
  }
}

class _PatientCardInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _PatientCardInfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontWeight: FontWeight.w500, color: Color(0xFF1E1E1E)),
        ),
        const SizedBox(width: Spacing.xSmall),
        Text(
          value,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1E1E1E).withOpacity(0.8)),
        ),
      ],
    );
  }
}
