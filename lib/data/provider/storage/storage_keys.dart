import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageKeys {
  final storage = const FlutterSecureStorage();

  void store({required token}) {
    storage.write(key: "Token", value: token);
  }

  Future<String?> readToken() {
    return storage.read(key: "Token");
  }
}