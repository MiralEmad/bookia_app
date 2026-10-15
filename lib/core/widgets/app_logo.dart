import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../responsive/responsive.dart';
import '../theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 36, this.textColor = AppColors.dark});
  final double size;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final s = context.sp(size);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.menu_book_rounded, color: AppColors.primary, size: s * 1.1),
        SizedBox(width: s * 0.2),
        Text(
          context.tr('appName'),
          style: TextStyle(
            fontSize: s,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
