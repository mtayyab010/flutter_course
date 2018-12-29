import 'package:scoped_model/scoped_model.dart';

import '../models/user.dart';

class UserModel extends Model {
  User _authenticatedUser;

  void login(String email, String password) {
    _authenticatedUser = User(
      id: 'h123123',
      email: email,
      password: password,
    );
  }
}
