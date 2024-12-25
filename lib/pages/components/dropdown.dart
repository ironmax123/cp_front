import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String labelText;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    super.key,
    required this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(labelText: labelText),
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '選択してください';
        }
        return null;
      },
    );
  }
}
