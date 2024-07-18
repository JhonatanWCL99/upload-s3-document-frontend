import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService {
  Future<http.Response> getRequest(Uri url) async {
    try {
      final response = await http.get(url);
      return response;
    } catch (e) {
      throw Exception('Error making GET request: $e');
    }
  }

  Future<http.Response> postRequest(Uri url, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        url,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      return response;
    } catch (e) {
      throw Exception('Error making POST request: $e');
    }
  }

  Future<http.StreamedResponse> multipartRequest(Uri url,
      Map<String, String> fields, List<http.MultipartFile> files) async {
    try {
      final request = http.MultipartRequest('POST', url)
        ..fields.addAll(fields)
        ..files.addAll(files);

      final response = await request.send();
      return response;
    } catch (e) {
      throw Exception('Error making multipart request: $e');
    }
  }
}
