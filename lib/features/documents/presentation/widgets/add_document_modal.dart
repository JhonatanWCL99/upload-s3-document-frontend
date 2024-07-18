import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:upload_file_frontend/features/documents/domain/dtos/create_document_model.dart';
import 'package:upload_file_frontend/features/documents/presentation/blocs/document_bloc.dart';
import 'package:upload_file_frontend/features/documents/presentation/blocs/document_event.dart';
import 'package:upload_file_frontend/features/users/data/data_sources/user_impl_api.dart';
import 'package:upload_file_frontend/features/users/domain/usecases/add_user_use_case.dart';
import 'package:upload_file_frontend/features/users/domain/usecases/get_users_use_case.dart';
import 'package:upload_file_frontend/features/users/presentation/blocs/user_bloc.dart';
import 'package:upload_file_frontend/features/users/presentation/blocs/user_event.dart';
import 'package:upload_file_frontend/features/users/presentation/blocs/user_state.dart';

class AddDocumentModal extends StatefulWidget {
  const AddDocumentModal({super.key});

  @override
  State<AddDocumentModal> createState() => _AddDocumentModalState();
}

class _AddDocumentModalState extends State<AddDocumentModal> {
  PlatformFile? _pickedFile;
  String? selectedUserId;
  List<dynamic>? users;
  late UserBloc _usersBloc;
  final UserImplApi _userImplApi = UserImplApi();

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _pickedFile = result.files.single;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _usersBloc = UserBloc(
      getUsersUseCase: GetUsersUseCase(userApi: _userImplApi),
      addUserUseCase: AddUserUseCase(userApi: _userImplApi),
    );
    _usersBloc.add(LoadUsersEvent());
  }

  @override
  void dispose() {
    _usersBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final documentsBloc = BlocProvider.of<DocumentBloc>(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 30.0,
      title: const Text('Agregar nuevo documento'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(_pickedFile?.name ?? 'Subir archivo'),
            onTap: _openFileExplorer,
            leading: const Icon(Icons.attach_file),
          ),
          BlocBuilder<UserBloc, UserState>(
            bloc: _usersBloc,
            builder: (context, state) {
              if (state is UsersLoading) {
                return const CircularProgressIndicator();
              } else if (state is UsersLoaded) {
                users = state.users;
                return DropdownButtonFormField<String>(
                  value: selectedUserId,
                  onChanged: (newValue) {
                    setState(() {
                      selectedUserId = newValue;
                    });
                  },
                  items: users!.map<DropdownMenuItem<String>>((user) {
                    return DropdownMenuItem<String>(
                      value: user.id,
                      child: Text(user.fullName),
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Subido Por'),
                );
              } else if (state is UsersError) {
                return Text(state.message);
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_pickedFile != null && selectedUserId != null) {
              final newDocument = CreateDocumentDTO(
                  userId: selectedUserId!, file: _pickedFile!);
              documentsBloc.add(AddDocumentEvent(newDocument));
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content:
                        Text('Por favor seleccione un archivo y un usuario'),
                    duration: Duration(seconds: 2)),
              );
            }
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
