import 'package:flutter/material.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/l10n/locale_controller.dart';
import '../../core/responsive/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/profile_tile.dart';
import '../../data/auth_repository.dart';
import '../auth/forgot_password_screen.dart';
import '../welcome/welcome_screen.dart';

/// Profile: avatar, name, email (from Hive) and the settings list.
/// Language switch on the start side, logout on the end side of the title.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _soon(BuildContext context) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(context.tr('comingSoon'))));

  Future<void> _logout(BuildContext context) async {
    await AuthRepository.instance.logout();
    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthRepository.instance.currentUser;
    final name = user?.username ?? '';
    final pad = context.sp(16);

    final items = <(String, VoidCallback)>[
      (context.tr('myOrders'), () => _soon(context)),
      (context.tr('editProfile'), () => _soon(context)),
      (
        context.tr('resetPassword'),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()))
      ),
      (context.tr('faq'), () => _soon(context)),
      (context.tr('contactUs'), () => _soon(context)),
      (context.tr('privacyTerms'), () => _soon(context)),
    ];

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: EdgeInsets.all(pad),
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.language),
                tooltip: context.tr('language'),
                onPressed: LocaleController.instance.toggle,
              ),
              Expanded(
                child: Text(
                  context.tr('profile'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: context.sp(22), fontWeight: FontWeight.w700),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.logout_rounded),
                tooltip: context.tr('logout'),
                onPressed: () => _logout(context),
              ),
            ],
          ),
          SizedBox(height: context.sp(20)),
          Row(
            children: [
              CircleAvatar(
                radius: context.sp(40),
                backgroundColor: const Color(0xFFE5E7EB),
                child: Text(
                  name.isEmpty ? '' : name.characters.first.toUpperCase(),
                  style: TextStyle(
                      fontSize: context.sp(28),
                      fontWeight: FontWeight.w700,
                      color: AppColors.gray),
                ),
              ),
              SizedBox(width: context.sp(16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: context.sp(20),
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: context.sp(4)),
                    Text(user?.email ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: context.sp(13), color: AppColors.gray)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: context.sp(24)),
          for (final item in items) ...[
            ProfileTile(title: item.$1, onTap: item.$2),
            SizedBox(height: context.sp(12)),
          ],
        ],
      ),
    );
  }
}