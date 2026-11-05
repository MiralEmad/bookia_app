import 'package:flutter/foundation.dart';
import 'auth_repository.dart';
import 'hive_service.dart';

/// Cart items (book id -> quantity), stored in Hive per logged-in user.
class CartRepository extends ChangeNotifier {
  CartRepository._();
  static final CartRepository instance = CartRepository._();

  String get _key => AuthRepository.instance.currentUser?.email ?? 'guest';

  Map<String, int> get items {
    final raw = HiveService.cart.get(_key, defaultValue: <String, int>{});
    return (raw as Map).map((k, v) => MapEntry(k as String, v as int));
  }

  int get count => items.values.fold(0, (a, b) => a + b);

  Future<void> add(String id) async {
    final map = items;
    map[id] = (map[id] ?? 0) + 1;
    await HiveService.cart.put(_key, map);
    notifyListeners();
  }

  /// Lowers the quantity by one (never below 1; use removeAll to delete).
  Future<void> decrease(String id) async {
    final map = items;
    final qty = map[id] ?? 0;
    if (qty <= 1) return;
    map[id] = qty - 1;
    await HiveService.cart.put(_key, map);
    notifyListeners();
  }

  Future<void> removeAll(String id) async {
    final map = items..remove(id);
    await HiveService.cart.put(_key, map);
    notifyListeners();
  }
}