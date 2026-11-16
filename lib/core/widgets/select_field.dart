import 'package:flutter/material.dart';
import '../responsive/responsive.dart';

/// Looks like a text field, but tapping it opens a picker (bottom sheet).
/// Used for the Governorate field.
class SelectField extends StatelessWidget {
  const SelectField({
    super.key,
    required this.hint,
    required this.onTap,
    this.value,
    this.errorText,
  });

  final String hint;
  final String? value;
  final String? errorText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: InputDecorator(
        isEmpty: value == null,
        decoration: InputDecoration(
          hintText: hint,
          errorText: errorText,
          suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        ),
        child: value == null
            ? null
            : Text(value!, style: TextStyle(fontSize: context.sp(14))),
      ),
    );
  }
}