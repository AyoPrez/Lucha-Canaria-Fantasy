import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lucha_fantasy/features/my_team/data/model/player.dart';

@JsonSerializable()
class MyTeam extends Equatable {
  final String id;
  final String name;
  final String rank;
  final String picture;
  final List<Player> players;

  const MyTeam({required this.id, required this.name, required this.rank, required this.picture,
    required this.players});

  @override
  List<Object?> get props => [id, name, rank, picture, players];
}