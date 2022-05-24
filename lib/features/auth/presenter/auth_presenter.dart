import 'package:lucha_fantasy/features/auth/data/repository/auth.dart';

abstract class AuthPresenter {
  Future<bool> signupUser(email, username, password);
  Future<bool> loginUser(username, password);
  Future<void> forgotPassword(email);
}

class AuthPresenterImpl extends AuthPresenter {

  final Auth auth;

  AuthPresenterImpl(this.auth);

  @override
  Future<bool> signupUser(email, username, password) async {
    return await auth.register(username: username,email: email, password: password);
  }

  @override
  Future<bool> loginUser(username, password) async {
    return await auth.signIn(username: username, password: password);
  }

  @override
  Future<void> forgotPassword(email) {
    return auth.forgotPassword(email: email);
  }
}