import 'package:flutter/foundation.dart';
import 'package:lucha_fantasy/core/config_reader.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ParseService {
  static String keyParseServerUrl = 'https://parseapi.back4app.com';

  ParseService() {
    init();
  }

  Future<void> init() async {
    ConfigReader.initialize();

    if(kReleaseMode) {
      Parse().initialize(ConfigReader.getParseAppProdKey(), keyParseServerUrl, clientKey: ConfigReader.getParseClientProdKey(), debug: true);
    } else {
      Parse().initialize(
          ConfigReader.getParseAppDevKey(), keyParseServerUrl,
          clientKey: ConfigReader.getParseClientDevKey(), debug: true);
    }
  }
}
