import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:component_library/component_library.dart';
import 'package:ipd_repository/ipd_repository.dart';
import 'package:user_repository/user_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'nurse_treatment_sheet_cubit.dart';

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
    return BlocProvider<NurseTreatmentSheetCubit>(
      create: (context) => NurseTreatmentSheetCubit(
        ipdRepository: widget.ipdRepository,
        userRepository: widget.userRepository,
        selectedInpatient: widget.selectedInpatient,
        oralMedicationController: _oralMedicationController,
        oralInfusionController: _oralInfusionController,
      ),
      child: NurseTreatmentSheetView(
        oralMedicationController: _oralMedicationController,
        oralInfusionController: _oralInfusionController,
      ),
    );
  }
}

class NurseTreatmentSheetView extends StatelessWidget {
  final TextEditingController oralMedicationController;
  final TextEditingController oralInfusionController;

  const NurseTreatmentSheetView({
    super.key,
    required this.oralMedicationController,
    required this.oralInfusionController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16, top: 16, bottom: 32),
            child: SingleChildScrollView(
              child: _NurseTreatmentSheetForm(
                oralMedicationController: oralMedicationController,
                oralInfusionController: oralInfusionController,
              ),
            ),
          ),
        ));
  }
}

class _NurseTreatmentSheetForm extends StatefulWidget {
  final TextEditingController oralMedicationController;
  final TextEditingController oralInfusionController;

  const _NurseTreatmentSheetForm({
    super.key,
    required this.oralMedicationController,
    required this.oralInfusionController,
  });

  @override
  State<_NurseTreatmentSheetForm> createState() =>
      _NurseTreatmentSheetFormState();
}

class _NurseTreatmentSheetFormState extends State<_NurseTreatmentSheetForm> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NurseTreatmentSheetCubit, NurseTreatmentSheetState>(
        builder: (context, state) {
          final isSubmissionInProgress =
              state.submissionStatus == SubmissionStatus.inProgress;
          final cubit = context.read<NurseTreatmentSheetCubit>();

          return Column(
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
                  CustomInputTextField(
                    labelText: 'Oral Medication',
                    controller: widget.oralMedicationController,
                  ),
                  // _InputField(
                  //   label: 'Oral Medication',
                  //   controller: widget.oralMedicationController,
                  // ),
                  const SizedBox(
                    height: Spacing.xxLarge,
                  ),
                  CustomInputTextField(
                    labelText: 'Oral Infusion / Treatment',
                    controller: widget.oralInfusionController,
                  )
                  // _InputField(
                  //   label: 'Oral Infusion / Treatment',
                  //   controller: widget.oralInfusionController,
                  // ),
                ],
              ),
              const SizedBox(height: Spacing.xxxLarge),
              Center(
                  child: isSubmissionInProgress
                      ? RoundFormButton.inProgress(label: 'saving')
                      : RoundFormButton(
                          label: 'Save',
                          onPressed: () async {
                            cubit.onSubmit();
                          })),
            ],
          );
        },
        listenWhen: (oldState, newState) =>
            oldState.submissionStatus != newState.submissionStatus,
        listener: (context, state) {
          final hasSubmissionError =
              state.submissionStatus == SubmissionStatus.genericError;

          final hasSubmissionSuccess =
              state.submissionStatus == SubmissionStatus.success;

          if (hasSubmissionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Data was saved successfully!'),
                ),
              );
          }

          if (hasSubmissionError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const GenericErrorSnackBar(),
              );
          }
        });
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
