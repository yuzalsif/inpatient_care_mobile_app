import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:ipd_repository/ipd_repository.dart';
import 'package:user_repository/user_repository.dart';

class ObservationChartScreen extends StatefulWidget {
  final IpdRepository ipdRepository;
  final UserRepository userRepository;
  final Inpatient selectedInpatient;

  const ObservationChartScreen({
    super.key,
    required this.ipdRepository,
    required this.userRepository,
    required this.selectedInpatient,
  });

  @override
  State<ObservationChartScreen> createState() => _ObservationChartScreenState();
}

class _ObservationChartScreenState extends State<ObservationChartScreen> {
  final TextEditingController _weightController = TextEditingController();

  final TextEditingController _temperatureController = TextEditingController();

  final TextEditingController _pulseController = TextEditingController();

  final TextEditingController _respiratoryRateController =
      TextEditingController();

  final TextEditingController _systolicController = TextEditingController();

  final TextEditingController _diastolicController = TextEditingController();

  bool isSubmissionInProgress = false;

  @override
  void dispose() {
    _weightController.dispose();
    _temperatureController.dispose();
    _pulseController.dispose();
    _respiratoryRateController.dispose();
    _systolicController.dispose();
    _diastolicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Padding(
          padding: const EdgeInsets.only(
              left: Spacing.mediumLarge,
              right: Spacing.mediumLarge,
              top: Spacing.mediumLarge,
              bottom: Spacing.xxxLarge),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Observation Chart',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff1E1E1E))),
                const SizedBox(
                  height: Spacing.xLarge,
                ),
                CustomInputTextField(
                  labelText: 'Weight in Kg',
                  controller: _weightController,
                ),
                const SizedBox(
                  height: Spacing.xLarge,
                ),
                CustomInputTextField(
                  labelText: 'Temperature',
                  controller: _temperatureController,
                  helperText: '(36 - 37) Celsius',
                ),
                const SizedBox(
                  height: Spacing.xLarge,
                ),
                CustomInputTextField(
                  labelText: 'Pulse',
                  controller: _pulseController,
                  helperText: '(0 -230) beats/min',
                ),
                const SizedBox(
                  height: Spacing.xLarge,
                ),
                CustomInputTextField(
                  labelText: 'Respiratory rate',
                  controller: _respiratoryRateController,
                  helperText: '(12 - 16) breaths/min',
                ),
                const SizedBox(
                  height: Spacing.xLarge,
                ),
                CustomInputTextField(
                  labelText: 'Systolic',
                  controller: _systolicController,
                  helperText: '(110 - 140) mmHg',
                ),
                const SizedBox(
                  height: Spacing.xLarge,
                ),
                CustomInputTextField(
                  labelText: 'Diastolic',
                  controller: _diastolicController,
                  helperText: '(70 -85) mmHg',
                ),
                const SizedBox(
                  height: Spacing.xxxLarge,
                ),
                Center(
                  child: isSubmissionInProgress
                      ? RoundFormButton.inProgress(label: 'saving')
                      : RoundFormButton(
                          label: 'Save',
                          onPressed: () async {
                            setState(() {
                              isSubmissionInProgress = true;
                            });
                            try {
                              final submissionTime = widget.ipdRepository
                                  .toIso8601WithMillis(DateTime.now());
                              List<Observation> observations = [];
                              _weightController.text != ''
                                  ? observations.add(Observation(
                                      person: widget.selectedInpatient.id,
                                      obsDatetime: submissionTime,
                                      concept: IpdRepository
                                          .conceptWeightObservationChart,
                                      value: _weightController.text,
                                      location: IpdRepository.locationIpd,
                                      status: "PRELIMINARY",
                                      voided: false))
                                  : null;

                              _temperatureController.text != ''
                                  ? observations.add(Observation(
                                      person: widget.selectedInpatient.id,
                                      obsDatetime: submissionTime,
                                      concept: IpdRepository
                                          .conceptTemperatureObservationChart,
                                      value: _temperatureController.text,
                                      location: IpdRepository.locationIpd,
                                      status: "PRELIMINARY",
                                      voided: false))
                                  : null;

                              _pulseController.text != ''
                                  ? observations.add(Observation(
                                      person: widget.selectedInpatient.id,
                                      obsDatetime: submissionTime,
                                      concept: IpdRepository
                                          .conceptPulseObservationChart,
                                      value: _pulseController.text,
                                      location: IpdRepository.locationIpd,
                                      status: "PRELIMINARY",
                                      voided: false))
                                  : null;

                              _respiratoryRateController.text != ''
                                  ? observations.add(Observation(
                                      person: widget.selectedInpatient.id,
                                      obsDatetime: submissionTime,
                                      concept: IpdRepository
                                          .conceptRespiratoryRateObservationChart,
                                      value: _respiratoryRateController.text,
                                      location: IpdRepository.locationIpd,
                                      status: "PRELIMINARY",
                                      voided: false))
                                  : null;

                              _systolicController.text != ''
                                  ? observations.add(Observation(
                                      person: widget.selectedInpatient.id,
                                      obsDatetime: submissionTime,
                                      concept: IpdRepository
                                          .conceptSystolicObservationChart,
                                      value: _systolicController.text,
                                      location: IpdRepository.locationIpd,
                                      status: "PRELIMINARY",
                                      voided: false))
                                  : null;

                              _diastolicController.text != ''
                                  ? observations.add(Observation(
                                      person: widget.selectedInpatient.id,
                                      obsDatetime: submissionTime,
                                      concept: IpdRepository
                                          .conceptDiastolicObservationChart,
                                      value: _diastolicController.text,
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
                                  uuid: IpdRepository.formIDObservationChart);

                              final currentUserSessionId = await widget
                                  .userRepository
                                  .getUserSessionId();
                              print(
                                  "*********SESSEION ID: $currentUserSessionId");
                              print(
                                  "*********INPATIENT ID: ${widget.selectedInpatient.id}");
                              final selectedInpatientVisitId = await widget
                                  .ipdRepository
                                  .getInpatientVisitId(
                                      currentUserSessionId ?? '',
                                      widget.selectedInpatient.id);
                              print(
                                  "**********VISIT ID: $selectedInpatientVisitId");
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

                              //Show success snack Bar
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                 const SnackBar(
                                    content: Text('Saved data successfully'),
                                  )
                                );
                              setState(() {
                                isSubmissionInProgress = false;
                              });
                            } catch (e) {
                              print(
                                  "****************ERRORRRR: ${e.toString()}");
                            }
                          }),
                )
              ],
            ),
          ),
        ));
  }
}

Widget _buildObservationChartTextField({
  required labelText,
  required TextEditingController controller,
  String? helperText,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      labelText: labelText,
      labelStyle: const TextStyle(fontSize: 18, color: Color(0xff8A8383)),
      helperText: helperText,
      helperStyle: const TextStyle(fontSize: 14, color: Color(0xff545454)),
      border: InputBorder.none,
    ),
  );
}
