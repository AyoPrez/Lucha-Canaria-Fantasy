import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lucha_fantasy/core/injection.dart';
import 'package:lucha_fantasy/core/utils/rotate_corner_decoration.dart';
import 'package:lucha_fantasy/features/credits/data/model/credits_model.dart';
import 'package:lucha_fantasy/features/credits/presenter/credits_presenter.dart';
import 'package:lucha_fantasy/features/credits/ui/credits_view.dart';

class CreditsDesktopBody extends StatefulWidget {
  final int userBalance;

  const CreditsDesktopBody({Key? key, required this.userBalance}) : super(key: key);

  @override
  State<CreditsDesktopBody> createState() => _CreditsDesktopBodyState();
}

class _CreditsDesktopBodyState extends State<CreditsDesktopBody> implements CreditsView {
  final CreditsPresenter presenter = locator.get<CreditsPresenter>();
  late Size mediaQuerySize;

  bool isLoadingDisplayed = false;

  @override
  Widget build(BuildContext context) {
    mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green,
      body: isLoadingDisplayed ? loading() : creditsScreen(),
    );
  }

  Widget creditsScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).credits),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<CreditsModel>>(
        future: presenter.getAllCreditAds(),
        builder: (BuildContext context, AsyncSnapshot<List<CreditsModel>> snapshot) {
          if(snapshot.hasData) {
            return Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "${AppLocalizations.of(context).myBalance}: ${widget.userBalance.toString()}",
                              style: const TextStyle(fontSize: 22)
                          ),
                          const WidgetSpan(
                            child: Icon(Icons.monetization_on_outlined, size: 22, color: Colors.purple,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Table(
                      border: TableBorder.all(color: Colors.white, width: 5),
                      columnWidths: createDynamicColumnWidth(snapshot.data!),
                      children: <TableRow>[
                        createTopTableRow(snapshot.data!),
                        createMiddleTableRow(snapshot.data!),
                        createBottomTableRow(snapshot.data!)
                      ],
                    ),
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text(
              AppLocalizations.of(context).errorUnknownDescription, //Add here better description error
              style: const TextStyle(fontSize: 20, color: Colors.red),
            );
          } else {
             return const Center(
               child: SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(),
                ),
             );
          }
        },
      ),
    );
  }

  //region Create table rows dynamically
  Map<int, TableColumnWidth> createDynamicColumnWidth(List<CreditsModel> models) {
    final Map<int, TableColumnWidth> columns = {};

    for (var i = 0; i < models.length; i++) {
      columns[i] = const IntrinsicColumnWidth();
    }

    return columns;
  }

  TableRow createTopTableRow(List<CreditsModel> models) {
    final topCells = <TableCell>[];
    for (var cellData in models) {
      topCells.add(
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                cellData.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      );
    }

    return TableRow(
      children: topCells,
    );
  }

  TableRow createMiddleTableRow(List<CreditsModel> models) {
    final middleCells = <TableCell>[];

    for(var cellData in models) {
      if(cellData.id == models[1].id) {
        middleCells.add(
          TableCell(
            child: Container(
              foregroundDecoration: RotatedCornerDecoration(
                color: Colors.blueGrey,
                geometry: const BadgeGeometry(width: 100, height: 100),
                textSpan: TextSpan(
                  text: AppLocalizations.of(context).recommendedOffer,
                  style: const TextStyle(
                    fontSize: 12,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    shadows: [BoxShadow(color: Colors.white, blurRadius: 4)],
                  ),
                ),
              ),
              child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image.network(cellData.picture),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: cellData.value.toString(),
                                style: const TextStyle(fontSize: 22)
                            ),
                            const WidgetSpan(
                              child: Icon(Icons.monetization_on_outlined, size: 22, color: Colors.purple,),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
              ),
            ),
          ),
        );
      } else {
        middleCells.add(
          TableCell(
            child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.network(cellData.picture),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: cellData.value.toString(),
                            style: const TextStyle(fontSize: 22)
                        ),
                        const WidgetSpan(
                          child: Icon(Icons.monetization_on_outlined, size: 22, color: Colors.purple,),
                        ),
                      ],
                    ),
                  ),
                ]
            ),
          ),
        );
      }

    }

    return TableRow(
      children: middleCells
    );
  }

  TableRow createBottomTableRow(List<CreditsModel> models) {
    final bottomCells = <TableCell>[];

    for(var cellData in models) {
      bottomCells.add(
        TableCell(
            child: Expanded(
              child: TextButton(
                onPressed: (){},
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "${cellData.price}€",
                    style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
      );
    }

    return TableRow(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      children: bottomCells,
    );
  }

  //endregion

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