import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lucha_fantasy/injection.dart';
import 'package:lucha_fantasy/presenter/auth_presenter.dart';
import 'package:lucha_fantasy/responsive/dimens.dart';
import 'package:lucha_fantasy/ui/widgets/app_bar.dart';
import 'package:provider/provider.dart';

import '../theme_manager.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthPresenter presenter = locator.get<AuthPresenter>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => Scaffold(
        appBar: SimpleAppBar(theme: theme),
        body: Padding(
          padding: const EdgeInsets.all(80.0),
          child: Center(
            child: SizedBox(
              width: formFieldsWidth,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MouseRegion(
                      child: TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.account_box_outlined),
                            hintText: AppLocalizations.of(context).username),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MouseRegion(
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.key),
                            hintText: AppLocalizations.of(context).password),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MouseRegion(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "recuperar_contraseña");
                        },
                        child: Text(AppLocalizations.of(context).forgotPassword),
                      ),
                    ),
                  ),
                  Wrap(children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: MouseRegion(
                        child: OutlinedButton(
                            onPressed: () {
                              usernameController.clear();
                              passwordController.clear();
                              Navigator.pushNamed(context, "/registro");
                            },
                            child: Text(AppLocalizations.of(context).register)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: MouseRegion(
                        child: OutlinedButton(
                            onPressed: () async {
                              var userSignedIn = await presenter.loginUser(
                                  usernameController.value.text,
                                  passwordController.value.text);

                              if (userSignedIn) {
                                Navigator.pushNamed(context, "/principal");
                              } else {
                                showAlertDialog(context);
                              }
                            },
                            child: Text(AppLocalizations.of(context).login)),
                      ),
                    ),
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
