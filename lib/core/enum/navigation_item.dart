import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

enum NavigationItem {
  home(iconData: Icons.dashboard_outlined),
  user(iconData: Icons.person_2_outlined),
  settings(iconData: Icons.settings_outlined),
  ;

  const NavigationItem({required this.iconData});
  final IconData iconData;
  String get label => name.pascalCase;
}
