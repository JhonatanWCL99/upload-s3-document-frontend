import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DocumentService {
  static Future<List<dynamic>> getDocuments() async {
    final response = await http.get(Uri.parse(
        '${dotenv.env['API_BASE_URL']}/document'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load documents');
    }
  }

  static Future<Map<String, Object>> createDocument(
      String userId, PlatformFile file) async {
    final url =
        Uri.parse('${dotenv.env['API_BASE_URL']}/document');
    final request = http.MultipartRequest('POST', url);
    request.fields['uploadedBy'] = userId;
    request.files.add(http.MultipartFile.fromBytes('document', file.bytes!,filename: file.name));

    final response = await request.send();

    if (response.statusCode == 201) {
      return {'status': true, 'msg': 'Documento creado exitosamente'};
    } else {
      return {'status': false, 'msg': 'Hubo un inconveniente inesperado'};
    }
  }

}
