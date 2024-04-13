import 'dart:convert';
import 'package:http/http.dart' as http;
import 'end_points.dart';

class Http {
  static Future<http.Response> postData(
      {required String path,
      required Map<String, dynamic> map,
      String? token}) async {
    return await http.post(
      Uri.parse(baseUrl + path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": 'Bearer $token' ?? ""
      },
      body: jsonEncode(map),
    );
  }

  static Future<http.Response> getData({
    required String path,
    Map<String, dynamic>? params,
    String? token,
  }) async {
    Uri uri = Uri.parse(baseUrl + path);
    if (params != null && params.isNotEmpty) {
      uri = uri.replace(queryParameters: params);
    }
    return await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token ?? ""
      },
    );
  }

  static Future<http.Response> deleteData({
    required String path,
    Map<String, dynamic>? map,
    String? token,
  }) async {
    return await http.delete(
      Uri.parse(baseUrl + path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": token ?? ""
      },
    );
  }

  static Future<http.Response> editData(
      {required String path,
        required Map<String, dynamic> map,
        String? token}) async {
    return await http.put(
      Uri.parse(baseUrl + path),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": 'Bearer $token' ?? ""
      },
      body: jsonEncode(map),
    );
  }

}
