
import 'package:equatable/equatable.dart';
import 'package:upload_file_frontend/features/documents/domain/models/document_model.dart';

abstract class DocumentState extends Equatable {
  const DocumentState();

  @override
  List<Object> get props => [];
}

class DocumentsInitial extends DocumentState {}

class DocumentsEmpty extends DocumentState {}

class DocumentsLoading extends DocumentState {}

class DocumentsLoaded extends DocumentState {
  final List<Document> documents;

  const DocumentsLoaded(this.documents);

  @override
  List<Object> get props => [documents];
}

class DocumentsError extends DocumentState {
  final String message;

  const DocumentsError(this.message);

  @override
  List<Object> get props => [message];
}
