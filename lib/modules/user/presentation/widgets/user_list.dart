import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/modules/user/presentation/user/user_bloc.dart';

import 'client_card.dart';

class UserListWidget extends StatelessWidget {
  const UserListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final users = context.read<UserBloc>().state.users;
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ClientCard(user: user);
        },
      ),
    );
  }
}
