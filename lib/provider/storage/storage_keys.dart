import 'package:easy_home_app/provider/storage/interface_storage_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageKeys extends IStorageKyes {
  final storage = const FlutterSecureStorage();

  void store({required token}) {
    storage.write(key: "Token", value: token);
  }

  Future<String?> readToken() {
    return storage.read(key: "Token");
  }
}