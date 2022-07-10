
import 'package:auto_route/auto_route.dart';
import 'package:lucha_fantasy/core/router/routes.gr.dart';
import 'package:lucha_fantasy/features/auth/data/model/user.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class TeamCreatedGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {

    User? user;

    try {
      user = await ParseUser.currentUser();
    } catch (exception) {
      user = null;
    }

    if(user != null){
      if(user.userTeam != null) {
        resolver.next(true);
      } else {

        print("Else Main screen");
        router.push(MainScreen());
      }
    }else{
      print("Catching login");
      router.push(const Login());
    }
  }
}