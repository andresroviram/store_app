import 'package:bloc/bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'router.dart';

@lazySingleton
class RouterManager extends Cubit<GoRouter> {
  RouterManager() : super(router);

  void pop() {
    state.pop();
  }

  void push(String route, {Object? extra}) {
    state.push(route, extra: extra);
  }

  void replace(String route) {
    state.replace(route);
  }

  void go(String route, {Object? extra}) {
    state.go(route, extra: extra);
  }

  void goNamed(
    String route, {
    Map<String, String>? pathParams,
  }) {
    state.goNamed(route, pathParameters: pathParams ?? <String, String>{});
  }
}
