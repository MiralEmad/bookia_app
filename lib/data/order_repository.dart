import 'package:flutter/foundation.dart';
import 'auth_repository.dart';
import 'books_data.dart';
import 'cart_repository.dart';
import 'hive_service.dart';
import 'order_model.dart';

/// Orders, stored in Hive per logged-in user (newest first).
class OrdersRepository extends ChangeNotifier {
  OrdersRepository._();
  static final OrdersRepository instance = OrdersRepository._();

  String get _key => AuthRepository.instance.currentUser?.email ?? 'guest';

  List<OrderModel> get orders {
    final raw = HiveService.orders.get(_key, defaultValue: <dynamic>[]);
    return (raw as List).map((e) => OrderModel.fromMap(e as Map)).toList();
  }

  /// Builds an order from the current cart, saves it in Hive and empties the
  /// cart. Returns null when the cart is empty.
  Future<OrderModel?> placeOrder({
    required String fullName,
    required String address,
    required String phone,
    required String governorateId,
  }) async {
    final entries = CartRepository.instance.items.entries
        .where((e) => bookById(e.key) != null)
        .toList();
    if (entries.isEmpty) return null;

    final items = entries.map((e) {
      final book = bookById(e.key)!;
      return OrderItem(bookId: book.id, quantity: e.value, price: book.price);
    }).toList();
    final total = items.fold<int>(0, (s, i) => s + i.price * i.quantity);

    final order = OrderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      fullName: fullName.trim(),
      address: address.trim(),
      phone: phone.trim(),
      governorateId: governorateId,
      items: items,
      total: total,
      createdAt: DateTime.now(),
    );

    final all = [order, ...orders];
    await HiveService.orders.put(_key, all.map((o) => o.toMap()).toList());
    await CartRepository.instance.clear();
    notifyListeners();
    return order;
  }
}