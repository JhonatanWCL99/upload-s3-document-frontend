import 'package:equatable/equatable.dart';
import 'package:upload_file_frontend/features/users/domain/models/user_model.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}
class LoadUsersEvent extends UserEvent {}

class AddUserEvent extends UserEvent {
  final User newUser;

  const AddUserEvent(this.newUser);

  @override
  List<Object> get props => [newUser];
}
