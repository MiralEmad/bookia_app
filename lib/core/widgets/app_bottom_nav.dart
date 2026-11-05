import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../responsive/responsive.dart';
import '../theme/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.cartCount = 0,
    this.maxWidth = 720,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final int cartCount;
  final double maxWidth;

  static const _icons = [
    [Icons.home_outlined, Icons.home_rounded],
    [Icons.bookmark_border_rounded, Icons.bookmark_rounded],
    [Icons.shopping_cart_outlined, Icons.shopping_cart_rounded],
    [Icons.person_outline_rounded, Icons.person_rounded],
  ];

  static const _labels = [
    'navHome',
    'navWishlist',
    'navCart',
    'navProfile',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
      ),

      child: SafeArea(
        top: false,

        child: SizedBox(
          height: context.sp(60),

          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth,
              ),

              child: Row(
                children: List.generate(4, (i) {
                  final selected = i == currentIndex;

                  Widget icon = Icon(
                    _icons[i][selected ? 1 : 0],
                    size: context.sp(26),
                    color: selected
                        ? AppColors.primary
                        : AppColors.dark,
                  );

                  if (i == 2) {
                    icon = Badge(
                      label: Text('$cartCount'),
                      isLabelVisible: cartCount > 0,
                      backgroundColor: AppColors.primary,
                      child: icon,
                    );
                  }

                  return Expanded(
                    child: Semantics(
                      button: true,
                      selected: selected,
                      label: context.tr(_labels[i]),

                      child: InkResponse(
                        onTap: () => onTap(i),
                        child: Center(
                          child: icon,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}