import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler1 {
  String baseurl = "http://192.168.43.115:3000";

  var log = Logger();
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future get1(String url) async {
    log.i("bien");
    url = formater(url);

    var response = await http.get(
      url,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<http.Response> post1(String url, var body) async {
    url = formater(url);
    log.d(body);
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json"},
      body: json.encode(body),
    );
    print(response.body);
    print(response.body);
    return response;
  }

  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

  String formater(String url) {
    return baseurl + url;
  }
}
