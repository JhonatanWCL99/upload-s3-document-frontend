import 'package:upload_file_frontend/features/documents/data/data_sources/document_impl_api.dart';
import 'package:upload_file_frontend/features/documents/domain/models/document_model.dart';

class GetDocumentsUseCase {
  final DocumentImplApi documentApi;

  GetDocumentsUseCase({required this.documentApi});

  Future<List<Document>> execute() async {
    try {
      return await documentApi.getDocuments();
    } catch (e) {
      throw Exception('Failed to fetch users');
    }
  }
}
