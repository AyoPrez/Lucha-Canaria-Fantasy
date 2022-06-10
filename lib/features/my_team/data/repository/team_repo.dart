import 'package:lucha_fantasy/features/my_team/data/model/team.dart';

abstract class TeamRepo {
  Future<List<Team>> getTeams();
  Future<Team> getTeam(String id);
}