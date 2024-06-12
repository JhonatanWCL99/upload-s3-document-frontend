import 'package:flutter/material.dart';
import 'package:upload_file_frontend/services/user_service.dart';

class AddUserModal extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final Function() updateUserList;

  AddUserModal({super.key, required this.updateUserList});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar nuevo usuario'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: fullNameController,
            decoration: const InputDecoration(labelText: 'Nombre Completo'),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            var result = await UserService.createUser(fullNameController.text);
            if (result['status'] == true) {
              Navigator.of(context).pop();
              updateUserList(); // Llama a la función de actualización
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result['msg'] as String),
                  duration: const Duration(seconds: 2),
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
