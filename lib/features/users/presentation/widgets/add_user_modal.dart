import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upload_file_frontend/features/users/domain/models/user_model.dart';
import 'package:upload_file_frontend/features/users/presentation/blocs/user_bloc.dart';
import 'package:upload_file_frontend/features/users/presentation/blocs/user_event.dart';

class AddUserModal extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();

  AddUserModal({super.key});

  @override
  Widget build(BuildContext context) {
    final usersBloc = BlocProvider.of<UserBloc>(context);

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
            final newUser = User(fullName: fullNameController.text);
            usersBloc.add(AddUserEvent(newUser));
            Navigator.of(context).pop();
          },
          child: const Text('Guardar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
