import 'package:flutter/material.dart';
import '../responsive/responsive.dart';
import '../theme/app_colors.dart';

class AuthBottomLink extends StatelessWidget {
  const AuthBottomLink({
    super.key,
    required this.text,
    required this.action,
    required this.onTap,
  });
  final String text;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.sp(20)),
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: Text.rich(
            TextSpan(children: [
              TextSpan(text: text, style: const TextStyle(color: AppColors.dark)),
              TextSpan(
                  text: action,
                  style: const TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.w700)),
            ]),
            style: TextStyle(fontSize: context.sp(13)),
          ),
        ),
      ),
    );
  }
}
