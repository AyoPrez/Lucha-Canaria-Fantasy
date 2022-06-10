import 'package:lucha_fantasy/core/services/parse_service.dart';
import 'package:lucha_fantasy/features/my_team/data/model/my_team.dart';
import 'package:lucha_fantasy/features/my_team/data/repository/my_team_repo.dart';

class MyTeamRepoImpl implements MyTeamRepo {

  final ParseService _parseService;

  MyTeamRepoImpl(this._parseService);

  @override
  Future<MyTeam?> getMyTeam(String userId) {
    return _parseService.getMyTeamFromParse(userId: userId);
  }
}