import 'package:equatable/equatable.dart';
import 'package:upload_file_frontend/features/documents/domain/dtos/create_document_model.dart';

abstract class DocumentEvent extends Equatable {
  const DocumentEvent();

  @override
  List<Object> get props => [];
}

class LoadDocumentsEvent extends DocumentEvent {}

class AddDocumentEvent extends DocumentEvent {
  final CreateDocumentDTO createDocumentDTO;

  const AddDocumentEvent(this.createDocumentDTO);

  @override
  List<Object> get props => [createDocumentDTO];
}
