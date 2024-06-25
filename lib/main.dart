import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inpatient_api/inpatient_api.dart';
import 'package:inpatient_care_mobile_app/routing_table.dart';
import 'package:routemaster/routemaster.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  runApp(const InpatientCareMobileApp());
}

class InpatientCareMobileApp extends StatefulWidget {
  const InpatientCareMobileApp({super.key});

  @override
  State<InpatientCareMobileApp> createState() => _InpatientCareMobileAppState();
}

class _InpatientCareMobileAppState extends State<InpatientCareMobileApp> {
  late final InpatientApi _inpatientApi = InpatientApi();

  late final _userRepository = UserRepository(
    remoteApi: _inpatientApi,
  );

  late final RoutemasterDelegate _routerDelegate = RoutemasterDelegate(
    routesBuilder: (context) {
      return RouteMap(
        routes: buildRoutingTable(
          routerDelegate: _routerDelegate,
          userRepository: _userRepository,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp.router(
        theme: ThemeData(
          primaryColor: const Color(0xFF3579F8),
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          ),
        debugShowCheckedModeBanner: false,
        routerDelegate: _routerDelegate,
        routeInformationParser: const RoutemasterParser(),
      );
  }
}