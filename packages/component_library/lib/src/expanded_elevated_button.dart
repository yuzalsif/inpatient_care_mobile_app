import 'package:flutter/material.dart';

class ExpandedElevatedButton extends StatelessWidget {
  static const double _elevatedButtonHeight = 48;
  static const double _elevatedButtonScaleFactor = 0.5;

  const ExpandedElevatedButton({
    required this.label,
    this.onTap,
    this.icon,
    super.key,
  });

  ExpandedElevatedButton.inProgress({
    required String label,
    Key? key,
  }) : this(
    label: label,
    icon: Transform.scale(
      scale: 0.5,
      child: const CircularProgressIndicator(),
    ),
    key: key,
  );

  final VoidCallback? onTap;
  final String label;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final icon = this.icon;
    return SizedBox(
      height: _elevatedButtonHeight,
      width: double.infinity,
      child: icon != null
          ? ElevatedButton.icon(
        onPressed: onTap,
        label: Text(
          style: const TextStyle(
            fontSize: 18 //TODO: Create a const for this zz
          ),
          label,
        ),
        icon: icon,
      )
          : ElevatedButton(
        onPressed: onTap,
        child: Text(
          label,
        ),
      ),
    );
  }
}
