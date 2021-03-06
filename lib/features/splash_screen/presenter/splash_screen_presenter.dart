import 'package:lucha_fantasy/features/auth/data/repository/auth.dart';

abstract class SplashScreenPresenter {
  Future<bool> isUserSessionActive();
}

class SplashScreenPresenterImpl extends SplashScreenPresenter {

  Auth auth;

  SplashScreenPresenterImpl(this.auth);

  @override
  Future<bool> isUserSessionActive() async {

    final bool sessionActive = await auth.isSessionActive();

    return sessionActive;
  }
}