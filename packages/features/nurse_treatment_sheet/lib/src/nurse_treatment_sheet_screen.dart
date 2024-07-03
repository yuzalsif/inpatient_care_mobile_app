import 'package:flutter/material.dart';

import 'package:component_library/component_library.dart';
import 'package:ipd_repository/ipd_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:domain_models/domain_models.dart';

class NurseTreatmentSheetScreen extends StatefulWidget {
  final IpdRepository ipdRepository;
  final UserRepository userRepository;
  final Inpatient selectedInpatient;

  const NurseTreatmentSheetScreen({
    super.key,
    required this.ipdRepository,
    required this.userRepository,
    required this.selectedInpatient,
  });

  @override
  State<NurseTreatmentSheetScreen> createState() =>
      _NurseTreatmentSheetScreenState();
}

class _NurseTreatmentSheetScreenState extends State<NurseTreatmentSheetScreen> {
  final TextEditingController _oralMedicationController =
      TextEditingController();
  final TextEditingController _oralInfusionController = TextEditingController();

  @override
  void dispose() {
    _oralMedicationController.dispose();
    _oralInfusionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16, top: 16, bottom: 32),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nurse Treatment Sheet',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1E1E1E))),
                      const SizedBox(
                        height: Spacing.xLarge,
                      ),
                      _InputField(
                        label: 'Oral Medication',
                        controller: _oralMedicationController,
                      ),
                      const SizedBox(
                        height: Spacing.xxxLarge,
                      ),
                      _InputField(
                        label: 'Oral Infusion / Treatment',
                        controller: _oralInfusionController,
                      ),
                    ],
                  ),
                  const SizedBox(height: Spacing.xxxLarge),
                  Center(
                      child: RoundFormButton(
                          label: 'Save',
                          onPressed: () async {
                            try {
                              final submissionTime = toIso8601WithMillis(DateTime.now());
                              List<Observation> observations = [];
                              _oralMedicationController.text != ''
                                  ? observations.add(Observation(
                                  person: widget.selectedInpatient.id,
                                  obsDatetime: submissionTime,
                                  concept: IpdRepository
                                      .conceptField1NurseTreatmentSheet,
                                  value: _oralMedicationController.text,
                                  location: IpdRepository.locationIpd,
                                  status: "PRELIMINARY",
                                  voided: false))
                                  : null;

                              _oralInfusionController.text != ''
                                  ? observations.add(Observation(
                                  person: widget.selectedInpatient.id,
                                  obsDatetime: submissionTime,
                                  concept: IpdRepository
                                      .conceptField2NurseTreatmentSheet,
                                  value: _oralInfusionController.text,
                                  location: IpdRepository.locationIpd,
                                  status: "PRELIMINARY",
                                  voided: false))
                                  : null;

                              final encounterProviders = [
                                EncounterProvider(
                                    provider: IpdRepository.provider,
                                    encounterRole: IpdRepository.encounterRole)
                              ];

                              final ipdForm = IpdForm(
                                  uuid: IpdRepository.formIDNurseTreatmentSheet);

                              final currentUserSessionId =
                              await widget.userRepository.getUserSessionId();
                              print("*********SESSEION ID: $currentUserSessionId");
                              print("*********INPATIENT ID: ${widget.selectedInpatient.id}");
                              final selectedInpatientVisitId =
                              await widget.ipdRepository.getInpatientVisitId(
                                  currentUserSessionId ?? '',
                                  widget.selectedInpatient.id);
                              print("**********VISIT ID: $selectedInpatientVisitId");
                              final encounter = Encounter(
                                patient: widget.selectedInpatient.id,
                                encounterType: IpdRepository.encounterTypeIpd,
                                encounterProviders: encounterProviders,
                                visit: selectedInpatientVisitId,
                                observations: observations,
                                ipdForm: ipdForm,
                                location: IpdRepository.locationIpd,
                              );

                              await widget.ipdRepository.createEncounter(
                                  encounter, currentUserSessionId ?? '');
                            } catch (e) {
                              print("****************ERRORRRR: ${e.toString()}");
                            }
                          })),
                ],
              ),
            ),
          ),
        ));
  }


  String toIso8601WithMillis(DateTime dateTime) {
    String y = dateTime.year.toString().padLeft(4, '0');
    String m = dateTime.month.toString().padLeft(2, '0');
    String d = dateTime.day.toString().padLeft(2, '0');
    String h = dateTime.hour.toString().padLeft(2, '0');
    String min = dateTime.minute.toString().padLeft(2, '0');
    String sec = dateTime.second.toString().padLeft(2, '0');
    String ms = (dateTime.millisecond / 1000).toStringAsFixed(3).substring(2);
    return "$y-$m-${d}T$h:$min:$sec.$ms" + "Z";
  }
}

class _InputField extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const _InputField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      width: double.infinity,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 36,
          bottom: 36,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
              child: TextField(
                autofocus: false,
                controller: widget.controller,
                decoration: InputDecoration(
                  label: Text(
                    widget.label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8A8383),
                    ),
                  ),
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
