import 'package:flutter/material.dart';
import '../responsive/responsive.dart';
import '../theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.outlined = false,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool outlined;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
    final child = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: outlined ? AppColors.primary : Colors.white,
            ),
          )
        : Text(
            label,
            style: TextStyle(
              fontSize: context.sp(14),
              fontWeight: FontWeight.w700,
              color: outlined ? AppColors.dark : Colors.white,
            ),
          );

    return SizedBox(
      width: double.infinity,
      height: context.sp(52),
      child: outlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: AppColors.dark),
                shape: shape,
              ),
              child: child,
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                shape: shape,
              ),
              child: child,
            ),
    );
  }
}
