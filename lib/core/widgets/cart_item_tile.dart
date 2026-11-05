import 'package:flutter/material.dart';
import '../../data/book_model.dart';
import '../l10n/app_localizations.dart';
import '../responsive/responsive.dart';
import '../theme/app_colors.dart';
import 'book_cover.dart';

/// One row of the cart: cover, title, unit price, quantity stepper (+ 01 -),
/// line total and a remove (x) button.
class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.book,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  final Book book;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    final currency = context.tr('currency');

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: SizedBox(
        height: context.sp(104),
        child: Row(
          children: [
            SizedBox(
              width: context.sp(80),
              height: double.infinity,
              child: BookCover(book: book, radius: 6),
            ),
            SizedBox(width: context.sp(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          book.title(lang),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: context.sp(15),
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      InkResponse(
                        onTap: onRemove,
                        radius: 18,
                        child: Tooltip(
                          message: context.tr('remove'),
                          child: const Icon(Icons.cancel_outlined, size: 22),
                        ),
                      ),
                    ],
                  ),
                  Text('$currency${book.price}',
                      style: TextStyle(fontSize: context.sp(13))),
                  Row(
                    children: [
                      _StepButton(icon: Icons.add_rounded, onTap: onIncrease),
                      SizedBox(
                        width: context.sp(36),
                        child: Center(
                          child: Text(
                            quantity.toString().padLeft(2, '0'),
                            style: TextStyle(
                                fontSize: context.sp(15),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      _StepButton(
                          icon: Icons.remove_rounded, onTap: onDecrease),
                      const Spacer(),
                      Text('$currency${book.price * quantity}',
                          style: TextStyle(fontSize: context.sp(13))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 18, color: AppColors.dark),
      ),
    );
  }
}