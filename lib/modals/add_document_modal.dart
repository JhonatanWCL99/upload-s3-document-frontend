import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:upload_file_frontend/services/document_service.dart';
import 'package:upload_file_frontend/services/user_service.dart';

class AddDocumentModal extends StatefulWidget {
  final Function() updateDocumentList;

  const AddDocumentModal({super.key, required this.updateDocumentList});

  @override
  State<AddDocumentModal> createState() => _AddDocumentModalState();
}

class _AddDocumentModalState extends State<AddDocumentModal> {
  PlatformFile? _pickedfile;
  final TextEditingController fileController = TextEditingController();

  final TextEditingController uploadedByController = TextEditingController();
  String? selectedUserId;
  List<dynamic>? users;

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _pickedfile = result.files.single;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    List<dynamic> fetchedUsers = await UserService.getUsers();
    setState(() {
      users = fetchedUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar nuevo documento'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(_pickedfile?.name ?? 'Subir archivo'),
            onTap: _openFileExplorer,
            leading: const Icon(Icons.attach_file),
          ),
          users != null
              ? DropdownButtonFormField<String>(
                  value: selectedUserId,
                  onChanged: (newValue) {
                    setState(() {
                      selectedUserId = newValue;
                    });
                  },
                  items: users!.map<DropdownMenuItem<String>>((user) {
                    return DropdownMenuItem<String>(
                      value: user['_id'],
                      child: Text(user['fullName']),
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Subido Por'),
                )
              : const CircularProgressIndicator(),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (_pickedfile != null) {
              var result = await DocumentService.createDocument(
                  selectedUserId!, _pickedfile as PlatformFile);
              if (result['status'] == true) {
                Navigator.of(context).pop(); // Cerrar el modal
                widget
                    .updateDocumentList(); // Actualizar la lista de documentos
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result['msg'] as String),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Por favor seleccione un archivo'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: const Text('Guardar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cierra el modal
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
