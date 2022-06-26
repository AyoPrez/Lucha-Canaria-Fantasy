import 'package:auto_route/auto_route.dart';
import 'package:lucha_fantasy/core/router/routes.gr.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class NoAuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final user = await ParseUser.currentUser();

    if(user == null){
      resolver.next(true);
    }else{
      router.push(MainScreen());
    }
  }
}