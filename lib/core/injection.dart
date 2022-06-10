import 'package:get_it/get_it.dart';
import 'package:lucha_fantasy/core/services/parse_service.dart';
import 'package:lucha_fantasy/features/auth/data/repository/auth.dart';
import 'package:lucha_fantasy/features/auth/data/repository/impl/auth_impl.dart';
import 'package:lucha_fantasy/features/auth/presenter/auth_presenter.dart';
import 'package:lucha_fantasy/features/my_team/data/repository/impl/my_team_repo_impl.dart';
import 'package:lucha_fantasy/features/my_team/data/repository/impl/player_repo_impl.dart';
import 'package:lucha_fantasy/features/my_team/data/repository/my_team_repo.dart';
import 'package:lucha_fantasy/features/my_team/data/repository/player_repo.dart';
import 'package:lucha_fantasy/features/my_team/presenter/my_team_presenter.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //Parse
  locator.registerLazySingleton(() => ParseService());

  //Auth
  locator.registerLazySingleton<Auth>(() => AuthImpl(locator()));
  locator.registerLazySingleton<AuthPresenter>(() => AuthPresenterImpl(locator()));


  //MyTeam
  locator.registerLazySingleton<PlayerRepo>(() => PlayerRepoImpl(locator()));
  // locator.registerLazySingleton(() => null);
  locator.registerLazySingleton<MyTeamRepo>(() => MyTeamRepoImpl(locator()));
  locator.registerLazySingleton<MyTeamPresenter>(() => MyTeamPresenterImpl(locator(), locator(), locator()));

}

