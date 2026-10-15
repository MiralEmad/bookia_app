import 'package:hive/hive.dart';

class UserModel {
  UserModel({
    required this.username,
    required this.email,
    required this.passwordHash,
    required this.createdAt,
  });

  final String username;
  final String email;
  final String passwordHash;
  final DateTime createdAt;
}

/// Hand-written Hive adapter (no build_runner needed).
class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) => UserModel(
        username: reader.readString(),
        email: reader.readString(),
        passwordHash: reader.readString(),
        createdAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      );

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeString(obj.username)
      ..writeString(obj.email)
      ..writeString(obj.passwordHash)
      ..writeInt(obj.createdAt.millisecondsSinceEpoch);
  }
}
