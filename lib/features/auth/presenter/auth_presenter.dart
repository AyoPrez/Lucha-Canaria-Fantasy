import 'package:lucha_fantasy/core/services/exceptions/empty_fields_exception.dart';
import 'package:lucha_fantasy/core/services/exceptions/fail_login_exception.dart';
import 'package:lucha_fantasy/core/services/exceptions/fail_register_exception.dart';
import 'package:lucha_fantasy/core/services/exceptions/wrong_email_format_exception.dart';
import 'package:lucha_fantasy/features/auth/data/repository/auth.dart';
import 'package:lucha_fantasy/features/auth/ui/create_account_view.dart';
import 'package:lucha_fantasy/features/auth/ui/forgot_password_view.dart';
import 'package:lucha_fantasy/features/auth/ui/login_view.dart';

abstract class AuthPresenter {
  Future<void> signupUser(email, username, password);
  Future<void> loginUser(username, password);
  Future<void> forgotPassword(email);
  Future<bool> isSessionActive();
  void setCreateAccountView(CreateAccountView view);
  void setLoginView(LoginView view);
  void setForgotPasswordView(ForgotPasswordView view);
}

class AuthPresenterImpl extends AuthPresenter {

  Auth auth;
  CreateAccountView? _createAccountView;
  LoginView? _loginView;
  ForgotPasswordView? _forgotPasswordView;

  AuthPresenterImpl(this.auth);

  @override
  Future<void> signupUser(email, username, password) async {
    try {
      if (username.isEmpty || password.isEmpty || email.isEmpty) {
        _createAccountView?.displayDialog(EmptyFieldsException());
      } else {
        final bool result = await auth.register(username: username,email: email, password: password);

        if (result) {
          _createAccountView?.navigateToLoginScreen();
        } else {
          _createAccountView?.displayDialog(null);
        }
      }
    } on FailRegisterException catch (e) {
      _createAccountView?.displayDialog(e);
    } on EmptyFieldsException catch (e) {
      _createAccountView?.displayDialog(e);
    }
  }

  @override
  Future<void> loginUser(username, password) async {
    try {
      if(username.isEmpty || password.isEmpty) {
        _loginView?.displayDialog(EmptyFieldsException());
      } else {
        final bool result = await auth.signIn(username: username, password: password);

        if (result) {
          _loginView?.navigateToMainScreen();
        } else {
          _loginView?.displayDialog(null);
        }
      }
    } on FailLoginException catch (e) {
      _loginView?.displayDialog(e);
    } on EmptyFieldsException catch(e) {
      _loginView?.displayDialog(e);
    }
  }

  @override
  Future<void> forgotPassword(email) async {
    if (email.isEmpty) {
      _forgotPasswordView?.displayDialog(EmptyFieldsException());
    } else if(!email.contains('@')) {
      _forgotPasswordView?.displayDialog(WrongEmailFormatException());
    } else {
      await auth.forgotPassword(email: email);
      _forgotPasswordView?.displayDialog(null);
    }
  }

  @override
  Future<bool> isSessionActive() async {
    bool sessionActive = await auth.isSessionActive();

    if(!sessionActive) {
      _loginView?.navigateToMainScreen();
    }

    return sessionActive;
  }

  @override
  void setCreateAccountView(CreateAccountView view) {
    _createAccountView = view;
  }

  @override
  void setLoginView(LoginView view) {
    _loginView = view;
  }

  @override
  void setForgotPasswordView(ForgotPasswordView view) {
    _forgotPasswordView = view;
  }
}