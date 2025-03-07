import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/const/constant.dart';
import 'presentation/view/detail/detail_view.dart';
import 'presentation/view/home_view.dart';

final _homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');

StatefulShellBranch homeRoutes = StatefulShellBranch(
  navigatorKey: _homeNavigatorKey,
  routes: [
    GoRoute(
      path: HomeView.path,
      name: HomeView.name,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: HomeView.create(),
      ),
      routes: [
        if (Constant.isWeb)
          GoRoute(
            path: DetailView.path.substring(1),
            name: DetailView.name,
            pageBuilder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return MaterialPage(
                key: state.pageKey,
                child: DetailView.create(
                  id: state.pathParameters['id'] as String,
                  heroTag: extra?['heroTag'] as String?,
                ),
              );
            },
          ),
      ],
    ),
  ],
);
