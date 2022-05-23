import 'package:flutter/foundation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../core/config_reader.dart';

class ParseService {
  static String keyParseServerUrl = 'https://parseapi.back4app.com';

  static Future<ParseService> init() async {
    await ConfigReader.initialize();

    if(kReleaseMode) {
      await Parse().initialize(ConfigReader.getParseAppProdKey(), keyParseServerUrl, clientKey: ConfigReader.getParseClientProdKey(), debug: true);
    } else {
      await Parse().initialize(
          ConfigReader.getParseAppDevKey(), keyParseServerUrl,
          clientKey: ConfigReader.getParseClientDevKey(), debug: true);
    }

    return ParseService();
  }
}
