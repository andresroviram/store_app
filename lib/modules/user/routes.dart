import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'presentation/view/user_view.dart';

final _userNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'user');

StatefulShellBranch userRoutes = StatefulShellBranch(
  navigatorKey: _userNavigatorKey,
  routes: [
    GoRoute(
      path: UserView.path,
      name: UserView.name,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: UserView.create(),
      ),
    ),
  ],
);
