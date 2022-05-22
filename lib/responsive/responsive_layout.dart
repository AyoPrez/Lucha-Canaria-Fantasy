import 'package:flutter/material.dart';
import 'package:lucha_fantasy/responsive/dimens.dart';

class ResponsiveLayout extends StatelessWidget {

  final Widget mobileBody;
  final Widget tabletBody;
  final Widget desktopBody;

  ResponsiveLayout({required this.mobileBody, required this.desktopBody, required this.tabletBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          if(constraints.maxWidth < mobileWidth) {
            return mobileBody;
          } else if (constraints.maxWidth > mobileWidth && constraints.maxWidth < tabletWidth) {
            return tabletBody;
          } else {
            return desktopBody;
          }
        }
    );
  }
}
