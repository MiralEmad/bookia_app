import 'package:flutter/material.dart';
import '../responsive/responsive.dart';

/// Reusable TextFormField.
///
/// * Normal single-line field by default.
/// * Password fields get a show/hide eye icon.
/// * Description-style fields: use `AppTextField.multiline(...)`. It is a
///   normal TextFormField with a FIXED starting height (1 line) that grows
///   automatically as the user types more lines, up to [maxLines], and then
///   scrolls inside itself, so the layout never breaks.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.validator,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.onFieldSubmitted,
  });

  /// Expandable description / bio / notes field.
  const AppTextField.multiline({
    super.key,
    required this.controller,
    required this.hint,
    this.validator,
    this.minLines = 1,
    this.maxLines = 6,
    this.maxLength = 300,
    this.onFieldSubmitted,
  })  : isPassword = false,
        keyboardType = TextInputType.multiline,
        textInputAction = TextInputAction.newline;

  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword && _obscure,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      minLines: widget.isPassword ? 1 : widget.minLines,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      maxLength: widget.maxLength,
      onFieldSubmitted: widget.onFieldSubmitted,
      style: TextStyle(fontSize: context.sp(14)),
      decoration: InputDecoration(
        hintText: widget.hint,
        counterText: '',
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 20,
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
              )
            : null,
      ),
    );
  }
}
