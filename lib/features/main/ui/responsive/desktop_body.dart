import 'dart:html';

import 'package:auto_route/auto_route.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lucha_fantasy/core/injection.dart';
import 'package:lucha_fantasy/features/auth/data/model/user.dart';
import 'package:lucha_fantasy/features/credits/ui/responsive/desktop_body.dart';
import 'package:lucha_fantasy/features/main/presenter/main_presenter.dart';
import 'package:lucha_fantasy/features/main/ui/mainView.dart';
import 'package:lucha_fantasy/features/my_team/ui/responsive/desktop_body.dart';


class MainDesktopBody extends StatefulWidget {
  const MainDesktopBody({Key? key}) : super(key: key);

  @override
  State<MainDesktopBody> createState() => _MainDesktopBodyState();
}


class _MainDesktopBodyState extends State<MainDesktopBody> implements MainView {
  final MainPresenter presenter = locator.get<MainPresenter>();

  final PageController page = PageController();
  late Size mediaQuerySize;
  Widget content = Container();


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      initAsync();
    });
  }

  void initAsync() async {
    presenter.setMainView(this);
    await presenter.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    mediaQuerySize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.green,
      body: content,

      /*FutureBuilder<User?>(
        future: presenter.getUserData(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if(snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                sideMenu(context, snapshot.data!.balance.toString()),
                mainContent(snapshot.data!.balance)
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
      ),*/
    );
  }

  Widget sideMenu(BuildContext context, String userBalance){
    List<SideMenuItem> items = [
      SideMenuItem(
        // Priority of item to show on SideMenu, lower value is displayed at the top
        priority: 0,
        title: AppLocalizations.of(context).menuItemMyTeam,
        onTap: () => page.jumpToPage(0),
        icon: Icon(Icons.groups),
      ),
      SideMenuItem(
        // Priority of item to show on SideMenu, lower value is displayed at the top
        priority: 1,
        title: AppLocalizations.of(context).menuItemMyLeague,
        onTap: () => page.jumpToPage(1),
        icon: Icon(Icons.wine_bar_outlined),
      ),
      SideMenuItem(
        // Priority of item to show on SideMenu, lower value is displayed at the top
        priority: 2,
        title: AppLocalizations.of(context).menuItemTransfers,
        onTap: () => page.jumpToPage(2),
        icon: Icon(Icons.compare_arrows),
      ),
      SideMenuItem(
        // Priority of item to show on SideMenu, lower value is displayed at the top
        priority: 3,
        title: AppLocalizations.of(context).menuItemLeaderboard,
        onTap: () => page.jumpToPage(3),
        icon: Icon(Icons.leaderboard),
      ),
      SideMenuItem(
        priority: 4,
        title: AppLocalizations.of(context).menuItemSettings,
        onTap: () => page.jumpToPage(4),
        icon: Icon(Icons.settings),
      ),
      SideMenuItem(
        priority: 5,
        title: AppLocalizations.of(context).logout,
        onTap: () async {
          await presenter.logout();
          AutoRouter.of(context).replaceNamed("/");
        },
        icon: Icon(Icons.exit_to_app),
      ),
    ];

    return Container(
      width: mediaQuerySize.width / 6,
      child: SideMenu(
        controller: page,
        footer: MouseRegion(
          child: TextButton(
            onPressed: () {
              page.jumpToPage(6);
            },
            child: Container(
              height: 40,
              color: Colors.white,
                child: Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${AppLocalizations.of(context).menuItemBalance}: $userBalance",
                              style: const TextStyle(fontSize: 18)
                          ),
                          const WidgetSpan(
                            child: Icon(Icons.monetization_on_outlined, size: 18, color: Colors.purple,),
                          ),

                        ],
                      ),
                    ),
                ),
            ),
          ),
        ),
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                  AppLocalizations.of(context).appName,
                  style: TextStyle(fontSize: 26),
                ),
            ),
            const Divider(
              indent: 8.0,
              endIndent: 8.0,
            ),
          ],
        ),
        onDisplayModeChanged: (mode) {
         print(mode);
        },
        items: items,
        style: SideMenuStyle(
            displayMode: SideMenuDisplayMode.auto,
            decoration: BoxDecoration(),
            openSideMenuWidth: mediaQuerySize.width / 6,
            compactSideMenuWidth: 40,
            hoverColor: Colors.blue[100],
            selectedColor: Colors.lightBlue,
            selectedIconColor: Colors.white,
            unselectedIconColor: Colors.black54,
            backgroundColor: Colors.grey,
            selectedTitleTextStyle: TextStyle(color: Colors.white),
            unselectedTitleTextStyle: TextStyle(color: Colors.black54),
            iconSize: 20,
        ),
      ),
    );
  }

  Widget mainContent(int userBalance) {
    return Expanded(
      child: PageView(
        controller: page,
        children: [
          Container(
            child: MyTeamDesktopBody(),
          ),
          Container(
            child: Center(
              child: Text('My leagues'),
            ),
          ),
          Container(
            child: Center(
              child: Text('Transfers'),
            ),
          ),
          Container(
            child: Center(
              child: Text('Leaderboard'),
            ),
          ),
          Container(
            child: Center(
              child: Text('Settings'),
            ),
          ),
          Container(),
          Container(
            child: CreditsDesktopBody(userBalance: userBalance,),
          ),
        ],
      ),
    );
  }

  @override
  void displayError(Exception exception) {
    setState((){



      content = Text(
        AppLocalizations.of(context).errorUnknownDescription, //Add here better description error
        style: const TextStyle(fontSize: 20, color: Colors.red),
      );
    });
  }

  @override
  void displayLoading() {
    setState((){
      content = const Center(
        child: SizedBox(
          width: 120,
          height: 120,
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  @override
  void displayPlayerProfile(User? user) {
    setState((){
      content = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          sideMenu(context, user!.balance.toString()),
          mainContent(user.balance)
        ],
      );
    });
  }
}