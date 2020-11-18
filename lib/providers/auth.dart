import 'dart:io';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';

class AuthProvider extends ChangeNotifier {
  String _token;
  String _userId;

  String get token => _token;
  bool get isAuthenticated => token != null;
  String get userId => _userId;

  Future<void> loginDummy() async {
    _token = 'demo';
    _userId = 'demo';
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        'http://10.0.2.2:8000/login',
        body: {
          'email': email,
          'password': password,
        },
        headers: {'Accept': 'application/json'},
      );

      final responseData = json.decode(response.body);
      if (responseData['errors'] != null) {
        throw HttpException(responseData['errors']['message'][0]);
      }
      _token = responseData['token'];
      _userId = responseData['user_id'].toString();

      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode({
        'userId': _userId,
        'token': _token,
      });
      prefs.setString('userData', userData);
    } catch (e) {
      throw e;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];

    notifyListeners();

    return true;
  }

  getDeviceName() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        return build.androidId + '|' + build.model + '|' + build.brand;
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        return data.identifierForVendor;
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }

  Future<void> logout() async {
    _userId = null;
    _token = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
