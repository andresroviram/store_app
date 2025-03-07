import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/user_list.dart';

class UserMobile extends StatelessWidget {
  const UserMobile({super.key});

  @override
  Widget build(BuildContext context) {
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
          const UserListWidget(),
        ],
      ),
    );
  }
}
