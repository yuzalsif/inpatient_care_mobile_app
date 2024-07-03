import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  final List<DropdownMenuEntry> dropDownMenuEntries;
  final Function(dynamic) onSelected;
  final String helperText;

  const CustomDropDownMenu({
    super.key,
    required this.dropDownMenuEntries,
    required this.onSelected,
    required this.helperText,
  });

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: double.infinity,
      label: Text(widget.helperText),
      dropdownMenuEntries: widget.dropDownMenuEntries,
      onSelected: widget.onSelected,
    );
  }
}
