import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// White rounded square icon button (back / bookmark in the design).
class SquareIconButton extends StatelessWidget {
  const SquareIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.color = AppColors.dark,
  });
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: IconButton(
        icon: Icon(icon, size: 18, color: color),
        onPressed: onTap,
      ),
    );
  }
}