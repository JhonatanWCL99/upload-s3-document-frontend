import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:upload_file_frontend/features/documents/domain/models/document_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentsDataTable extends StatelessWidget {
  final List<Document> documents;

  const DocumentsDataTable({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 31, 35, 39),
                ),
                headingRowColor: WidgetStateColor.resolveWith(
                    (states) => const Color.fromARGB(19, 54, 52, 52)),
                dataRowColor:
                    WidgetStateColor.resolveWith((states) => Colors.grey[50]!),
                columnSpacing: 200,
                dataRowMinHeight:25 ,
                horizontalMargin: 50,
                showCheckboxColumn: false,
                decoration: BoxDecoration(border: Border.all()),
                columns: const [
                  DataColumn(
                    label: Text('Identificador',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Subido por',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Fecha de Creación',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Archivo',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  DataColumn(
                    label: Text('Descargar Documento',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
                rows: documents.map((document) {
                  var createdAt = DateFormat('dd-MM-yyyy HH:mm')
                      .format(DateTime.parse(document.createdAt!).toLocal());
                  return DataRow(
                    cells: [
                      DataCell(Text(document.id!)),
                      DataCell(Text(document.uploadedBy.fullName)),
                      DataCell(Text(createdAt)),
                      DataCell(
                        Image.network(
                          width: 100,
                          height: 100,
                          document.url.toString(),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Text('No se pudo cargar la imagen');
                          },
                        ),
                      ),
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
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onTap: () {
                            launchUrl(Uri.parse(document.url));
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
