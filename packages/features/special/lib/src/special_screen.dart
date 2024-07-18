import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class SpecialScreen extends StatefulWidget {
  const SpecialScreen({super.key});

  @override
  State<SpecialScreen> createState() => _SpecialScreenState();
}

class _SpecialScreenState extends State<SpecialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Spacing.small),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Special',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1E1E1E),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: Spacing.xLarge,
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text(
                            'Discharged',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          value: false,
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        width: Spacing.xSmall,
                      ),
                      Flexible(
                        flex: 1,
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text(
                            'Death',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          value: false,
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        width: Spacing.xSmall,
                      ),
                      Flexible(
                        flex: 1,
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text(
                            'Referral',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          value: false,
                          onChanged: (value) {},
                        ),
                      ),
                    ]),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text(
                            'Admitted',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          value: false,
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(
                        width: Spacing.xSmall,
                      ),
                      Flexible(
                        flex: 2,
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: const Text(
                            'Escaped',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          value: false,
                          onChanged: (value) {},
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        ));
  }
}
