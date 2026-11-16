import 'package:flutter/material.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/responsive/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/primary_button.dart';
import '../main/main_shell_screen.dart';

/// Congrats: shown after the order is saved. Back To Home opens the shell.
class CongratsScreen extends StatelessWidget {
  const CongratsScreen({super.key});

  static const _success = Color(0xFF1DBF73);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBody(
        child: Column(
          children: [
            const Spacer(flex: 3),
            Icon(Icons.verified_rounded,
                size: context.sp(120), color: _success),
            SizedBox(height: context.sp(32)),
            Text(
              context.tr('orderSuccess'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.sp(32),
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
                color: AppColors.dark,
              ),
            ),
            SizedBox(height: context.sp(14)),
            Text(
              context.tr('orderSuccessMessage'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.sp(14),
                height: 1.6,
                color: AppColors.gray,
              ),
            ),
            SizedBox(height: context.sp(40)),
            PrimaryButton(
              label: context.tr('backToHome'),
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const MainShell()),
                (_) => false,
              ),
            ),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }
}