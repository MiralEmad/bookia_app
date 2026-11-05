import 'package:flutter/material.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/responsive/responsive.dart';
import '../../core/widgets/cart_item_tile.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/primary_button.dart';
import '../../data/books_data.dart';
import '../../data/cart_repository.dart';

/// My Cart: items with quantity stepper, total and Checkout (data in Hive).
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pad = context.sp(16);
    final currency = context.tr('currency');

    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: pad),
            child: Text(
              context.tr('myCart'),
              style: TextStyle(
                  fontSize: context.sp(22), fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: ListenableBuilder(
              listenable: CartRepository.instance,
              builder: (context, _) {
                final entries = CartRepository.instance.items.entries
                    .where((e) => bookById(e.key) != null)
                    .toList();
                if (entries.isEmpty) {
                  return EmptyState(
                    icon: Icons.shopping_cart_outlined,
                    title: context.tr('cartEmpty'),
                  );
                }
                final total = entries.fold<int>(
                    0, (sum, e) => sum + bookById(e.key)!.price * e.value);

                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: pad),
                        itemCount: entries.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(height: context.sp(12)),
                        itemBuilder: (context, i) {
                          final book = bookById(entries[i].key)!;
                          return CartItemTile(
                            book: book,
                            quantity: entries[i].value,
                            onIncrease: () =>
                                CartRepository.instance.add(book.id),
                            onDecrease: () =>
                                CartRepository.instance.decrease(book.id),
                            onRemove: () =>
                                CartRepository.instance.removeAll(book.id),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(pad),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${context.tr('total')}:',
                                  style: TextStyle(
                                      fontSize: context.sp(18),
                                      fontWeight: FontWeight.w600)),
                              Text('$currency$total',
                                  style: TextStyle(
                                      fontSize: context.sp(20),
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                          SizedBox(height: context.sp(16)),
                          PrimaryButton(
                            label: context.tr('checkout'),
                            onPressed: () => ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(SnackBar(
                                  content: Text(context.tr('comingSoon')))),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}