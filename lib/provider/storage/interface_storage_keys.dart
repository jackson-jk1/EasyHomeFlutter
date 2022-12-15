abstract class IStorageKyes
{
  void store({required token});
  Future<String?> readToken();
}