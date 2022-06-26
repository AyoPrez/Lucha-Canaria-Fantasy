import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lucha_fantasy/core/injection.dart';
import 'package:lucha_fantasy/features/splash_screen/presenter/splash_screen_presenter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashScreenPresenter presenter = locator.get<SplashScreenPresenter>();

  @override
  Widget build(BuildContext context) {

    print("---------------Build--------");
/*
    return FutureBuilder(
      future: presenter.isUserSessionActive(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if(snapshot.data!) {
            Navigator.pushNamed(context, '/principal');
          } else {
            Navigator.pushNamed(context, '/iniciar');
          }
          return const Text(
              "Splash Screen..."
          );
        } else if (snapshot.hasError){
          Navigator.pushNamed(context, '/iniciar');
          return Text(
            AppLocalizations
                .of(context)
                .errorUnknownDescription, //Add here better description error
            style: const TextStyle(fontSize: 20, color: Colors.red),
          );
        } else {
          return const Text(
              "Splash Screen..."
          );
        }
      }
    );


    var userSessionActive = presenter.isUserSessionActive();

    userSessionActive.then((value) => {
      if(value) {
        Navigator.pushNamed(context, '/principal')
      } else {
        Navigator.pushNamed(context, '/iniciar')
      }
    });
*/
    Future.delayed(const Duration(milliseconds: 2000), () {
      AutoRouter.of(context).replaceNamed('/iniciar');
    });
    return const Text(
      "Splash Screen..."
    );
  }
}
