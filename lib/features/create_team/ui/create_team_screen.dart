import 'package:flutter/material.dart';
import 'package:lucha_fantasy/core/responsive/responsive_layout.dart';
import 'package:lucha_fantasy/features/create_team/ui/responsive/desktop_body.dart';
import 'package:lucha_fantasy/features/create_team/ui/responsive/mobile_body.dart';
import 'package:lucha_fantasy/features/create_team/ui/responsive/tablet_body.dart';

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({Key? key}) : super(key: key);

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileBody: const CreateTeamMobileBody(), desktopBody: const CreateTeamDesktopBody(), tabletBody: const CreateTeamTabletBody());
  }
}
