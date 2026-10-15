import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../l10n/locale_controller.dart';
import '../theme/app_colors.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key, this.color = AppColors.dark});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: LocaleController.instance.toggle,
      icon: Icon(Icons.language, color: color, size: 20),
      label: Text(context.tr('language'),
          style: TextStyle(color: color, fontWeight: FontWeight.w600)),
    );
  }
}
