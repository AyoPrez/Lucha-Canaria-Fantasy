import 'dart:collection';
import 'dart:convert';

import 'package:flutter/services.dart';

abstract class ConfigReader {
  static Map<String, dynamic> _config = HashMap();

  static Future<void> initialize() async {
    final configString = await rootBundle.loadString('config/app_config.json');
    _config = jsonDecode(configString) as Map<String, dynamic>;
  }

  static String getParseAppDevKey() {
    return _config['devAppKey'] as String;
  }
  static String getParseClientDevKey() {
    return _config['devClientKey'] as String;
  }
  static String getParseApiDevKey() {
    return _config['devApiKey'] as String;
  }
  static String getParseAppProdKey() {
    return _config['prodAppKey'] as String;
  }
  static String getParseClientProdKey() {
    return _config['prodClientKey'] as String;
  }
  static String getParseApiProdKey() {
    return _config['prodApiKey'] as String;
  }

}