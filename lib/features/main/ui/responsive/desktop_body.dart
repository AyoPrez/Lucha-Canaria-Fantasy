import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lucha_fantasy/features/my_team/ui/responsive/desktop_body.dart';

class MainDesktopBody extends StatelessWidget {

  final int userMoneyBalance;

  MainDesktopBody({Key? key, required this.userMoneyBalance}) : super(key: key);

  final PageController page = PageController();
  late Size mediaQuerySize;

  @override
  Widget build(BuildContext context) {
    mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          sideMenu(context),
          mainContent()
        ],
      ),
    );
  }

  Widget sideMenu(BuildContext context){
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
        onTap: () {},
        icon: Icon(Icons.exit_to_app),
      ),
    ];

    return Container(
      width: mediaQuerySize.width / 6,
      child: SideMenu(
        controller: page,
        footer: Container(
          height: 40,
          color: Colors.white,
            child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${AppLocalizations.of(context).menuItemBalance}: $userMoneyBalance",
                          style: TextStyle(fontSize: 22)
                      ),
                      WidgetSpan(
                        child: Icon(Icons.monetization_on_outlined, size: 22, color: Colors.purple,),
                      ),

                    ],
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

  Widget mainContent() {
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
        ],
      ),
    );
  }
}