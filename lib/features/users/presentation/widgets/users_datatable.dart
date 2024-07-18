import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:upload_file_frontend/features/users/domain/models/user_model.dart';

class UsersDataTable extends StatelessWidget {
  final List<User> users;

  const UsersDataTable({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: DataTable(
                    headingTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 31, 35, 39),
                    ),
                    headingRowColor: WidgetStateColor.resolveWith(
                        (states) => const Color.fromARGB(19, 54, 52, 52)),
                    dataRowColor: WidgetStateColor.resolveWith(
                        (states) => Colors.grey[50]!),
                    columnSpacing: 200,
                    horizontalMargin: 50,
                    showCheckboxColumn: false,
                    decoration: BoxDecoration(border: Border.all()),
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Identificador',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Nombre Completo',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Fecha de Creación',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: users.map((user) {
                      String createdAt = DateFormat('dd-MM-yyyy HH:mm').format(
                        DateTime.parse(user.createdAt!).toLocal(),
                      );
                      return DataRow(
                        cells: [
                          DataCell(Text(user.id!)),
                          DataCell(Text(user.fullName)),
                          DataCell(Text(createdAt)),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
