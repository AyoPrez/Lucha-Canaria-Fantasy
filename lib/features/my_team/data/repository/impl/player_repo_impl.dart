import 'package:lucha_fantasy/core/services/parse_service.dart';
import 'package:lucha_fantasy/features/my_team/data/model/player.dart';
import 'package:lucha_fantasy/features/my_team/data/repository/player_repo.dart';

class PlayerRepoImpl implements PlayerRepo {

  final ParseService _parseService;

  PlayerRepoImpl(this._parseService);

  @override
  Future<Player?> getPlayer(String id) async {
    // return Player(id: "1", name: "Sara Sanchez Álamo", age: "25", alias: "", picture: "https://upload.wikimedia.org/wikipedia/commons/1/1f/Woman_1.jpg",
    //     points: "265", rank: "52", falls: "16", throws: "95", news: "", price: "35000", team: Team(id: "", name: "", rank: "", picture: "", location: ""));
  }

  @override
  Future<List<Player>> getAllPlayers() async {
    return await _parseService.getAllPlayers();
  }

}