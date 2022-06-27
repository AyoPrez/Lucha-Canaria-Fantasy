
import 'package:lucha_fantasy/core/services/exceptions/no_session_exception.dart';
import 'package:lucha_fantasy/core/services/exceptions/no_user_exception.dart';
import 'package:lucha_fantasy/features/auth/data/repository/auth.dart';
import 'package:lucha_fantasy/features/main/ui/mainView.dart';

abstract class MainPresenter {
  Future<void> getUserData();
  Future<bool> logout();
  void setMainView(MainView view);
}

class MainPresenterImpl extends MainPresenter {

  Auth authRepo;

  MainPresenterImpl(this.authRepo);

  MainView? _mainView;

  @override
  Future<void> getUserData() async {
    _mainView?.displayLoading();
    try {
      var user = await authRepo.getUser();

      if(user != null) {
        _mainView?.displayPlayerProfile(user);
      } else {
        _mainView?.displayError(NoSessionException(""));
      }
    } catch (exception) {
      _mainView?.displayError(NoUserException(""));
    }
  }

  @override
  Future<bool> logout() {
    return authRepo.logOut();
  }

  @override
  void setMainView(MainView view) {
    _mainView = view;
  }
}