import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/modules/home/presentation/view/home_view.dart';

import '../../authenticate/cubit/auth_cubit.dart';
import '../../../components/splash_view.dart';
import '../../../modules/home/routes.dart';
import '../../../modules/login/presentation/view/login_view.dart';
import '../../../modules/user/routes.dart';
import '../widgets/scaffold_with_navigation.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: kDebugMode,
  initialLocation: SplashView.path,
  observers: [BotToastNavigatorObserver()],
  routes: [
    GoRoute(
      path: SplashView.path,
      name: SplashView.name,
      redirect: (BuildContext context, GoRouterState state) {
        final isLoggedIn = context.read<AuthCubit>().state.isLoggedIn;
        if (!isLoggedIn) {
          return LoginView.path;
        }
        return HomeView.path;
      },
      builder: (context, state) => SplashView(),
    ),
    GoRoute(
      path: LoginView.path,
      name: LoginView.name,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: LoginView.create(),
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return SelectionArea(
          child: ScaffoldWithNavigation(navigationShell: navigationShell),
        );
      },
      branches: [
        homeRoutes,
        userRoutes,
      ],
    ),
  ],
);
