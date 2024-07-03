import 'package:flutter/material.dart';

import 'package:component_library/component_library.dart';
import 'package:ipd_repository/ipd_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:domain_models/domain_models.dart';

class ManagementScreen extends StatefulWidget {
  final IpdRepository ipdRepository;
  final UserRepository userRepository;
  final Inpatient selectedInpatient;

  const ManagementScreen({
    super.key,
    required this.ipdRepository,
    required this.userRepository,
    required this.selectedInpatient,
  });

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  final TextEditingController _managementController = TextEditingController();

  @override
  void dispose() {
    _managementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Spacing.xxLarge),
      child: Column(
        children: [
          CustomDropDownMenu(
              dropDownMenuEntries: <DropdownMenuEntry<String>>[
                ...IpdRepository.prescription.entries.map((entry) {
                  return DropdownMenuEntry<String>(
                    value: entry.key,
                    label: entry.key,
                  );
                }),
              ],
              onSelected: (prescriptionConcept) {
                if (prescriptionConcept != null) {
                  _managementController.text = prescriptionConcept;
                }
              },
              helperText: 'Add prescription'),
          const SizedBox(
            height: Spacing.xxLarge,
          ),
          RoundFormButton(
            label: 'Add management',
            onPressed: () async {
              try {
                List<Order> orders = [];
                final submissionTime = widget.ipdRepository.toIso8601WithMillis(DateTime.now());

                _managementController.text != ''
                    ? orders.add(Order(
                        patient: widget.selectedInpatient.id,
                        action: "NEW",
                        careSetting: "INPATIENT",
                        concept: IpdRepository.conceptManagement,
                        orderer: IpdRepository.provider,
                        orderType: IpdRepository.orderTypeManagement,
                        urgency: "ROUTINE",
                        type: "order",
                      ))
                    : null;

                final encounterProviders = [
                  EncounterProvider(
                      provider: IpdRepository.provider,
                      encounterRole: IpdRepository.encounterRole)
                ];

                final currentUserSessionId =
                    await widget.userRepository.getUserSessionId();
                print("*********SESSEION ID: $currentUserSessionId");
                print("*********INPATIENT ID: ${widget.selectedInpatient.id}");
                final selectedInpatientVisitId = await widget.ipdRepository
                    .getInpatientVisitId(currentUserSessionId ?? '',
                        widget.selectedInpatient.id);
                print("**********VISIT ID: $selectedInpatientVisitId");
                final encounter = Encounter(
                  patient: widget.selectedInpatient.id,
                  encounterType: IpdRepository.encounterTypeClinic,
                  order: orders,
                  encounterProviders: encounterProviders,
                  visit: selectedInpatientVisitId,
                  location: IpdRepository.locationClinic,
                );

                final encounterUuid = await widget.ipdRepository
                    .createEncounter(encounter, currentUserSessionId ?? '');

                print("**********ENCOUNTER UID: $encounterUuid");
                await widget.ipdRepository.updateEncounter(
                  observations: {
                    "obs": [
                      {
                        "person": widget.selectedInpatient.id,
                        "concept": IpdRepository.conceptManagement,
                        "obsDatetime": submissionTime,
                        "value": IpdRepository.prescription[_managementController.text] ?? '',
                        "comment": _managementController.text
                      }
                    ]
                  },
                  authenticationToken: currentUserSessionId ?? '',
                  encounterUuid: encounterUuid,
                );
              } catch (e) {
                print("**********ERROR: $e");
              }
            },
          )
        ],
      ),
    );
  }
}
