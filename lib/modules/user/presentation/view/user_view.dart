import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../config/injectable/injectable_dependency.dart';
import '../../../../core/utils/helpers.dart';
import '../../domain/usecases/user_usecases.dart';
import '../user/user_bloc.dart';
import 'user_mobile.dart';
import 'user_web.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  static const path = '/user';
  static const name = 'User';

  static Widget create() => MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) => UserBloc(
              userUseCase: getIt<UserUseCase>(),
            )..add(UserEvent.getUsers()),
          ),
        ],
        child: const UserView(),
      );

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context).breakpoint;
    OverlayEntry loader = context.read<UserBloc>().loader;
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state.failure != null) {
              ShowFailure.instance.mapFailuresToNotification(
                context,
                failure: state.failure!,
              );
              context.read<UserBloc>().add(const UserEvent.invalidate());
            }

            if ((state.userCount ?? 0) > 0) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'El total de usuarios es:',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${state.userCount ?? 0}',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            if (state.isLoading) {
              Overlay.of(context).insert(loader);
            } else {
              if (loader.mounted) loader.remove();
            }
          },
          child: switch (breakpoint.name) {
            MOBILE => const UserMobile(),
            (_) => const UserWeb(),
          },
        ),
      ),
    );
  }
}
