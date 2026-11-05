import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Small square icon button used on book cards (add to cart / remove).
class SmallActionButton extends StatelessWidget {
  const SmallActionButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.filled = true,
    this.tooltip,
  });
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final button = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: filled ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon,
            size: 18, color: filled ? Colors.white : AppColors.dark),
      ),
    );
    return tooltip == null ? button : Tooltip(message: tooltip!, child: button);
  }
}