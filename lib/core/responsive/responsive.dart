import 'package:flutter/material.dart';

/// Max content width so phones, tablets and web all look good.
const double kMaxContentWidth = 480;

extension ResponsiveX on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  bool get isTablet => screenWidth >= 600;

  /// Scales a size relative to a 390px-wide design (the Figma frame).
  double sp(double size) {
    final w = screenWidth.clamp(0, kMaxContentWidth).toDouble();
    return size * (w / 390).clamp(0.85, 1.25);
  }
}

/// Centers content, limits its width, and lets it scroll on small screens
/// while still allowing a `Spacer`/`Expanded` to push content to the bottom.
class ResponsiveBody extends StatelessWidget {
  const ResponsiveBody({super.key, required this.child, this.padding});
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, c) => SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: c.maxHeight),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: padding ??
                        EdgeInsets.symmetric(horizontal: context.sp(22)),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
