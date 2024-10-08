import 'package:flutter/material.dart';

import 'package:component_library/component_library.dart';
import 'package:investigation/investigation.dart';
import 'package:management/management.dart';
import 'package:summary/summary.dart';
import 'package:domain_models/domain_models.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:user_repository/user_repository.dart';
import 'package:ipd_repository/ipd_repository.dart';

class RoundFormScreen extends StatefulWidget {
  final Inpatient inpatient;
  final IpdRepository ipdRepository;
  final UserRepository userRepository;

  const RoundFormScreen({
    super.key,
    required this.inpatient,
    required this.ipdRepository,
    required this.userRepository,
  });

  @override
  State<RoundFormScreen> createState() => _RoundFormScreenState();
}

class _RoundFormScreenState extends State<RoundFormScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.mediumLarge),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              _PatientCard(
                patientName: widget.inpatient.name,
                age: widget.inpatient.age.toString(),
                gender: widget.inpatient.gender,
                mobileNumber: widget.inpatient.phoneNumber,
              ),
              const SizedBox(height: Spacing.large),
              TabBar(
                tabs: const [
                  // Text('Summary'),
                  Text('Diagnosis'),
                  Text('Management'),
                ],
                dividerColor: Colors.transparent,
                indicatorColor: const Color(0xFF3579F8).withOpacity(0.9),
                unselectedLabelStyle: TextStyle(
                    color: const Color(0xFF1E1E1E).withOpacity(0.8),
                    fontWeight: FontWeight.w500),
                labelStyle: const TextStyle(
                    color: Color(0xFF1E1E1E), fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: Spacing.mediumLarge),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: Spacing.xLarge, right: Spacing.xLarge),
                  child: TabBarView(children: [
                    // const SummaryScreen(),
                    InvestigationScreen(
                      ipdRepository: widget.ipdRepository,
                      userRepository: widget.userRepository,
                      selectedInpatient: widget.inpatient,
                    ),
                    ManagementScreen(
                      ipdRepository: widget.ipdRepository,
                      userRepository: widget.userRepository,
                      selectedInpatient: widget.inpatient,
                    ),
                  ]),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class _PatientCard extends StatelessWidget {
  final String patientName;
  final String gender;
  final String age;
  final String mobileNumber;

  const _PatientCard({
    required this.patientName,
    required this.age,
    required this.gender,
    required this.mobileNumber,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: Colors.grey[100],
            child: Icon(Icons.person, size: 70, color: Colors.grey[350]),
          ),
          const SizedBox(width: Spacing.mediumLarge),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  patientName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E1E1E).withOpacity(0.8),
                  ),
                ),
                _PatientCardInfoRow(label: 'Age:', value: age),
                _PatientCardInfoRow(label: 'Sex:', value: gender),
                _PatientCardPhoneNumberRow(phoneNumber: mobileNumber),
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

class _PatientCardPhoneNumberRow extends StatelessWidget {
  final String phoneNumber;

  const _PatientCardPhoneNumberRow({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contacts:',
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF1E1E1E)),
        ),
        const SizedBox(width: Spacing.xSmall),
        GestureDetector(
          onTap: () {
            launchUrlString('tel://$phoneNumber');
          },
          child: Text(
            phoneNumber,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: const Color(0xFF3579F8).withOpacity(0.8)),
          ),
        ),
      ],
    );
  }
}
