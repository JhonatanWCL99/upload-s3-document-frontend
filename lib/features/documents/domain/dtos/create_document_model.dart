import 'package:file_picker/file_picker.dart';

class CreateDocumentDTO {
  final String userId;
  final PlatformFile file;

  CreateDocumentDTO({
    required this.userId,
    required this.file,
  });
}
