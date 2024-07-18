import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:upload_file_frontend/core/services/http_service.dart';
import 'package:upload_file_frontend/features/users/data/data_sources/abstract_user_api.dart';
import 'package:upload_file_frontend/features/users/domain/models/user_model.dart';

class UserImplApi extends AbstractUserApi {
  final HttpService _httpService = HttpService();
  final String _baseUrl = dotenv.env['API_BASE_URL'] ?? '';
  final String _userEndpoint = '/user';

  Uri get _userUri => Uri.parse('$_baseUrl$_userEndpoint');

  List<User> _parseUsers(String responseBody) {
    final List<dynamic> usersJson = json.decode(responseBody);
    return usersJson.map((json) => User.fromJson(json)).toList();
  }

  @override
  Future<List<User>> getUsers() async {
    final response = await _httpService.getRequest(_userUri);

    if (response.statusCode == 200) {
      return _parseUsers(response.body);
    } else {
      throw Exception('Failed to load users: ${response.reasonPhrase}');
    }
  }

  @override
  Future<Map<String, Object>> createUser(String fullName) async {
    final response =
        await _httpService.postRequest(_userUri, {'fullName': fullName});

    if (response.statusCode == 201) {
      return {'status': true, 'msg': 'Usuario creado exitosamente'};
    } else {
      return {
        'status': false,
        'msg': 'Hubo un inconveniente inesperado: ${response.reasonPhrase}'
      };
    }
  }
}
