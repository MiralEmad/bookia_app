import 'package:flutter/widgets.dart';
import '../../data/hive_service.dart';

/// Holds the current locale and persists the choice in Hive.
class LocaleController extends ChangeNotifier {
  LocaleController._() {
    final saved =
        HiveService.settings.get(HiveService.langKey, defaultValue: 'en');
    _locale = Locale(saved as String);
  }
  static final LocaleController instance = LocaleController._();

  late Locale _locale;
  Locale get locale => _locale;

  Future<void> toggle() async {
    _locale = _locale.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    await HiveService.settings.put(HiveService.langKey, _locale.languageCode);
    notifyListeners();
  }
}
