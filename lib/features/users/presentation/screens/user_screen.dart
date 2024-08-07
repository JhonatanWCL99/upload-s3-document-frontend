import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upload_file_frontend/features/users/data/data_sources/user_impl_api.dart';
import 'package:upload_file_frontend/features/users/domain/usecases/add_user_use_case.dart';
import 'package:upload_file_frontend/features/users/domain/usecases/get_users_use_case.dart';
import 'package:upload_file_frontend/features/users/presentation/blocs/user_bloc.dart';
import 'package:upload_file_frontend/features/users/presentation/blocs/user_event.dart';
import 'package:upload_file_frontend/features/users/presentation/blocs/user_state.dart';
import 'package:upload_file_frontend/features/users/presentation/widgets/add_user_modal.dart';
import 'package:upload_file_frontend/features/users/presentation/widgets/users_datatable.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late UserBloc _usersBloc;
  final UserImplApi _userImplApi = UserImplApi();

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Usuarios',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: _usersBloc,
        builder: (context, state) {
          if (state is UsersInitial) {
            return const Text('Please load the users.');
          } else if (state is UsersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UsersLoaded) {
            return UsersDataTable(users: state.users);
          } else if (state is UsersError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: _usersBloc,
                child: AddUserModal(),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
