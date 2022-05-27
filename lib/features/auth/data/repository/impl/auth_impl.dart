import 'package:lucha_fantasy/core/services/parse_service.dart';
import 'package:lucha_fantasy/features/auth/data/model/user.dart';
import 'package:lucha_fantasy/features/auth/data/repository/auth.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';


class AuthImpl implements Auth {

  final ParseService _parseService;

  AuthImpl(this._parseService);

  @override
  Future<User?> getUser() async {
    final ParseUser? user = await _parseService.getParseUser();

    if(user != null) {
      return User(id: user.objectId.toString(), email: user.emailAddress.toString(), username: user.username.toString());
    } else {
      return null;
    }
  }

  @override
  Future<bool> register({required String username, required String email, required String password}) async {
    return await _parseService.register(username: username, email: email, password: password);
  }

  @override
  Future<bool> signIn({required String username, required String password}) async {
    return await _parseService.signIn(username: username, password: password);
  }

  @override
  Future<bool> logOut() async {
    return await _parseService.logOut();
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await _parseService.forgotPassword(email: email);
  }
}