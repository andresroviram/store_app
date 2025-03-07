import 'package:flutter/material.dart';
import 'package:store_app/core/utils/extension/extension.dart';
import 'package:store_app/modules/user/domain/entities/entities.dart';

class ClientCard extends StatelessWidget {
  const ClientCard({
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      shadowColor: Theme.of(context).focusColor.withValues(alpha: 0.05),
      color: context.colorScheme.primary.withValues(alpha: 0.1),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        leading: CircleAvatar(
          radius: 24,
          child: Text(user.name?.firstname?[0] ?? ''),
        ),
        title: Text(
          '${user.name?.firstname} ${user.name?.lastname}',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '@${user.username}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              user.email ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              '${user.address?.street}, ${user.address?.city}, ${user.address?.number}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              user.phone ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
