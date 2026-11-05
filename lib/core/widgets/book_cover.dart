import 'package:flutter/material.dart';
import '../../data/book_model.dart';

/// Book cover image. Falls back to a colored cover with the title if the
/// asset is missing, so the app always looks complete.
class BookCover extends StatelessWidget {
  const BookCover({super.key, required this.book, this.radius = 8});
  final Book book;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    final fallback = Container(
      color: Color(book.color),
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Text(
          book.title(lang),
          textAlign: TextAlign.center,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: book.image == null
          ? fallback
          : Image.asset(
              book.image!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (_, __, ___) => fallback,
            ),
    );
  }
}