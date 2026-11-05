import 'package:flutter/material.dart';
import '../../data/book_model.dart';
import '../l10n/app_localizations.dart';
import '../responsive/responsive.dart';
import '../theme/app_colors.dart';
import 'book_cover.dart';

/// Book card used by Home and Wishlist. The action at the bottom-end is
/// passed in as [trailing] (add-to-cart on Home, remove on Wishlist).
class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
    required this.trailing,
    required this.onTap,
  });
  final Book book;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
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
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: BookCover(book: book)),
              SizedBox(height: context.sp(8)),
              Text(
                book.title(lang),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: context.sp(13), fontWeight: FontWeight.w700),
              ),
              SizedBox(height: context.sp(6)),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${context.tr('currency')}${book.price}',
                      style: TextStyle(fontSize: context.sp(12)),
                    ),
                  ),
                  trailing,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Grid delegate shared by Home and Wishlist (2 columns on phones, more on
/// tablets).
const bookGridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
  maxCrossAxisExtent: 200,
  crossAxisSpacing: 12,
  mainAxisSpacing: 12,
  childAspectRatio: 0.62,
);