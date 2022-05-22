import 'package:flutter/material.dart';
import 'package:lucha_fantasy/responsive/responsive_layout.dart';
import 'package:lucha_fantasy/ui/main/responsive/desktop_body.dart';
import 'package:lucha_fantasy/ui/main/responsive/mobile_body.dart';
import 'package:lucha_fantasy/ui/main/responsive/tablet_body.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileBody: const MainMobileBody(), desktopBody: const MainDesktopBody(), tabletBody: const MainTabletBody());
  }
}
