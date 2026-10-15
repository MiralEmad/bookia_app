import 'package:flutter/material.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/responsive/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_logo.dart';
import '../../core/widgets/language_button.dart';
import '../../core/widgets/primary_button.dart';
import '../auth/login_screen.dart';
import '../auth/register_screen.dart';

/// Screen 2: background photo, logo, Login / Register buttons.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/bokia.jpg',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFB9C3D6), Color(0xFF6F86A6)],
                ),
              ),
            ),
          ),
          ResponsiveBody(
            child: Column(
              children: [
                const Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: LanguageButton(color: AppColors.dark),
                ),
                const Spacer(flex: 3),
                const AppLogo(size: 40),
                SizedBox(height: context.sp(30)),
                Text(
                  context.tr('tagline'),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: context.sp(14),
                    color: AppColors.dark,
                  ),
                ),
                const Spacer(flex: 5),
                SizedBox(height: context.sp(400)),
                PrimaryButton(
                  label: context.tr('login'),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const LoginScreen())),
                ),
                SizedBox(height: context.sp(14)),
                PrimaryButton(
                  label: context.tr('register'),
                  outlined: true,
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen())),
                ),
                SizedBox(height: context.sp(32)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
