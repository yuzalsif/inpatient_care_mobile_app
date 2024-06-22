import 'package:flutter/material.dart';
import 'package:inpatient_care_mobile_app/to_be_removed/nurse_treatment_sheet.dart';
import 'package:patient_list/patient_list.dart';

import 'package:routemaster/routemaster.dart';
import 'package:sign_in/sign_in.dart';
import 'package:special/special.dart';
import 'package:user_repository/user_repository.dart';

Map<String, PageBuilder> buildRoutingTable({
  required RoutemasterDelegate routerDelegate,
  required UserRepository userRepository,
}) {
  return {
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
              return const SpecialScreen();
            },
          ),
        ),
    _PathConstants.InpatientListPath: (_) => MaterialPage(
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

  // static String get tabContainerPath => '/';
  static String get signInPath => '/';

  static String get InpatientListPath => '/patient_list';
}
