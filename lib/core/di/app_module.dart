import 'package:injectable/injectable.dart';
import 'package:lucha_fantasy/data/services/parse_service.dart';

@module
abstract class AppModule {

  @injectable
  Future<ParseService> get parseService => ParseService.init();
}
