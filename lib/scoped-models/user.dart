import 'package:scoped_model/scoped_model.dart';

import '../models/user.dart';
import './connected_products.dart';

mixin UserModel on ConnectedProducts {
  User _authenticatedUser;

  void login(String email, String password) {
    authenticatedUser = User(
      id: 'hi123123',
      email: email,
      password: password,
    );
  }
}
