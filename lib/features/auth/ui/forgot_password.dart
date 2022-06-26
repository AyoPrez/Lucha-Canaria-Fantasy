import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lucha_fantasy/core/injection.dart';
import 'package:lucha_fantasy/core/responsive/dimens.dart';
import 'package:lucha_fantasy/core/services/exceptions/empty_fields_exception.dart';
import 'package:lucha_fantasy/core/services/exceptions/wrong_email_format_exception.dart';
import 'package:lucha_fantasy/core/theme_manager.dart';
import 'package:lucha_fantasy/features/auth/presenter/auth_presenter.dart';
import 'package:lucha_fantasy/features/auth/ui/forgot_password_view.dart';
import 'package:lucha_fantasy/features/auth/widgets/app_bar.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> implements ForgotPasswordView {
  final AuthPresenter presenter = locator.get<AuthPresenter>();
  final emailController = TextEditingController();

  @override
  late BuildContext context;


  @override
  Widget build(BuildContext buildContext) {
    context = buildContext;
    presenter.setForgotPasswordView(this);

    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) =>
          Scaffold(
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
                                hintText: AppLocalizations
                                    .of(context)
                                    .email),
                          ),
                        ),
                      ),
                      Wrap(children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: MouseRegion(
                            child: OutlinedButton(
                                onPressed: () {
                                  presenter.forgotPassword(emailController.value.text.trim());
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

  @override
  void displayDialog(Exception? exception) {
    String title = "";
    String text = "";
    Function() buttonOnClick;

    if(exception == null) {
      title = AppLocalizations.of(context).recoverEmailSuccessTitle;
      text = AppLocalizations.of(context).recoverEmailSuccessDescription;
      buttonOnClick = () { AutoRouter.of(context).replaceNamed("iniciar"); };
    } else {
      if(exception is EmptyFieldsException) {
        title = AppLocalizations
            .of(context)
            .emptyFieldsTitle;
        text = AppLocalizations
            .of(context)
            .emptyFieldsDescription;
        buttonOnClick = () {
          AutoRouter.of(context).pop();
        };
      } else if (exception is WrongEmailFormatException) {
        title = AppLocalizations.of(context).errorWrongEmailFormatTitle;
        text = AppLocalizations.of(context).errorWrongEmailFormatDescription;
        buttonOnClick = () {
          AutoRouter.of(context).pop();
        };
      } else {
        title = AppLocalizations.of(context).errorUnknownTitle;
        text = AppLocalizations.of(context).errorUnknownDescription;
        buttonOnClick = () { AutoRouter.of(context).pop(); };
      }
    }

    // set up the button
    Widget okButton = TextButton(
      onPressed: buttonOnClick,
      child: Text(AppLocalizations
          .of(context)
          .ok),
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
}
