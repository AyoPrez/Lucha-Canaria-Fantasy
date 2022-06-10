import 'package:flutter/material.dart';
import 'package:lucha_fantasy/core/responsive/responsive_layout.dart';
import 'package:lucha_fantasy/features/main/ui/responsive/desktop_body.dart';
import 'package:lucha_fantasy/features/main/ui/responsive/mobile_body.dart';
import 'package:lucha_fantasy/features/main/ui/responsive/tablet_body.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileBody: const MainMobileBody(), desktopBody: MainDesktopBody(userMoneyBalance: 3500,), tabletBody: const MainTabletBody());
  }
}
