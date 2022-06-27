import 'package:flutter/material.dart';
import 'package:lucha_fantasy/core/injection.dart' as di;
import 'package:lucha_fantasy/core/theme_manager.dart';
import 'package:provider/provider.dart';

import 'core/config_reader.dart';
import 'my_app.dart';

Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();

  await ConfigReader.initialize();
  await di.init();

  return runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}
