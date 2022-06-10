import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Team extends Equatable {
  final String id;
  final String name;
  final String rank;
  final String picture;
  final String location;

  const Team({required this.id, required this.name, required this.rank, required this.picture,
  required this.location});

  @override
  List<Object?> get props => [id, name, rank, picture, location];

// factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
//
// Map<String, dynamic> toJson() => _$UserToJson(this);
}