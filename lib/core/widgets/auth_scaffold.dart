import 'package:flutter/material.dart';
import '../responsive/responsive.dart';
import '../theme/app_colors.dart';
import 'language_button.dart';

/// Shared layout for Login / Register: back button, language switch,
/// responsive scrolling body.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.title, required this.child});
  final String title;
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
            SizedBox(height: context.sp(28)),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
