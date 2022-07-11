import 'package:lucha_fantasy/core/services/parse_service.dart';
import 'package:lucha_fantasy/features/create_team/data/repository/create_team_repo.dart';

class CreateTeamRepoImpl implements CreateTeamRepo {

  final ParseService _parseService;

  CreateTeamRepoImpl(this._parseService);

  @override
  Future<bool> checkTeamName(String teamName) {
    return _parseService.checkUniqueTeamName(teamName);
  }

}