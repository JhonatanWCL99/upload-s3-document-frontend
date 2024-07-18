import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:upload_file_frontend/core/services/http_service.dart';
import 'package:upload_file_frontend/features/documents/data/data_sources/abstract_document_api.dart';
import 'package:upload_file_frontend/features/documents/domain/models/document_model.dart';

class DocumentImplApi extends AbstractDocumentApi {
  final HttpService _httpService = HttpService();
  final String _baseUrl = dotenv.env['API_BASE_URL'] ?? '';
  final String _documentEndpoint = '/document';

  Uri get _documentUri => Uri.parse('$_baseUrl$_documentEndpoint');

  List<Document> _parseDocuments(String responseBody) {
    final List<dynamic> documentsJson = json.decode(responseBody);
    return documentsJson.map((json) => Document.fromJson(json)).toList();
  }

  @override
  Future<List<Document>> getDocuments() async {
    try {
      final response = await _httpService.getRequest(_documentUri);

      if (response.statusCode == 200) {
        return _parseDocuments(response.body);
      } else {
        throw Exception('Failed to load documents: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error en la solicitud HTTP: $e');
      return [];
    }
  }

  @override
  Future<Map<String, Object>> createDocument(
      String userId, PlatformFile file) async {
    final fields = {'uploadedBy': userId};
    final files = [
      http.MultipartFile.fromBytes('document', file.bytes!, filename: file.name)
    ];

    final response =
        await _httpService.multipartRequest(_documentUri, fields, files);

    if (response.statusCode == 201) {
      return {'status': true, 'msg': 'Documento creado exitosamente'};
    } else {
      return {
        'status': false,
        'msg': 'Hubo un inconveniente inesperado: ${response.reasonPhrase}'
      };
    }
  }
}
