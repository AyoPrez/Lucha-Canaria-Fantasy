import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lucha_fantasy/core/responsive/dimens.dart';
import 'package:lucha_fantasy/core/services/exceptions/empty_fields_exception.dart';
import 'package:lucha_fantasy/core/services/exceptions/fail_register_exception.dart';
import 'package:lucha_fantasy/core/theme_manager.dart';
import 'package:lucha_fantasy/features/auth/presenter/auth_presenter.dart';
import 'package:lucha_fantasy/features/auth/ui/create_account_view.dart';
import 'package:lucha_fantasy/features/auth/widgets/app_bar.dart';
import 'package:provider/provider.dart';

import '../../../core/injection.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> implements CreateAccountView {
  final AuthPresenter presenter = locator.get<AuthPresenter>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  @override
  late BuildContext context;

  @override
  Widget build(BuildContext buildContext) {
    context = buildContext;
    presenter.setCreateAccountView(this);

    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => Scaffold(
        appBar: SimpleAppBar(theme: theme),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
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
                            await presenter.signupUser(
                                emailController.value.text.trim(),
                                usernameController.value.text.trim(),
                                passwordController.value.text.trim());
                          },
                          child:
                              Text(AppLocalizations.of(context).createAccount),
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

  @override
  void displayDialog(Exception? exception) {
    String title = "";
    String text = "";

    if (exception == null) {
      title = AppLocalizations.of(context).verificationEmailDialogTitle;
      text = AppLocalizations.of(context).recoverEmailSuccessDescription;
    } else {
      if (exception is FailRegisterException) {
        title = AppLocalizations.of(context).errorFailRegisterTitle;
        text = AppLocalizations.of(context).errorFailRegisterDescription;
      } else if (exception is EmptyFieldsException) {
        title = AppLocalizations.of(context).emptyFieldsTitle;
        text = AppLocalizations.of(context).emptyFieldsDescription;
      } else {
        title = AppLocalizations.of(context).errorUnknownTitle;
        text = AppLocalizations.of(context).errorUnknownDescription;
      }
    }

    // set up the button
    final Widget okButton = TextButton(
      child: Text(AppLocalizations.of(context).ok),
      onPressed: () {
        AutoRouter.of(context).pop();
      },
    );

    // set up the AlertDialog
    final AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(text),
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

  @override
  void navigateToLoginScreen() {
    AutoRouter.of(context).replaceNamed("/iniciar");
  }
}
