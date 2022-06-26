
import 'package:lucha_fantasy/features/auth/data/model/user.dart';
import 'package:lucha_fantasy/features/auth/data/repository/auth.dart';

abstract class MainPresenter {
  Future<User?> getUserData();
  Future<bool> logout();
}

class MainPresenterImpl extends MainPresenter {

  Auth authRepo;

  MainPresenterImpl(this.authRepo);

  @override
  Future<User?> getUserData() {
    return authRepo.getUser();
  }

  @override
  Future<bool> logout() {
    return authRepo.logOut();
  }

}