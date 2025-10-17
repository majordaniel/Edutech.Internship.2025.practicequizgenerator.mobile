import 'package:http/http.dart' as http;

// Unauthenticated API Handle
class Api {
  final String key;
  final Uri baseUrl;

  Api({required baseUrl, required apiKey})
    : key = apiKey,
      baseUrl = Uri.parse('$baseUrl/api');
}
