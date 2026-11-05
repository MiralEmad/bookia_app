import 'package:flutter/foundation.dart';
import 'auth_repository.dart';
import 'hive_service.dart';

/// Saved books, stored in Hive per logged-in user.
class WishlistRepository extends ChangeNotifier {
  WishlistRepository._();
  static final WishlistRepository instance = WishlistRepository._();

  String get _key => AuthRepository.instance.currentUser?.email ?? 'guest';

  List<String> get ids {
    final raw = HiveService.wishlist.get(_key, defaultValue: <String>[]);
    return List<String>.from(raw as List);
  }

  bool contains(String id) => ids.contains(id);

  /// Adds or removes the book. Returns true if it is now in the wishlist.
  Future<bool> toggle(String id) async {
    final list = ids;
    final nowSaved = !list.contains(id);
    nowSaved ? list.add(id) : list.remove(id);
    await HiveService.wishlist.put(_key, list);
    notifyListeners();
    return nowSaved;
  }

  Future<void> remove(String id) async {
    final list = ids..remove(id);
    await HiveService.wishlist.put(_key, list);
    notifyListeners();
  }
}