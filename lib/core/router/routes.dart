import 'package:auto_route/annotations.dart';
import 'package:lucha_fantasy/core/router/auth_guard.dart';
import 'package:lucha_fantasy/core/router/no_auth_guard.dart';
import 'package:lucha_fantasy/features/auth/ui/create_account.dart';
import 'package:lucha_fantasy/features/auth/ui/forgot_password.dart';
import 'package:lucha_fantasy/features/auth/ui/login.dart';
import 'package:lucha_fantasy/features/create_team/ui/create_team_screen.dart';
import 'package:lucha_fantasy/features/main/ui/MainScreen.dart';
import 'package:lucha_fantasy/features/splash_screen/ui/SplashScreen.dart';


@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: SplashScreen, initial: true),
    AutoRoute(path: '/iniciar', page: Login, guards: [NoAuthGuard]),
    AutoRoute(path: '/recuperar_contraseña', page: ForgotPassword, guards: [NoAuthGuard]),
    AutoRoute(path: '/registro', page: CreateAccount, guards: [NoAuthGuard]),
    AutoRoute(path: '/principal', page: MainScreen, children: [], guards: [AuthGuard]),
    AutoRoute(path: '/create_team', page: CreateTeamScreen, children: []),// guards: [AuthGuard, TeamCreatedGuard]),
  ],
)
class $AppRouter {}