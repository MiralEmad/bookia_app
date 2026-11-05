import 'package:flutter/material.dart';
import '../responsive/responsive.dart';
import '../theme/app_colors.dart';

class EmptyState extends StatelessWidget {
  const EmptyState(
      {super.key, required this.icon, required this.title, this.subtitle});
  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: context.sp(56), color: AppColors.primary),
            SizedBox(height: context.sp(12)),
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: context.sp(16), fontWeight: FontWeight.w700)),
            if (subtitle != null) ...[
              SizedBox(height: context.sp(6)),
              Text(subtitle!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: context.sp(12), color: AppColors.gray)),
            ],
          ],
        ),
      ),
    );
  }
}