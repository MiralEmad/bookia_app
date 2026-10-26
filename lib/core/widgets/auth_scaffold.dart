import 'package:flutter/material.dart';
import '../responsive/responsive.dart';
import '../theme/app_colors.dart';
import 'language_button.dart';

/// Shared layout for the auth screens: back button, language switch,
/// title, optional subtitle and a responsive scrolling body.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
  });
  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.sp(12)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                ),
                const LanguageButton(),
              ],
            ),
            SizedBox(height: context.sp(28)),
            Text(
              title,
              style: TextStyle(
                fontSize: context.sp(24),
                fontWeight: FontWeight.w700,
                height: 1.3,
                color: AppColors.dark,
              ),
            ),
            if (subtitle != null) ...[
              SizedBox(height: context.sp(10)),
              Text(
                subtitle!,
                style: TextStyle(
                  fontSize: context.sp(13),
                  height: 1.5,
                  color: AppColors.gray,
                ),
              ),
            ],
            SizedBox(height: context.sp(28)),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}