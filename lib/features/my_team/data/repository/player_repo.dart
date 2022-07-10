import 'package:lucha_fantasy/features/my_team/data/model/player.dart';

abstract class PlayerRepo {
  Future<Player?> getPlayer(String id);
  Future<List<Player>> getAllPlayers();
}