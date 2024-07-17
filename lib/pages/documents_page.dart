import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:upload_file_frontend/modals/add_document_modal.dart';
import 'package:upload_file_frontend/services/document_service.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({Key? key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  var _documents = [];

  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

   Future<void> _loadDocuments() async {
    var users = await DocumentService.getDocuments();
    setState(() {
      _documents = users;
    });
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
          child: FutureBuilder<List<dynamic>>(
            future: DocumentService.getDocuments(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      DataTable(
                        decoration: BoxDecoration(border: Border.all()),
                        columns: const [
                          DataColumn(
                              label: Text('Identificador',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Subido por',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Fecha de Creación',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Descargar Documento',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                        rows: snapshot.data!.map((document) {
                          var createdAt = DateFormat('dd-MM-yyyy HH:mm')
                              .format(DateTime.parse(document['createdAt']).toLocal());
                          return DataRow(
                            cells: [
                              DataCell(Text(document['_id'])),
                              DataCell(Text(document['uploadedBy']['fullName'])),
                              DataCell(Text(createdAt)),
                              DataCell(
                                GestureDetector(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.blue,
                                    ),
                                    child: const Text(
                                      'Ver Documento',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    launchUrl(Uri.parse(document['url']));
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
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
              return AddDocumentModal(
                updateDocumentList: () {
                  setState(() async {
                    await _loadDocuments();
                  });
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
