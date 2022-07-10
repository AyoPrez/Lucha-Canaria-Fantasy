import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lucha_fantasy/core/injection.dart';
import 'package:lucha_fantasy/core/services/exceptions/no_user_exception.dart';
import 'package:lucha_fantasy/core/services/exceptions/no_user_team_exception.dart';
import 'package:lucha_fantasy/features/my_team/data/model/my_team.dart';
import 'package:lucha_fantasy/features/my_team/data/model/player.dart';
import 'package:lucha_fantasy/features/my_team/presenter/my_team_presenter.dart';
import 'package:lucha_fantasy/features/my_team/ui/my_team_view.dart';

class MyTeamDesktopBody extends StatefulWidget {
  const MyTeamDesktopBody({Key? key}) : super(key: key);

  @override
  State<MyTeamDesktopBody> createState() => _MyTeamDesktopBodyState();
}

class _MyTeamDesktopBodyState extends State<MyTeamDesktopBody> implements MyTeamView {
  final MyTeamPresenter presenter = locator.get<MyTeamPresenter>();
  late Size mediaQuerySize;
  late Player? playerToDisplayProfile;

  bool isPlayerProfileDisplayed = false;
  bool isLoadingDisplayed = false;

  @override
  Widget build(BuildContext context) {
    mediaQuerySize = MediaQuery.of(context).size;

    presenter.setMyTeamView(this);

    return Scaffold(
      backgroundColor: Colors.green,
      body: isPlayerProfileDisplayed ? playerProfile() : isLoadingDisplayed ? loading() : myTeam(),
    );
  }

  Widget myTeam() {
    return FutureBuilder(
        future: presenter.getMyTeam(),
        builder: (BuildContext context, AsyncSnapshot<MyTeam?> snapshot) {
          if(snapshot.hasError) {
            return errorManager(snapshot.error as Exception);
          } else if(snapshot.hasData) {
            if(snapshot.data!.players.isEmpty) {
              return errorManager(NoUserTeamException(""));
            } else {
              return SingleChildScrollView(
                child: DataTable(
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        AppLocalizations
                            .of(context)
                            .player,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        AppLocalizations
                            .of(context)
                            .ranking,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        AppLocalizations
                            .of(context)
                            .points,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        AppLocalizations
                            .of(context)
                            .falls,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        AppLocalizations
                            .of(context)
                            .throws,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        AppLocalizations
                            .of(context)
                            .news,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: createTableRows(snapshot.data!.players),
                ),
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        }
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
            DataCell(
              Center(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 60,
                        height: 60,
                        child: Image.network(players[i].picture),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          presenter.getPlayer(players[i].id);
                        },
                        child: Text(players[i].name, style: TextStyle(color: Colors.white)),)
                  ],
                ),
              ),
            ),
            DataCell(Center(child: Text(players[i].rank))),
            DataCell(Center(child: Text(players[i].points))),
            DataCell(Center(child: Text(players[i].falls))),
            DataCell(Center(child: Text(players[i].throws))),
            DataCell(Center(child: Text(players[i].news))),
          ],
        ),
      );
    }

    return rows;
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
  void displayPlayerProfile(Player player) {
    setState(() {
      isLoadingDisplayed = false;
      isPlayerProfileDisplayed = true;
      playerToDisplayProfile = player;
    });
  }

  Widget playerProfile() {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(playerToDisplayProfile!.name),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              isLoadingDisplayed = false;
              isPlayerProfileDisplayed = false;
              playerToDisplayProfile = null;
            });
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              child: Image.network(playerToDisplayProfile!.picture),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("${AppLocalizations.of(context).name}: ${playerToDisplayProfile!.name}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("${AppLocalizations.of(context).alias}: ${playerToDisplayProfile!.alias}"),
                ),
              ],
            ),
            Text("${AppLocalizations.of(context).team}: ${playerToDisplayProfile!.team?.name}"),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("${AppLocalizations.of(context).throws}: ${playerToDisplayProfile!.throws}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("${AppLocalizations.of(context).falls}: ${playerToDisplayProfile!.falls}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("${AppLocalizations.of(context).points}: ${playerToDisplayProfile!.points}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("${AppLocalizations.of(context).ranking}: ${playerToDisplayProfile!.rank}"),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("${AppLocalizations.of(context).price}: ${playerToDisplayProfile!.price}"),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("${AppLocalizations.of(context).news}: ${playerToDisplayProfile!.news}"),
            ),
          ],
        ),
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
      isPlayerProfileDisplayed = false;
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