import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:upload_file_frontend/modals/add_user_modal.dart';
import 'package:upload_file_frontend/services/user_service.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  var _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    var users = await UserService.getUsers();
    setState(() {
      _users = users;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Center(
          child: FutureBuilder<List<dynamic>>(
            future: UserService.getUsers(),
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
                              label: Text('Nombre Completo',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Fecha de Creacion',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ],
                        rows: snapshot.data!.map((user) {
                          var createdAt = DateFormat('dd-MM-yyyy HH:mm')
                              .format(DateTime.parse(user['createdAt']).toLocal());
                          return DataRow(
                            cells: [
                              DataCell(Text(user['_id'])),
                              DataCell(Text(user['fullName'])),
                              DataCell(Text(createdAt)),
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
              return AddUserModal(
                updateUserList: () {
                  setState(() async {
                    await _loadUsers();
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
