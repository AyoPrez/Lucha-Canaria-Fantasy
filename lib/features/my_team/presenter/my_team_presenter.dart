import 'package:lucha_fantasy/core/services/exceptions/no_player_exception.dart';
import 'package:lucha_fantasy/core/services/exceptions/no_user_exception.dart';
import 'package:lucha_fantasy/core/services/exceptions/no_user_team_exception.dart';
import 'package:lucha_fantasy/features/auth/data/model/user.dart';
import 'package:lucha_fantasy/features/auth/data/repository/auth.dart';
import 'package:lucha_fantasy/features/my_team/data/model/my_team.dart';
import 'package:lucha_fantasy/features/my_team/data/model/player.dart';
import 'package:lucha_fantasy/features/my_team/data/repository/my_team_repo.dart';
import 'package:lucha_fantasy/features/my_team/data/repository/player_repo.dart';
import 'package:lucha_fantasy/features/my_team/ui/my_team_view.dart';

abstract class MyTeamPresenter {
  Future<MyTeam> getMyTeam();
  Future<void> getPlayer(String playerId);
  void setMyTeamView(MyTeamView view);
}

class MyTeamPresenterImpl extends MyTeamPresenter {

  MyTeamView? _myTeamView;
  MyTeamRepo repo;
  PlayerRepo playerRepo;
  Auth auth;

  MyTeamPresenterImpl(this.repo, this.auth, this.playerRepo);

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
  void setMyTeamView(MyTeamView view) {
    _myTeamView = view;
  }

  @override
  Future<void> getPlayer(String playerId) async {
    _myTeamView?.displayLoading();

    if(playerId.isNotEmpty) {
      final Player? player = await playerRepo.getPlayer(playerId);

      if (player != null) {
        _myTeamView?.displayPlayerProfile(player);
      } else {
        _myTeamView?.displayError(NoPlayerException(""));
      }
    } else {
      _myTeamView?.displayError(NoPlayerException(""));
    }
  }
}