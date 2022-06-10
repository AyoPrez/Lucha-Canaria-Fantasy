import 'package:lucha_fantasy/features/my_team/data/model/player.dart';

abstract class MyTeamView {

  void displayPlayerProfile(Player player);
  void displayLoading();
  void displayError(Exception exception);

}