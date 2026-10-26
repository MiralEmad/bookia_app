import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../responsive/responsive.dart';
import '../theme/app_colors.dart';

/// Reusable OTP input: [length] boxes, auto-focus next on typing, backspace
/// goes back, pasting a full code fills all boxes.
/// Always laid out left-to-right (codes are read LTR, even in Arabic).
class OtpField extends StatefulWidget {
  const OtpField({super.key, this.length = 5, required this.onChanged});
  final int length;
  final ValueChanged<String> onChanged;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  late final List<TextEditingController> _controllers =
      List.generate(widget.length, (_) => TextEditingController());
  late final List<FocusNode> _nodes =
      List.generate(widget.length, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  void _notify() {
    widget.onChanged(_controllers.map((c) => c.text).join());
    setState(() {});
  }

  void _onChanged(int i, String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) {
      _controllers[i].clear();
      return _notify();
    }
    // Typing one digit or pasting many: spread them across the boxes.
    var index = i;
    for (final ch in digits.split('')) {
      if (index >= widget.length) break;
      _controllers[index].text = ch;
      index++;
    }
    final next = index.clamp(0, widget.length - 1);
    _nodes[next].requestFocus();
    _notify();
  }

  KeyEventResult _onKey(int i, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[i].text.isEmpty &&
        i > 0) {
      _controllers[i - 1].clear();
      _nodes[i - 1].requestFocus();
      _notify();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        children: List.generate(widget.length, (i) {
          final filled = _controllers[i].text.isNotEmpty;
          final color = filled ? AppColors.primary : AppColors.border;
          final border = OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: color, width: filled ? 1.5 : 1),
          );
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: SizedBox(
                height: context.sp(58),
                child: Focus(
                  onKeyEvent: (_, e) => _onKey(i, e),
                  child: TextField(
                    controller: _controllers[i],
                    focusNode: _nodes[i],
                    autofocus: i == 0,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: TextStyle(
                        fontSize: context.sp(20), fontWeight: FontWeight.w700),
                    onChanged: (v) => _onChanged(i, v),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: border,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                            color: AppColors.primary, width: 1.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}