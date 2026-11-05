import 'package:flutter/material.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/responsive/responsive.dart';
import '../../core/widgets/book_card.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/small_action_button.dart';
import '../../data/book_model.dart';
import '../../data/books_data.dart';
import '../../data/wishlist_repository.dart';
import '../main/book_details_screen.dart';

/// Wishlist: books saved in Hive, with a remove button on each card.
class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pad = context.sp(16);
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: pad),
            child: Text(
              context.tr('wishlist'),
              style: TextStyle(
                  fontSize: context.sp(22), fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: ListenableBuilder(
              listenable: WishlistRepository.instance,
              builder: (context, _) {
                final books = WishlistRepository.instance.ids
                    .map(bookById)
                    .whereType<Book>()
                    .toList();
                if (books.isEmpty) {
                  return EmptyState(
                    icon: Icons.bookmark_border_rounded,
                    title: context.tr('wishlistEmpty'),
                    subtitle: context.tr('wishlistEmptyHint'),
                  );
                }
                return GridView.builder(
                  padding: EdgeInsets.fromLTRB(pad, 0, pad, pad),
                  gridDelegate: bookGridDelegate,
                  itemCount: books.length,
                  itemBuilder: (context, i) {
                    final book = books[i];
                    return BookCard(
                      book: book,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BookDetailsScreen(book: book)),
                      ),
                      trailing: SmallActionButton(
                        icon: Icons.cancel_outlined,
                        filled: false,
                        tooltip: context.tr('remove'),
                        onTap: () =>
                            WishlistRepository.instance.remove(book.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}