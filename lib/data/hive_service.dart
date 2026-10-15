import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'user_model.dart';

class HiveService {
  HiveService._();

  static const usersBoxName = 'users';
  static const settingsBoxName = 'settings';
  static const langKey = 'lang';
  static const sessionKey = 'session_email';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox<UserModel>(usersBoxName);
    await Hive.openBox(settingsBoxName);
  }

  static Box<UserModel> get users => Hive.box<UserModel>(usersBoxName);
  static Box get settings => Hive.box(settingsBoxName);
}
