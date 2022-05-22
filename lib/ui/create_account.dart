import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lucha_fantasy/responsive/dimens.dart';
import 'package:lucha_fantasy/theme_manager.dart';
import 'package:lucha_fantasy/ui/widgets/app_bar.dart';
import 'package:provider/provider.dart';

import '../injection.dart';
import '../presenter/auth_presenter.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final AuthPresenter presenter = locator.get<AuthPresenter>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

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
                        controller: emailController,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.mail),
                            hintText: AppLocalizations.of(context).email),
                      ),
                    ),
                  ),
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
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: passwordController,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.key),
                            hintText: AppLocalizations.of(context).password),
                      ),
                    ),
                  ),
                  Wrap(children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: MouseRegion(
                        child: OutlinedButton(
                            onPressed: () async {
                              var userSignedUp = await presenter.signupUser(
                                  emailController.value.text,
                                  usernameController.value.text,
                                  passwordController.value.text);

                              if(userSignedUp) {
                                Navigator.pushNamed(context, "/iniciar");
                              } else {
                                showAlertDialog(context);
                              }
                            },
                            child: Text(AppLocalizations.of(context).createAccount),
                        ),
                      ),
                    ),
                  ]),
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
