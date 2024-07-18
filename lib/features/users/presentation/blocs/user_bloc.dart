import 'package:bloc/bloc.dart';
import 'package:upload_file_frontend/features/users/domain/usecases/add_user_use_case.dart';
import 'package:upload_file_frontend/features/users/domain/usecases/get_users_use_case.dart';
import 'package:upload_file_frontend/features/users/presentation/blocs/user_event.dart';
import 'package:upload_file_frontend/features/users/presentation/blocs/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUseCase getUsersUseCase;
  final AddUserUseCase addUserUseCase;

  UserBloc({
    required this.getUsersUseCase,
    required this.addUserUseCase,
  }) : super(UsersInitial()) {
    on<LoadUsersEvent>(_onLoadUsers);
    on<AddUserEvent>(_onAddUser);
  }

  void _onLoadUsers(LoadUsersEvent event, Emitter<UserState> emit) async {
    emit(UsersLoading());
    try {
      final users = await getUsersUseCase.execute();

      emit(UsersLoaded(users));
    } catch (e) {
      emit(UsersError('Failed to load users: $e'));
    }
  }

  void _onAddUser(AddUserEvent event, Emitter<UserState> emit) async {
    emit(UsersLoading());
    try {
      await addUserUseCase.execute(event.newUser.fullName);
      add(LoadUsersEvent());
    } catch (e) {
      emit(UsersError('Failed to add user: $e'));
    }
  }
}
