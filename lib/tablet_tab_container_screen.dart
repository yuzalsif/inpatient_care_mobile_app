import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:routemaster/routemaster.dart';

class TabletTabContainerScreen extends StatefulWidget {
  const TabletTabContainerScreen({super.key});

  @override
  State<TabletTabContainerScreen> createState() => _TabletTabContainerScreenState();
}

class _TabletTabContainerScreenState extends State<TabletTabContainerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: const [

          ]
        )
      )
    );
  }
}


class TabletRHSTabContainer extends StatelessWidget {
  const TabletRHSTabContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final tabState = CupertinoTabPage.of(context);
    return CupertinoTabScaffold(
      controller: tabState.controller,
        tabBuilder: tabState.tabBuilder,
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/pill.svg'),
            label: 'Medical',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/heartbeat.svg'),
            label: 'Vitals',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/bed.svg'),
            label: 'Special',
          ),
        ],
      ),
    );
  }
}

