import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'hive_service.dart';
import 'user_model.dart';

enum AuthResult { success, emailExists, wrongCredentials }

/// Register / login / session, all stored locally in Hive.
class AuthRepository {
  AuthRepository._();
  static final AuthRepository instance = AuthRepository._();

  String _hash(String v) => sha256.convert(utf8.encode(v)).toString();
  String _key(String email) => email.trim().toLowerCase();

  Future<AuthResult> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final key = _key(email);
    if (HiveService.users.containsKey(key)) return AuthResult.emailExists;
    await HiveService.users.put(
      key,
      UserModel(
        username: username.trim(),
        email: key,
        passwordHash: _hash(password),
        createdAt: DateTime.now(),
      ),
    );
    return AuthResult.success;
  }

  Future<AuthResult> login(String email, String password) async {
    final user = HiveService.users.get(_key(email));
    if (user == null || user.passwordHash != _hash(password)) {
      return AuthResult.wrongCredentials;
    }
    await HiveService.settings.put(HiveService.sessionKey, user.email);
    return AuthResult.success;
  }

  UserModel? get currentUser {
    final email = HiveService.settings.get(HiveService.sessionKey) as String?;
    return email == null ? null : HiveService.users.get(email);
  }

  Future<void> logout() => HiveService.settings.delete(HiveService.sessionKey);

  // ---------------- Password recovery (stored in Hive) ----------------
  static const _resetEmailKey = 'reset_email';
  static const _resetCodeKey = 'reset_code';
  static const _resetVerifiedKey = 'reset_verified';

  /// Creates a 5-digit code for an existing account and saves it in Hive.
  /// Returns null when the email is not registered.
  /// (There is no email server in this demo, so the code is returned to
  /// the UI. Replace this with a real email/SMS call in production.)
  Future<String?> requestResetCode(String email) async {
    final key = _key(email);
    if (!HiveService.users.containsKey(key)) return null;
    final code = (10000 + Random().nextInt(90000)).toString();
    final box = HiveService.settings;
    await box.put(_resetEmailKey, key);
    await box.put(_resetCodeKey, code);
    await box.put(_resetVerifiedKey, false);
    return code;
  }

  Future<bool> verifyResetCode(String email, String code) async {
    final box = HiveService.settings;
    final ok = box.get(_resetEmailKey) == _key(email) &&
        box.get(_resetCodeKey) == code;
    if (ok) await box.put(_resetVerifiedKey, true);
    return ok;
  }

  /// Changes the password; only allowed after the code was verified.
  Future<bool> resetPassword(String email, String newPassword) async {
    final box = HiveService.settings;
    final key = _key(email);
    final verified = box.get(_resetVerifiedKey) == true &&
        box.get(_resetEmailKey) == key;
    final user = HiveService.users.get(key);
    if (!verified || user == null) return false;

    await HiveService.users.put(
      key,
      UserModel(
        username: user.username,
        email: user.email,
        passwordHash: _hash(newPassword),
        createdAt: user.createdAt,
      ),
    );
    await box.delete(_resetEmailKey);
    await box.delete(_resetCodeKey);
    await box.delete(_resetVerifiedKey);
    return true;
  }
}
