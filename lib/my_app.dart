import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lucha_fantasy/core/router/auth_guard.dart';
import 'package:lucha_fantasy/core/router/no_auth_guard.dart';
import 'package:lucha_fantasy/core/router/routes.gr.dart';
import 'package:lucha_fantasy/core/theme_manager.dart';
import 'package:provider/provider.dart';


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final _appRouter = AppRouter(authGuard: AuthGuard(), noAuthGuard: NoAuthGuard());

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "Lucha Canaria Fantasy",
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('es', ''),
        ],
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        theme: theme.getTheme(),
      ),
    );
  }
}
