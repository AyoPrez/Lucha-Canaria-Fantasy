import 'package:lucha_fantasy/features/my_team/data/model/my_team.dart';

abstract class MyTeamRepo {
  Future<MyTeam?> getMyTeam(String userId);
}