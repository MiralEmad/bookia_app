import 'dart:convert';
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
}
