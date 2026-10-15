import 'package:flutter/widgets.dart';
import '../l10n/app_localizations.dart';

class Validators {
  Validators._();

  static String? required(BuildContext c, String? v) =>
      (v == null || v.trim().isEmpty) ? c.tr('required') : null;

  static String? email(BuildContext c, String? v) {
    if (v == null || v.trim().isEmpty) return c.tr('required');
    final ok = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$').hasMatch(v.trim());
    return ok ? null : c.tr('invalidEmail');
  }

  static String? password(BuildContext c, String? v) {
    if (v == null || v.isEmpty) return c.tr('required');
    return v.length < 6 ? c.tr('shortPassword') : null;
  }

  static String? confirm(BuildContext c, String? v, String original) {
    if (v == null || v.isEmpty) return c.tr('required');
    return v != original ? c.tr('passwordMismatch') : null;
  }
}
