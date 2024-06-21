import 'dart:convert';

import 'package:flutter_youtube_at_home/feature/user/domain/post_login_request.dart';
import 'package:flutter_youtube_at_home/feature/user/data/repository/user_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserAPIDataProvider extends UserProvider {
  final baseUrl = 'http://localhost:8080/api';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<void> postLogin(PostLoginRequest requestData) async {
    var response = await http.post(Uri.parse('$baseUrl/user/login'),
        body: requestData.toJson());
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final String token = decoded['data']['token'];
      if (token != "") {
        final SharedPreferences prefs = await _prefs;
        prefs.setString('token', decoded['data']['token']);
      }
    } else {
      throw Exception('Failed to login');
    }
  }
}
