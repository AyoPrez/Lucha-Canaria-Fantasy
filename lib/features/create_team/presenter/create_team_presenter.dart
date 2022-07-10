import 'package:lucha_fantasy/core/services/exceptions/no_player_exception.dart';
import 'package:lucha_fantasy/core/services/exceptions/no_user_exception.dart';
import 'package:lucha_fantasy/core/services/exceptions/no_user_team_exception.dart';
import 'package:lucha_fantasy/features/auth/data/model/user.dart';
import 'package:lucha_fantasy/features/auth/data/repository/auth.dart';
import 'package:lucha_fantasy/features/create_team/ui/create_team_view.dart';
import 'package:lucha_fantasy/features/my_team/data/model/my_team.dart';
import 'package:lucha_fantasy/features/my_team/data/model/player.dart';
import 'package:lucha_fantasy/features/my_team/data/repository/my_team_repo.dart';
import 'package:lucha_fantasy/features/my_team/data/repository/player_repo.dart';

abstract class CreateTeamPresenter {
  Future<MyTeam> getMyTeam();
  Future<void> getPlayer(String playerId);
  Future<void> checkName(String name);

  void setCreateTeamView(CreateTeamView view);
}

class CreateTeamPresenterImpl extends CreateTeamPresenter {

  CreateTeamView? _createTeamView;
  MyTeamRepo repo;
  PlayerRepo playerRepo;
  Auth auth;

  CreateTeamPresenterImpl(this.repo, this.auth, this.playerRepo);

  @override
  Future<MyTeam> getMyTeam() async {
    final User? user = await auth.getUser();

    if(user != null) {
      final MyTeam? myTeam = await repo.getMyTeam(user.id);
      if(myTeam == null) {
        throw NoUserTeamException("");
      } else {
        return myTeam;
      }
    } else {
      throw NoUserException("");
    }
  }

  @override
  void setCreateTeamView(CreateTeamView view) {
    _createTeamView = view;
  }

  @override
  Future<void> getPlayer(String playerId) async {
    _createTeamView?.displayLoading();

    if(playerId.isNotEmpty) {
      final Player? player = await playerRepo.getPlayer(playerId);

      if (player != null) {
        // _createTeamView?.displayPlayerProfile(player);
      } else {
        _createTeamView?.displayError(NoPlayerException(""));
      }
    } else {
      _createTeamView?.displayError(NoPlayerException(""));
    }
  }



  @override
  Future<void> checkName(String name) async {
    //TODO add here repo logic to check if name is unique

    //TODO if name is unique, search for players in the database

    // List<Player> players = const [
    //   Player(id: "1", name: "Sara Sanchez Álamo", age: "25", alias: "", picture: "https://upload.wikimedia.org/wikipedia/commons/1/1f/Woman_1.jpg",
    //     points: "265", rank: "52", falls: "16", throws: "95", news: "", price: "35000", team: Team(id: "", name: "", rank: "", picture: "", location: "")),
    // Player(id: "1", name: "Sara Sanchez Álamo", age: "25", alias: "", picture: "https://upload.wikimedia.org/wikipedia/commons/1/1f/Woman_1.jpg",
    // points: "265", rank: "52", falls: "16", throws: "95", news: "", price: "35000", team: Team(id: "", name: "", rank: "", picture: "", location: "")),
    // Player(id: "1", name: "Sara Sanchez Álamo", age: "25", alias: "", picture: "https://upload.wikimedia.org/wikipedia/commons/1/1f/Woman_1.jpg",
    // points: "265", rank: "52", falls: "16", throws: "95", news: "", price: "35000", team: Team(id: "", name: "", rank: "", picture: "", location: "")),
    // Player(id: "1", name: "Sara Sanchez Álamo", age: "25", alias: "", picture: "https://upload.wikimedia.org/wikipedia/commons/1/1f/Woman_1.jpg",
    // points: "265", rank: "52", falls: "16", throws: "95", news: "", price: "35000", team: Team(id: "", name: "", rank: "", picture: "", location: ""))];

    var players = await playerRepo.getAllPlayers();

    var user = await auth.getUser();

    _createTeamView?.displayChooseTeamPlayers(user, players);
  }
}