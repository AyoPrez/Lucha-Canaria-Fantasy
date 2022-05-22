import 'package:flutter/material.dart';
import 'package:lucha_fantasy/theme_manager.dart';

class SimpleAppBar extends StatelessWidget with PreferredSizeWidget {

  final ThemeNotifier theme;

  SimpleAppBar({required this.theme});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Lucha Canaria fantasy"),
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: MouseRegion(
            child: IconButton(
              onPressed: () {
                if (theme.getTheme() == theme.lightTheme) {
                  theme.setDarkMode();
                } else {
                  theme.setLightMode();
                }
              },
              icon: Icon(
                theme.getTheme() == theme.lightTheme
                    ? Icons.nightlight
                    : Icons.light,
                size: 26.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}