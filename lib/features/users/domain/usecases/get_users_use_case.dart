
import 'package:upload_file_frontend/features/users/data/data_sources/user_impl_api.dart';
import 'package:upload_file_frontend/features/users/domain/models/user_model.dart';

class GetUsersUseCase {
  final UserImplApi userApi;

  GetUsersUseCase({required this.userApi});

  Future<List<User>> execute() async {
    try {
      return await userApi.getUsers();
    } catch (e) {
      print('Error fetching users: $e');
      throw Exception('Failed to fetch users');
    }
  }
}
