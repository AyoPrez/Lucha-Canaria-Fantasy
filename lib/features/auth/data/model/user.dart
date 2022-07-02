import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

// part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String id;
  final String email;
  final String username;
  final int balance;

  User({required this.id, required this.email, required this.username, required this.balance});

  static Future<User> fromParseUser(ParseUser result) async {
      final String id = result.objectId!;
      final String name = result.get('username');
      final String email = result.get('email');
      final int balance = result.get('balance');

      final User model = User(id: id, email: email, username: name, balance: balance);

      return model;
  }

  static Future<User> fromJson(Map<String, dynamic> result) async {
      final String id = result['objectId']!;
      final String name = result['username'];
      final int balance = result['balance'];

      final User model = User(id: id, email: "", username: name, balance: balance);

      return model;
  }

  @override
  List<Object?> get props => [id, email, username, balance];

  // factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$UserToJson(this);
}