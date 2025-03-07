import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  static const path = '/user';
  static const name = 'User';

  static Widget create() => const UserView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'user_list'.tr(),
        ),
      ),
      body: const Center(
        child: Text('User View'),
      ),
    );
  }
}
