
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:upload_file_frontend/features/users/data/data_sources/abstract_user_api.dart';
import 'package:upload_file_frontend/features/users/domain/models/user_model.dart';

class UserImplApi extends AbstractUserApi {

  // Articles Method
  @override
  Future<List<User>> getUsers() async {
    try {
      final response = await http.get(Uri.parse('${dotenv.env['API_BASE_URL']}/user'));
      if (response.statusCode == 200) {
        final List<dynamic> usersJson = json.decode(response.body);
        return usersJson.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
      return [];
    }
  }

  @override
  Future<Map<String, Object>> createUser(String fullName) async {
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