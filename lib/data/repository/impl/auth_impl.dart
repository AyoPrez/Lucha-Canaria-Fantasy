import 'package:injectable/injectable.dart';
import 'package:lucha_fantasy/data/model/user.dart';
import 'package:lucha_fantasy/data/repository/auth.dart';

@Injectable(as: Auth)
class AuthImpl implements Auth {

  @override
  Future<User?> getUser() async {
    return User(id: "1", email: "a@a.com", username: "Aa");
  }

  @override
  Future<bool> register({required String username, required String email, required String password}) async {
    if(username != "" && password != "" && email != "") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> signIn({required String username, required String password}) async {
    if(username != "" && password != "") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<void> forgotPassword({required String email}) async {

  }
}