import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginAuth {
  static Future<Map<String, dynamic>?> login (String username, String password) async{
    final url = Uri.parse('http://localhost:8080/user/login');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };

    String jsonBody = jsonEncode(body);

    try {

      final response = await http.post(url, headers: headers, body: jsonBody);

      if (response.statusCode == 200) {

        return jsonDecode(response.body);

      } else {
        return null;
      }

    } catch (e) {
      return null;
    }
  }
}