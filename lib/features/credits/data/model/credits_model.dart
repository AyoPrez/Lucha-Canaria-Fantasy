import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

@JsonSerializable()
class CreditsModel extends Equatable{

  String id;
  String name;
  int price;
  int value;
  String picture;

  CreditsModel(this.id, this.name, this.price, this.value, this.picture);

  @override
  List<Object?> get props => [id, name, price, value, picture];

  List<CreditsModel> parseParseObject(List<ParseObject> result) {
    final List<CreditsModel> credits = [];
    for(ParseObject object in result) {
      final String id = object.objectId!;
      final String name = object.get('Name');
      final int price = object.get('Price');
      final int value = object.get('Value');
      final String picture = object.get('Picture');

      final CreditsModel model = CreditsModel(id, name, price, value, picture);
      credits.add(model);
    }

    return credits;
  }

  static Future<List<CreditsModel>> fromParseResult(List<ParseObject> result) async {
    final List<CreditsModel> credits = [];
    for(ParseObject object in result) {
      final String id = object.objectId!;
      final String name = object.get('Name');
      final int price = object.get('Price');
      final int value = object.get('Value');
      final String picture = object.get('Picture')['url'];
      print("Picture: ${object.get('Picture')['url']}");

     final CreditsModel model = CreditsModel(id, name, price, value, picture);
      credits.add(model);
    }

    return credits;
  }
}