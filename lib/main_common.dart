import 'package:flutter/material.dart';
import 'package:lucha_fantasy/core/injection.dart';
import 'package:lucha_fantasy/core/theme_manager.dart';
import 'package:provider/provider.dart';

import 'core/config_reader.dart';
import 'my_app.dart';

Future<void> mainCommon(String env) async {

  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  await ConfigReader.initialize();

  // switch(env) {
  //   case Environment.dev:
  //     await di.init(ConfigReader.getParseAppDevKey(), ConfigReader.getParseClientDevKey(), ConfigReader.getParseApiDevKey(), true);
  //     break;
  //   case Environment.prod:
  //     await di.init(ConfigReader.getParseAppProdKey(), ConfigReader.getParseClientProdKey(), ConfigReader.getParseApiProdKey(), false);
  //     break;
  // }

    return runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(),
        child: const MyApp(),
      ),
    );
}