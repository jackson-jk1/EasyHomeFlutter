import '../provider/api/http_client.dart';

class RealEstateRepository {
  final HttpClient injectedHttp;

  RealEstateRepository({required this.injectedHttp});

  Future<bool> scanQrCode(String qrCode) async {
    try {
      final response = await injectedHttp.post(
          url: "${injectedHttp.apiUrl()}/users/authenticate",
          header: {'Content-Type': 'application/json'},
          body: {"qrcode": qrCode});
      if (response.statusCodeIsOk) return true;
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }
}
