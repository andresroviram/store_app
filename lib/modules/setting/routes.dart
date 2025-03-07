import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'presentation/view/setting_view.dart';

final _settingNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'setting');

StatefulShellBranch settingRoutes = StatefulShellBranch(
  navigatorKey: _settingNavigatorKey,
  routes: [
    GoRoute(
      path: SettingView.path,
      name: SettingView.name,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: SettingView.create(),
      ),
    ),
  ],
);
