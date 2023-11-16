import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/local_user.dart';

class LocalStorage{
  static writeUserToLocalStorage(LocalUser user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user', jsonEncode(user.toJson()));
    print('written: ${jsonEncode(user.toJson())}');
  }

  static Future<LocalUser?> readUserFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('current_user');
    print('read: $user');
    if (user != null) {
      return LocalUser.fromJson(jsonDecode(user));
    }
    return null;
  }

}