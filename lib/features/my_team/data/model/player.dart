import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lucha_fantasy/features/my_team/data/model/team.dart';

@JsonSerializable()
class Player extends Equatable {
  final String id;
  final String name;
  final String alias;
  final String rank;
  final String picture;
  final String points;
  final String falls;
  final String throws;
  final String news;
  final String price;
  final Team team;

  const Player({required this.id, required this.name, required this.alias, required this.rank, required this.picture,
    required this.points, required this.falls, required this.throws, required this.news,
    required this.price, required this.team});

  @override
  List<Object?> get props => [id, name, alias, rank, picture, points, falls, throws, news, price, team];
}