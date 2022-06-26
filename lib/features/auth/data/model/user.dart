import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

// part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String email;
  final String username;
  final int balance;

  User({required this.id, required this.email, required this.username, required this.balance});

  @override
  List<Object?> get props => [id, email, username, balance];

  // factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$UserToJson(this);
}