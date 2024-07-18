import 'package:bloc/bloc.dart';
import 'package:upload_file_frontend/features/documents/domain/usecases/add_document_use_case.dart';
import 'package:upload_file_frontend/features/documents/domain/usecases/get_documents_use_case.dart';
import 'package:upload_file_frontend/features/documents/presentation/blocs/document_event.dart';
import 'package:upload_file_frontend/features/documents/presentation/blocs/document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  final GetDocumentsUseCase getDocumentsUseCase;
  final AddDocumentUseCase addDocumentUseCase;

  DocumentBloc({
    required this.getDocumentsUseCase,
    required this.addDocumentUseCase,
  }) : super(DocumentsInitial()) {
    on<LoadDocumentsEvent>(_onLoadDocuments);
    on<AddDocumentEvent>(_onAddDocument);
  }

  void _onLoadDocuments(
      LoadDocumentsEvent event, Emitter<DocumentState> emit) async {
    emit(DocumentsLoading());
    try {
      final users = await getDocumentsUseCase.execute();

      if (users.isEmpty) {
        emit(DocumentsEmpty());
      } else {
        emit(DocumentsLoaded(users));
      }
    } catch (e) {
      emit(DocumentsError('Failed to load users: $e'));
    }
  }

  void _onAddDocument(
      AddDocumentEvent event, Emitter<DocumentState> emit) async {
    emit(DocumentsLoading());
    try {
      await addDocumentUseCase.execute(
          event.createDocumentDTO.userId, event.createDocumentDTO.file);
      add(LoadDocumentsEvent());
    } catch (e) {
      emit(DocumentsError('Failed to add user: $e'));
    }
  }
}
