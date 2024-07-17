import 'package:upload_file_frontend/features/users/data/data_sources/user_impl_api.dart';

class AddUserUseCase {
  final UserImplApi userApi;

  AddUserUseCase({required this.userApi});

  Future<Map<String, Object>> execute(String fullName) async {
    try {
      return await userApi.createUser(fullName);
    } catch (e) {
      print('Error creating user: $e');
      throw Exception('Failed to create user');
    }
  }
}
