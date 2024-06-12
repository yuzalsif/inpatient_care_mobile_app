import 'package:flutter/material.dart';

class GenericErrorSnackBar extends SnackBar {
  const GenericErrorSnackBar({super.key})
      : super(
    content: const _GenericErrorSnackBarMessage(),
  );
}

class _GenericErrorSnackBarMessage extends StatelessWidget {
  const _GenericErrorSnackBarMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
     'There have been an error, please check your internet connection',
    );
  }
}
