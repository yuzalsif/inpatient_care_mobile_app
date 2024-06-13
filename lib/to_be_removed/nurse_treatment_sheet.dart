import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:inpatient_care_mobile_app/to_be_removed/investigation.dart';
import 'package:inpatient_care_mobile_app/to_be_removed/summary.dart';

class NurseTreatmentSheetScreen extends StatefulWidget {
  const NurseTreatmentSheetScreen({super.key});

  @override
  State<NurseTreatmentSheetScreen> createState() => _NurseTreatmentSheetScreenState();
}

class _NurseTreatmentSheetScreenState extends State<NurseTreatmentSheetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nurse Treatment Sheet',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff1E1E1E))),
                    SizedBox(
                      height: Spacing.xLarge,
                    ),
                    _InputField(label: 'Oral Medication'),
                    SizedBox(
                      height: Spacing.xxxLarge,
                    ),
                    _InputField(label: 'Oral Infusion / Treatment'),
                  ],
                ),
                Center(child: RoundFormButton(text: 'Save', onPressed: () {} )),
              ],
            ),
          ),
        ));
  }
}

class _InputField extends StatefulWidget {
  final String label;

  const _InputField({super.key, required this.label});

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
                  autofocus: true,
                  decoration: InputDecoration(
                    label:  Text(
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
