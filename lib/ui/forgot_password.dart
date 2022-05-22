import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lucha_fantasy/injection.dart';
import 'package:lucha_fantasy/presenter/auth_presenter.dart';
import 'package:lucha_fantasy/responsive/dimens.dart';
import 'package:lucha_fantasy/ui/widgets/app_bar.dart';
import 'package:provider/provider.dart';

import '../theme_manager.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthPresenter presenter = locator.get<AuthPresenter>();
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
                  Wrap(children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: MouseRegion(
                        child: OutlinedButton(
                            onPressed: () {
                              if (emailController.value.text.isEmpty) {
                                showAlertDialog(
                                    context,
                                    AppLocalizations.of(context).emptyEmailFieldTitle,
                                    AppLocalizations.of(context).emptyEmailFieldDescription,
                                        () {Navigator.of(context).pop();});
                              } else {
                                presenter
                                    .forgotPassword(emailController.value.text);
                                showAlertDialog(
                                    context,
                                    AppLocalizations.of(context).recoverEmailSuccessTitle,
                                    AppLocalizations.of(context).recoverEmailSuccessDescription,
                                        () {Navigator.pushNamed(context, "iniciar");});
                              }

                              emailController.clear();
                            },
                            child: Text(AppLocalizations.of(context).recoverPassword)),
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

  showAlertDialog(
      BuildContext context, String title, String message, Function buttonOnClick) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(AppLocalizations.of(context).ok),
      onPressed: () => buttonOnClick,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
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
