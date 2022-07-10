import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lucha_fantasy/core/injection.dart';
import 'package:lucha_fantasy/core/responsive/dimens.dart';
import 'package:lucha_fantasy/core/services/exceptions/empty_fields_exception.dart';
import 'package:lucha_fantasy/core/services/exceptions/fail_login_exception.dart';
import 'package:lucha_fantasy/core/theme_manager.dart';
import 'package:lucha_fantasy/features/auth/presenter/auth_presenter.dart';
import 'package:lucha_fantasy/features/auth/ui/login_view.dart';
import 'package:lucha_fantasy/features/auth/widgets/app_bar.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> implements LoginView {
  final AuthPresenter presenter = locator.get<AuthPresenter>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  late BuildContext context;

  @override
  Widget build(BuildContext buildContext) {
    context = buildContext;
    presenter.setLoginView(this);

    //TODO Remove this
    usernameController.text = "a@a.com";
    passwordController.text = "asdf1234";

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
                                AutoRouter.of(context).pushNamed("recuperar_contraseña");
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
                                    AutoRouter.of(context).pushNamed("/registro");
                                  },
                                  child: Text(AppLocalizations.of(context).register)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: MouseRegion(
                              child: OutlinedButton(
                                  onPressed: () async {
                                    await presenter.loginUser(
                                        usernameController.value.text.trim(),
                                        passwordController.value.text.trim());
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

  @override
  void displayDialog(Exception? exception) {
    String title = "";
    String text = "";

    if(exception == null) {
      title = AppLocalizations.of(context).verificationEmailDialogTitle;
      text = AppLocalizations.of(context).recoverEmailSuccessDescription;
    } else {
      if(exception is FailLoginException) {
        title = AppLocalizations.of(context).errorFailLoginTitle;
        text = AppLocalizations.of(context).errorFailLoginDescription;
      } else if(exception is EmptyFieldsException) {
        title = AppLocalizations.of(context).emptyFieldsTitle;
        text = AppLocalizations.of(context).emptyFieldsDescription;
      } else {
        title = AppLocalizations.of(context).errorUnknownTitle;
        text = AppLocalizations.of(context).errorUnknownDescription;
      }
    }

    // set up the button
    Widget okButton = TextButton(
      child: Text(AppLocalizations.of(context).ok),
      onPressed: () {
        AutoRouter.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
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
  void navigateToMainScreen() {
    // AutoRouter.of(context).replaceNamed("/principal");

    print("Go to create team");
    AutoRouter.of(context).replaceNamed("/create_team");
  }
}
