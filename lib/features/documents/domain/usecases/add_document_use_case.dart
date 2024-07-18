import 'package:file_picker/file_picker.dart';
import 'package:upload_file_frontend/features/documents/data/data_sources/document_impl_api.dart';

class AddDocumentUseCase {
  final DocumentImplApi documentApi;

  AddDocumentUseCase({required this.documentApi});

  Future<Map<String, Object>> execute(String idUser, PlatformFile file) async {
    try {
      return await documentApi.createDocument(idUser, file);
    } catch (e) {
      throw Exception('Failed to create user');
    }
  }
}
