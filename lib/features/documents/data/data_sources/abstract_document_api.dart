import 'package:file_picker/file_picker.dart';
import 'package:upload_file_frontend/features/documents/domain/models/document_model.dart';

abstract class AbstractDocumentApi {
  Future<List<Document>> getDocuments();
  Future<Map<String, Object>> createDocument(String userId, PlatformFile file);
}
