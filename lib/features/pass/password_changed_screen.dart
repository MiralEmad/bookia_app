import 'package:flutter/material.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/responsive/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/primary_button.dart';
import '../auth/login_screen.dart';

/// Password Changed: success message, then back to Login.
class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  static const _success = Color(0xFF2ECC71);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ResponsiveBody(
        child: Column(
          children: [
            const Spacer(flex: 3),
            Container(
              width: context.sp(84),
              height: context.sp(84),
              decoration: const BoxDecoration(
                color: _success,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_rounded,
                  color: Colors.white, size: context.sp(52)),
            ),
            SizedBox(height: context.sp(28)),
            Text(
              context.tr('passwordChanged'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.sp(24),
                fontWeight: FontWeight.w700,
                color: AppColors.dark,
              ),
            ),
            SizedBox(height: context.sp(10)),
            Text(
              context.tr('passwordChangedSubtitle'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.sp(13),
                height: 1.5,
                color: AppColors.gray,
              ),
            ),
            SizedBox(height: context.sp(36)),
            PrimaryButton(
              label: context.tr('backToLogin'),
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
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