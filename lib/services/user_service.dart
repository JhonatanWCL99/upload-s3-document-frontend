import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class  UserService {
  static Future<List<dynamic>> getUsers() async {
    try {
      final response = await http.get(Uri.parse('${dotenv.env['API_BASE_URL']}/user'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
      return [];
    }
  }

  static Future<Map<String, Object>> createUser(String fullName) async {
    final url =
        Uri.parse('${dotenv.env['API_BASE_URL']}/user');
    final response = await http.post(
      url,
      body: jsonEncode({'fullName': fullName}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return {'status': true, 'msg': 'Usuario creado exitosamente'};
    } else {
      return {'status': false, 'msg': 'Hubo un inconveniente inesperado'};
    }
  }
}
