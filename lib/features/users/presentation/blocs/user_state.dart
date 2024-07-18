import 'package:equatable/equatable.dart';
import 'package:upload_file_frontend/features/users/domain/models/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}
class UsersInitial extends UserState {}

class UsersLoading extends UserState {}
class UsersLoaded extends UserState {
  final List<User> users;

  const UsersLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class UsersError extends UserState {
  final String message;

  const UsersError(this.message);

  @override
  List<Object> get props => [message];
}
