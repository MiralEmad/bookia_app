import 'package:flutter/material.dart';
import '../responsive/responsive.dart';
import '../theme/app_colors.dart';

/// White rounded row with a title and a chevron (My Orders, FAQ, ...).
class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, required this.title, required this.onTap});
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.sp(16), vertical: context.sp(18)),
          child: Row(
            children: [
              Expanded(
                child: Text(title,
                    style: TextStyle(
                        fontSize: context.sp(14),
                        fontWeight: FontWeight.w700)),
              ),
              // Chevron mirrors automatically in RTL.
              const Icon(Icons.arrow_forward_ios_rounded,
                  size: 16, color: AppColors.dark),
            ],
          ),
        ),
      ),
    );
  }
}