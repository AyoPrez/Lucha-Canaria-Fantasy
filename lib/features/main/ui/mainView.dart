import 'package:lucha_fantasy/features/auth/data/model/user.dart';

abstract class MainView {

  void displayPlayerProfile(User? user);
  void displayLoading();
  void displayError(Exception exception);
}