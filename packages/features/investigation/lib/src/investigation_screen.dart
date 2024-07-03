import 'package:flutter/material.dart';

import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:ipd_repository/ipd_repository.dart';
import 'package:user_repository/user_repository.dart';

class InvestigationScreen extends StatefulWidget {
  final IpdRepository ipdRepository;
  final UserRepository userRepository;
  final Inpatient selectedInpatient;

  const InvestigationScreen({
    super.key,
    required this.ipdRepository,
    required this.userRepository,
    required this.selectedInpatient,
  });

  @override
  State<InvestigationScreen> createState() => _InvestigationScreenState();
}

class _InvestigationScreenState extends State<InvestigationScreen> {
  final TextEditingController _testController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Spacing.xxLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          CustomDropDownMenu(
            dropDownMenuEntries: <DropdownMenuEntry<String>>[
              DropdownMenuEntry<String>(
                label: IpdRepository.labTest.keys.first,
                value: IpdRepository.labTest.values.first,
              ),
              DropdownMenuEntry<String>(
                label: IpdRepository.labTest.keys.last,
                value: IpdRepository.labTest.values.last,
              ),
            ],
            onSelected: (labTestConcept) {
              if (labTestConcept != null) _testController.text = labTestConcept;
            },
            helperText: 'Test',
          ),
          const SizedBox(
            height: Spacing.medium,
          ),
          CustomInputTextField(
            labelText: 'Remarks',
            controller: _remarksController,
          ),
          const SizedBox(
            height: Spacing.xxLarge,
          ),
          Center(child: RoundFormButton(label: "Request", onPressed: () async {
            final submissionTime = widget.ipdRepository.toIso8601WithMillis(DateTime.now());
            List<Order> orders = [];

            // _testController.text != ''
            //     ? orders.add(Order(
            //     patient: widget.selectedInpatient.id,
            //     orderDatetime: submissionTime,
            //     concept: _testController.text,
            //     orderer: IpdRepository.provider,
            //     orderType: IpdRepository.orderTypeInvestigation,
            //     instructions: _remarksController.text,
            //     voided: false))
            //     : null;

            final encounterProviders = [
              EncounterProvider(
                  provider: IpdRepository.provider,
                  encounterRole: IpdRepository.encounterRole)
            ];

            final currentUserSessionId =
                await widget.userRepository.getUserSessionId();
            print("*********SESSEION ID: $currentUserSessionId");
            print("*********INPATIENT ID: ${widget.selectedInpatient.id}");
            final selectedInpatientVisitId =
                await widget.ipdRepository.getInpatientVisitId(
                currentUserSessionId ?? '',
                widget.selectedInpatient.id);
            print("**********VISIT ID: $selectedInpatientVisitId");
            // final encounter = Encounter(
            //   patient: widget.selectedInpatient.id,
            //   encounterType: IpdRepository.encounterTypeIpd,
            //   encounterProviders: encounterProviders,
            //   visit: selectedInpatientVisitId,
            //   observations: observations,
            //   ipdForm: ipdForm,
            //   location: IpdRepository.locationIpd,
            // );

            // await widget.ipdRepository.createEncounter(
            //     encounter, currentUserSessionId ?? '');
          }))
        ],
      ),
    );
  }
}
