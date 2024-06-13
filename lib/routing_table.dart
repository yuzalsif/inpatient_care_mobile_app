import 'package:flutter/material.dart';
import 'package:inpatient_care_mobile_app/to_be_removed/nurse_treatment_sheet.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sign_in/sign_in.dart';
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
              return SignInScreen(
                userRepository: userRepository,
                onSignInSuccess: () {},
              );
            },
          ),
        ),
  };
}

class _PathConstants {
  const _PathConstants._();

  // static String get tabContainerPath => '/';
  static String get signInPath => '/';
}
