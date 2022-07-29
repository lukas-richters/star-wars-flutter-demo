import 'dart:async';
import 'package:http/http.dart' as http;

class NetUtil {
  static const String baseUrl = "https://swapi.dev/api/";

  Future<http.Response> get(String endpoint, {String? params}) async {
    var url = params != null
        ? Uri.parse('$baseUrl$endpoint?$params')
        : Uri.parse(baseUrl + endpoint);
    return await http.get(url);
  }
}
