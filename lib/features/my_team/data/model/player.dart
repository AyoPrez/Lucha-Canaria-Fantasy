import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lucha_fantasy/features/my_team/data/model/team.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

@JsonSerializable()
class Player extends Equatable {
  final String id;
  final String name;
  final String age;
  final String? alias;
  final String weight;
  final String height;
  final String rank;
  final String category;
  final String picture;
  final String points;
  final String falls;
  final String throws;
  final String news;
  final String price;
  final Team? team;

  const Player({required this.id, required this.name, required this.age, required this.weight, required this.height,
    required this.alias, required this.rank, required this.category, required this.picture, required this.points,
    required this.falls, required this.throws, required this.news, required this.price, required this.team});

  static Future<List<Player>> fromParseResult(List<ParseObject> result) async {
    final List<Player> players = [];
    for(ParseObject object in result) {
      final String id = object.objectId!;
      final String name = object.get('Name');
      final String age = object.get('Age');
      final String? alias = object.get('Alias');
      final String category = object.get('Category');
      final String rank = object.get('Rank') ?? "";
      final String points = object.get('Points') ?? "";
      final String falls = object.get('Falls') ?? "";
      final String throws = object.get('Throws') ?? "";
      final String news = object.get('News') ?? "";
      final String weight = object.get('Weight') ?? "";
      final String height = object.get('Height') ?? "";
      final int price = object.get('Value');
      final String picture = object.get('Picture')['url'];
      // final Team team = object.get('Team');

      final Player model = Player(id: id, name: name, weight: weight, height: height,
          age: age, alias: alias, rank: rank, category: category, picture: picture,
          points: points, falls: falls, throws: throws, news: news, price: price.toString(),
          team: null);
      players.add(model);
    }

    return players;
  }

  @override
  List<Object?> get props => [id, name, age, alias, rank, category, picture, points, falls, throws, news, price, team];
}