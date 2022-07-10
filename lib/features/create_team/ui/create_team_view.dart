import 'package:lucha_fantasy/features/auth/data/model/user.dart';
import 'package:lucha_fantasy/features/my_team/data/model/player.dart';

abstract class CreateTeamView {

  void displayAddTeamName(bool isNameReady);
  void displayChooseTeamPlayers(User? user, List<Player> playersList);
  void displayLoading();
  void displayError(Exception exception);

}