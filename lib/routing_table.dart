import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import 'package:inpatient_care_mobile_app/round_form_screen.dart';
import 'package:inpatient_care_mobile_app/tablet_tab_container_screen.dart';
import 'package:patient_list/patient_list.dart';
import 'package:sign_in/sign_in.dart';
import 'package:special/special.dart';
import 'package:nurse_treatment_sheet/nurse_treatment_sheet.dart';
import 'package:observation_chart/observation_chart.dart';
import 'package:user_repository/user_repository.dart';

Map<String, PageBuilder> buildRoutingTable({
  required RoutemasterDelegate routerDelegate,
  required UserRepository userRepository,
}) {
  return {
    _PathConstants.tabletTabContainerPath: (_) => MaterialPage(
          name: 'tablet_tab_container',
          child: Builder(
            builder: (context) {
              return const TabletTabContainerScreen();
            },
          ),
        ),
    _PathConstants.mobileTabContainerPath: (_) => CupertinoTabPage(
      child: Container(), //TODO: Replace this with an actual widget
          paths: [
            _PathConstants.mobileTabContainerMedicalPath,
            _PathConstants.mobileTabContainerVitalsPath,
            _PathConstants.mobileTabContainerSpecialPath,
          ]
        ),
    _PathConstants.mobileTabContainerMedicalPath: (_) => MaterialPage(
          name: 'medical',
          child: Builder(
            builder: (context) {
              return const NurseTreatmentSheetScreen();
            },
          ),
        ),
    _PathConstants.mobileTabContainerVitalsPath: (_) => MaterialPage(
          name: 'vitals',
          child: Builder(
            builder: (context) {
              return ObservationChartScreen();
            },
          ),
        ),
    _PathConstants.mobileTabContainerSpecialPath: (_) => MaterialPage(
          name: 'special',
          child: Builder(
            builder: (context) {
              return const SpecialScreen();
            },
          ),
        ),
    _PathConstants.signInPath: (_) => MaterialPage(
          name: 'sign-in',
          fullscreenDialog: true,
          child: Builder(
            builder: (context) {
              //   return SignInScreen(
              //     userRepository: userRepository,
              //     onSignInSuccess: () {
              //        Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => InpatientListScreen()),
              // );
              //     },
              //   );
              return RoundFormScreen();
            },
          ),
        ),
    _PathConstants.inpatientListPath: (_) => MaterialPage(
          name: 'inpatient-list',
          child: Builder(
            builder: (context) {
              return InpatientListScreen();
            },
          ),
        ),
  };
}

class _PathConstants {
  const _PathConstants._();

  static String get signInPath => '/sign_in';

  static String get inpatientListPath => '/patient_list';

  // static String get tabletTabContainerPath => '/tablet_tab_container';
  static String get tabletTabContainerPath => '/';

  static String get mobileTabContainerPath => '/tablet_rhs_tab_container';
  static String get mobileTabContainerMedicalPath => '$mobileTabContainerPath/medical';
  static String get mobileTabContainerVitalsPath => '$mobileTabContainerPath/vitals';
  static String get mobileTabContainerSpecialPath => '$mobileTabContainerPath/special';
}
