import 'package:get_it/get_it.dart';
import 'package:lucha_fantasy/core/services/parse_service.dart';
import 'package:lucha_fantasy/features/auth/data/repository/auth.dart';
import 'package:lucha_fantasy/features/auth/data/repository/impl/auth_impl.dart';
import 'package:lucha_fantasy/features/auth/presenter/auth_presenter.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //Parse
  locator.registerLazySingleton(() => ParseService());

  locator.registerLazySingleton<Auth>(() => AuthImpl(locator()));
  locator.registerLazySingleton<AuthPresenter>(() => AuthPresenterImpl(locator()));
}

