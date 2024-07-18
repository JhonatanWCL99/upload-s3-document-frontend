import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upload_file_frontend/features/documents/data/data_sources/document_impl_api.dart';
import 'package:upload_file_frontend/features/documents/domain/usecases/add_document_use_case.dart';
import 'package:upload_file_frontend/features/documents/domain/usecases/get_documents_use_case.dart';
import 'package:upload_file_frontend/features/documents/presentation/widgets/add_document_modal.dart';
import 'package:upload_file_frontend/features/documents/presentation/widgets/documents_datatable.dart';
import 'package:upload_file_frontend/features/documents/presentation/blocs/document_bloc.dart';
import 'package:upload_file_frontend/features/documents/presentation/blocs/document_event.dart';
import 'package:upload_file_frontend/features/documents/presentation/blocs/document_state.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  late DocumentBloc _documentsBloc;
  final DocumentImplApi _documentsImplApi = DocumentImplApi();

  @override
  void initState() {
    super.initState();
    _documentsBloc = DocumentBloc(
      getDocumentsUseCase: GetDocumentsUseCase(documentApi: _documentsImplApi),
      addDocumentUseCase: AddDocumentUseCase(documentApi: _documentsImplApi),
    );
    _documentsBloc.add(LoadDocumentsEvent());
  }

  @override
  void dispose() {
    _documentsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Center(
          child: BlocBuilder<DocumentBloc, DocumentState>(
            bloc: _documentsBloc,
            builder: (context, state) {
              if (state is DocumentsLoading) {
                return const CircularProgressIndicator();
              } else if (state is DocumentsLoaded) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: SingleChildScrollView(
                              child: DocumentsDataTable(
                                  documents: state.documents))),
                    ],
                  ),
                );
              } else if (state is DocumentsError) {
                return Text(state.message);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: _documentsBloc,
                child: const AddDocumentModal(),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
