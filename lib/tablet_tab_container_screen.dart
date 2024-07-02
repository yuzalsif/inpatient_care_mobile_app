import 'package:domain_models/domain_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:inpatient_care_mobile_app/round_form_screen.dart';

import 'package:nurse_treatment_sheet/nurse_treatment_sheet.dart';
import 'package:observation_chart/observation_chart.dart';
import 'package:patient_list/patient_list.dart';
import 'package:special/special.dart';
import 'package:user_repository/user_repository.dart';
import 'package:inpatient_repository/inpatient_repository.dart';

class TabletTabContainerScreen extends StatefulWidget {
  final UserRepository userRepository;
  final InpatientRepository inpatientRepository;

  const TabletTabContainerScreen(
      {super.key,
      required this.userRepository,
      required this.inpatientRepository});

  @override
  State<TabletTabContainerScreen> createState() =>
      _TabletTabContainerScreenState();
}

class _TabletTabContainerScreenState extends State<TabletTabContainerScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF5F5F5),
        title: const Text(
          'Inpatient Care',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xff1E1E1E),
          ),
        ),
        toolbarHeight: 56,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert_outlined),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(
                  title: Text('Logout'),
                  leading: Icon(Icons.logout_outlined),
                ),
              ),
            ],
            onSelected: (String value) {
              // TODO: Handle menu item selection
            },
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: widget.inpatientRepository.getSelectedInpatient(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width:
                          size.width * ContainerSize.smallContainerWidthFactor,
                      height: size.height,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                      ),
                      child: InpatientListScreen(
                        inpatientRepository: widget.inpatientRepository,
                      ),
                    ),
                    SizedBox(
                      width:
                          size.width * ContainerSize.largeContainerWidthFactor,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [CircularProgressIndicator()],
                      ),
                    )
                  ]);
            } else if (snapshot.hasData) {
              final inpatient = snapshot.data as Inpatient;
              return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width:
                          size.width * ContainerSize.smallContainerWidthFactor,
                      height: size.height,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                      ),
                      child: InpatientListScreen(
                        inpatientRepository: widget.inpatientRepository,
                      ),
                    ),
                    Container(
                      width:
                          size.width * ContainerSize.mediumContainerWidthFactor,
                      height: size.height,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                      ),
                      child: RoundFormScreen(
                        inpatient: inpatient,
                      ),
                    ),
                    SizedBox(
                      width:
                          size.width * ContainerSize.smallContainerWidthFactor,
                      height: size.height,
                      child: const TabletRHSTabContainer(),
                    )
                  ]);
            }
            return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: size.width * ContainerSize.smallContainerWidthFactor,
                height: size.height,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: const Color(0xFF000000).withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),
                child: InpatientListScreen(
                  inpatientRepository: widget.inpatientRepository,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://drive.google.com/uc?export=download&id=1kjZxZkd4TXjC-95KUNItuG_cSe5Vpnkb',
                      width: 140,
                      height: 200,
                    ),
                    const Text(
                        textAlign: TextAlign.center,
                        'Select an inpatient to get started'),
                  ],
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}

class TabletRHSTabContainer extends StatefulWidget {
  const TabletRHSTabContainer({super.key});

  @override
  State<TabletRHSTabContainer> createState() => _TabletRHSTabContainerState();
}

class _TabletRHSTabContainerState extends State<TabletRHSTabContainer> {
  late final CupertinoTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CupertinoTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: _controller,
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const NurseTreatmentSheetScreen();
          case 1:
            return ObservationChartScreen();
          case 2:
            return const SpecialScreen();
          default:
            return const NurseTreatmentSheetScreen();
        }
      },
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            // icon: SvgPicture.asset('assets/images/pill.svg'),
            icon: Icon(Icons.local_hospital),
            label: 'Medical',
          ),
          BottomNavigationBarItem(
            // icon: SvgPicture.asset('assets/images/heartbeat.svg'),
            icon: Icon(Icons.favorite),
            label: 'Vitals',
          ),
          BottomNavigationBarItem(
            // icon: SvgPicture.asset('assets/images/bed.svg'),
            icon: Icon(Icons.bed),
            label: 'Special',
          ),
        ],
      ),
    );
  }
}
