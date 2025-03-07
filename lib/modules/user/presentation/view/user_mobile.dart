import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../user/user_bloc.dart';
import '../widgets/user_list.dart';

class UserMobile extends StatelessWidget {
  const UserMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((UserBloc bloc) => bloc.state.isLoading);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text(
              'user_list'.tr(),
              textAlign: TextAlign.left,
            ),
          ),
          isLoading
              ? Expanded(child: const SizedBox.shrink())
              : const UserListWidget(),
        ],
      ),
    );
  }
}
