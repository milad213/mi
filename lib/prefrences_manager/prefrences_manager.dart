import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static late SharedPreferences sharedPreferences ;

  static init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future setData({
    required dynamic value,
    required String key,
  }) async {
    String jsonString = jsonEncode(value);
    return await sharedPreferences.setString(key, jsonString);
  }


  static dynamic getData(String key) {
    String? jsonString = sharedPreferences.getString(key);
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

}