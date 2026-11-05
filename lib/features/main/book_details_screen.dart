import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/responsive/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/book_cover.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/square_icon_button.dart';
import '../../data/book_model.dart';
import '../../data/cart_repository.dart';
import '../../data/wishlist_repository.dart';

/// Book Details: cover, title, description, bookmark and Add To Cart.
class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.book});
  final Book book;

  void _snack(BuildContext context, String msg) =>
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
            SnackBar(content: Text(msg), duration: const Duration(seconds: 2)));

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    final coverWidth = math.min(context.screenWidth * 0.5, 220.0);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(context.sp(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SquareIconButton(
                        icon: Icons.arrow_back_ios_new,
                        onTap: () => Navigator.maybePop(context),
                      ),
                      ListenableBuilder(
                        listenable: WishlistRepository.instance,
                        builder: (context, _) {
                          final saved =
                              WishlistRepository.instance.contains(book.id);
                          return SquareIconButton(
                            icon: saved
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            color: saved ? AppColors.primary : AppColors.dark,
                            onTap: () async {
                              final nowSaved = await WishlistRepository
                                  .instance
                                  .toggle(book.id);
                              if (!context.mounted) return;
                              _snack(
                                  context,
                                  context.tr(nowSaved
                                      ? 'addedToWishlist'
                                      : 'removedFromWishlist'));
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: context.sp(24)),
                    child: Column(
                      children: [
                        SizedBox(height: context.sp(8)),
                        SizedBox(
                          width: coverWidth,
                          child: AspectRatio(
                            aspectRatio: 0.7,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(45),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: BookCover(book: book),
                            ),
                          ),
                        ),
                        SizedBox(height: context.sp(24)),
                        Text(
                          book.title(lang),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: context.sp(26),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: context.sp(4)),
                        Text(
                          book.author(lang),
                          style: TextStyle(
                              fontSize: context.sp(13), color: AppColors.gray),
                        ),
                        SizedBox(height: context.sp(4)),
                        Text(
                          context.tr('formatBroche'),
                          style: TextStyle(
                              fontSize: context.sp(13),
                              color: AppColors.primary),
                        ),
                        SizedBox(height: context.sp(18)),
                        Text(
                          book.description(lang),
                          style: TextStyle(
                              fontSize: context.sp(13), height: 1.7),
                        ),
                        SizedBox(height: context.sp(16)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(context.sp(16)),
                  child: Row(
                    children: [
                      Text(
                        '${context.tr('currency')}${book.price}',
                        style: TextStyle(
                            fontSize: context.sp(24),
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(width: context.sp(20)),
                      Expanded(
                        child: PrimaryButton(
                          label: context.tr('addToCart'),
                          backgroundColor: AppColors.dark,
                          onPressed: () async {
                            await CartRepository.instance.add(book.id);
                            if (!context.mounted) return;
                            _snack(context, context.tr('addedToCart'));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}