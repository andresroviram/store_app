import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/circular_loading.dart';
import '../../config/routes/cubit/router_manager.dart';
import '../../modules/login/presentation/view/login_view.dart';
import '../error/error.dart';
import 'notifications.dart';

class Helper {
  BuildContext? context;
  DateTime? currentBackPressTime;

  Helper.of(this.context);

  static List<Icon> getStarsList(double rate, {double size = 14}) {
    var list = <Icon>[];
    list = List.generate(rate.floor(), (index) {
      return Icon(Icons.star, size: size, color: const Color(0xFFFFB24D));
    });
    if (rate - rate.floor() > 0) {
      list.add(
          Icon(Icons.star_half, size: size, color: const Color(0xFFFFB24D)));
    }
    list.addAll(
        List.generate(5 - rate.floor() - (rate - rate.floor()).ceil(), (index) {
      return Icon(Icons.star,
          size: size, color: Colors.grey.withValues(alpha: .5));
    }));
    return list;
  }
}

class Overloading {
  Overloading._();
  static final Overloading instance = Overloading._();
  OverlayEntry overLayEntry() {
    return OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Positioned(
        height: size.height,
        width: size.width,
        child: Material(
          color: Theme.of(context).hintColor.withValues(alpha: 0.1),
          child: const CircularLoadingWidget(height: 200),
        ),
      );
    });
  }
}

class ShowFailure {
  ShowFailure._();
  static final ShowFailure instance = ShowFailure._();

  void mapFailuresToNotification(
    BuildContext context, {
    required Failure failure,
    bool validSession = true,
  }) {
    switch (failure.runtimeType) {
      case const (NetworkFailure):
        AppNotification.showNotification(
          context,
          title: 'Revisa tu conexión a internet',
        );
        break;
      case const (TimeOutFailure):
        AppNotification.showNotification(
          context,
          title: 'No pudimos comunicarnos con el servidor',
        );
        break;
      case const (AuthFailure):
        AppNotification.showNotification(
          context,
          title: 'Datos incorrectos o su token expiro',
        );
        if (validSession) {
          context.read<RouterManager>().go(LoginView.path);
        }
        break;
      case const (AnotherFailure):
      default:
        AppNotification.showNotification(context, title: 'A ocurrido un error');
    }
  }
}
