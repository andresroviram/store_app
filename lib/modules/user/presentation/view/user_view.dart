import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../config/injectable/injectable_dependency.dart';
import '../../../../core/utils/helpers.dart';
import '../../domain/usecases/user_usecases.dart';
import '../user/user_bloc.dart';
import 'user_mobile.dart';
import 'user_web.dart';

class UserView extends StatefulWidget {
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
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<UserBloc>().state;
      if ((state.userCount ?? 0) > 0) {
        _showUserCountDialog(context, state.userCount ?? 0);
      }
    });
  }

  void _showUserCountDialog(BuildContext context, int? userCount) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          contentPadding: EdgeInsets.only(
            bottom: 6,
            left: 20,
            right: 20,
            top: 20,
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'the_total_users'.tr(),
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                '$userCount',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  context.pop();
                },
                child: Text('Cerrar'),
              ),
            ),
          ],
        );
      },
    );
  }

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
              _showUserCountDialog(context, state.userCount);
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
