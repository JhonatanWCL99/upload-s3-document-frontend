import 'package:upload_file_frontend/features/users/domain/models/user_model.dart';

abstract class AbstractUserApi {
  Future<List<User>> getUsers();
  Future<Map<String, Object>> createUser(String fullName);
}
