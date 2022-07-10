import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lucha_fantasy/core/injection.dart';
import 'package:lucha_fantasy/core/services/exceptions/no_user_exception.dart';
import 'package:lucha_fantasy/core/services/exceptions/no_user_team_exception.dart';
import 'package:lucha_fantasy/features/auth/data/model/user.dart';
import 'package:lucha_fantasy/features/create_team/presenter/create_team_presenter.dart';
import 'package:lucha_fantasy/features/create_team/ui/create_team_view.dart';
import 'package:lucha_fantasy/features/my_team/data/model/player.dart';

class CreateTeamDesktopBody extends StatefulWidget {
  const CreateTeamDesktopBody({Key? key}) : super(key: key);

  @override
  State<CreateTeamDesktopBody> createState() => _CreateTeamDesktopBodyState();
}

class _CreateTeamDesktopBodyState extends State<CreateTeamDesktopBody> implements CreateTeamView {
  final CreateTeamPresenter presenter = locator.get<CreateTeamPresenter>();
  late Size mediaQuerySize;
  late User user;

  final teamNameController = TextEditingController();

  bool isNameReady = false;
  bool isLoadingDisplayed = false;
  List<Player> players = List.empty();

  @override
  Widget build(BuildContext context) {
    mediaQuerySize = MediaQuery.of(context).size;

    presenter.setCreateTeamView(this);

    return Scaffold(
      backgroundColor: Colors.green,
      body: isLoadingDisplayed ? loading() : isNameReady ? chooseTeamPlayers(user, players) : teamName(),
    );
  }

  Widget errorManager(Exception exception) {
    if(exception is NoUserTeamException) {
      return Container(
        child: Center(
            child: MouseRegion(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                        else
                          return Colors.white; // Use the component's default.
                      },
                    ),
                ),
                onPressed: () {},
                child: Text("Create Team", style: TextStyle(color: Colors.blue),),
              ),
            )
        ),
      );
    } else if(exception is NoUserException) {
      return Center(
        child: Text(
            AppLocalizations.of(context).errorNoUser,
          style: TextStyle(fontSize: 27, color: Colors.redAccent),
        ),
      );
    } else {
      return Center(
          child: Text(
              AppLocalizations.of(context).errorUnknownTitle,
            style: TextStyle(fontSize: 27, color: Colors.redAccent),
          ),
      );
    }
  }

  @override
  void displayAddTeamName(bool isNameReady) {
    setState((){
      this.isNameReady = isNameReady;
    });
  }

  Widget teamName() {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text("Choose a name"),
        centerTitle: true,
        leading: null,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
                "Choose a unique name for your team",
                style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 10),
            child: MouseRegion(
              child: TextField(
                controller: teamNameController,
                decoration: InputDecoration(
                  hintText: "Team name"
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: OutlinedButton(
                onPressed: (){
                  presenter.checkName(teamNameController.text.trim());
                },
                child: const Text("Set name")
            ),
          )
        ],
      ),
    );
  }

  @override
  void displayChooseTeamPlayers(User? user, List<Player> playersList) {
    setState((){
      isNameReady = true;
      players = playersList;
      this.user = user!;
    });
  }

  Widget chooseTeamPlayers(User user, List<Player> players) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text("Choose your team"),
        centerTitle: true,
        leading: null,
      ),
      body: Column(
        children: [
          Center(child:
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("You have ${user.balance} credits to spend in players"),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: _playersTable(players),
          ),
        ],
      ),
    );
  }

  Widget _playersTable(List<Player> playersList) {
    return SingleChildScrollView(
      child: DataTable(
        dividerThickness: 0.5,
        columns: <DataColumn>[
          _emptyDataColumn(),
          _tableHeaderTextElement(AppLocalizations.of(context).name),
          _tableHeaderTextElement("Age"),
          _tableHeaderTextElement(AppLocalizations.of(context).price),
          _emptyDataColumn(),
        ],
        rows: createTableRows(playersList),
      ),
    );
  }

  List<DataRow> createTableRows(List<Player>? players) {
    final List<DataRow> rows = [];
    if(players == null) {
      return [];
    }

    for (int i = 0; i < players.length; ++i) {
      rows.add(
        DataRow(
          cells: <DataCell>[
            _listElement(Image.network(players[i].picture, width: 60, height: 60)),
            _listTextElement(players[i].name),
            _listTextElement(players[i].age),
            _listTextElement(players[i].price),
            _listElement(OutlinedButton(onPressed: (){
              //TODO When clicking in a player button to acquire it, a dialog should be open asking the user if he/she wants to acquire the player
              //TODO for the quantity required (if the user has not credits enough, the dialog should be an error dialog telling that he cannot buy that players)
            }, child: Text("Acquire player")))
          ],
        ),
      );
    }

    return rows;
  }

  DataCell _listElement(Widget widget) {
    return DataCell(
      Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: widget,
        ),
      )
    );
  }

  DataCell _listTextElement(String text) {
    return DataCell(
        Text(
            text,
            style: const TextStyle(fontSize: 20),
        )
    );
  }

  DataColumn _emptyDataColumn() {
    return const DataColumn(label: Text(""));
  }

  DataColumn _tableHeaderTextElement(String text) {
    return DataColumn(
      label: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  void displayError(Exception? exception) {
    String title = "";
    String text = "";

    if (exception == null) {
      title = AppLocalizations.of(context).errorUnknownTitle;
      text = AppLocalizations.of(context).errorUnknownDescription;
    } else {
      title = AppLocalizations.of(context).errorLoadingPlayerProfileTitle;
      text = AppLocalizations.of(context).errorLoadingPlayerProfileDescription;
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
  void displayLoading() {
    setState((){
      isLoadingDisplayed = true;
    });
  }

  Widget loading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}