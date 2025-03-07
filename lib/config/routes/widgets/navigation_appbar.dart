import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:store_app/config/routes/cubit/router_manager.dart';
import 'package:store_app/modules/login/presentation/view/login_view.dart';

import '../../../components/theme_button.dart';
import '../../authenticate/cubit/auth_cubit.dart';
import 'navigation_title.dart';

class NavigationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NavigationAppBar({super.key, this.scaffoldDrawerKey});
  final GlobalKey<ScaffoldState>? scaffoldDrawerKey;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    return AppBar(
      forceMaterialTransparency: true,
      shape: LinearBorder.bottom(
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: const NavigationTitle(),
      leadingWidth: responsive.isDesktop ? 81 : null,
      leading: Container(
        padding: EdgeInsets.symmetric(
            horizontal: responsive.isDesktop ? 19 : 8, vertical: 8),
        child: IconButton(
          color: Colors.black,
          onPressed: () {
            // if (scaffoldDrawerKey?.currentState?.isDrawerOpen ?? false) {
            //   scaffoldDrawerKey?.currentState?.closeDrawer();
            // } else {
            scaffoldDrawerKey?.currentState?.openDrawer();
            // }
          },
          icon: Container(
            // height: 40,
            // width: 40,
            // decoration: BoxDecoration(
            //   shape: BoxShape.circle,
            //   color: Theme.of(context).colorScheme.background,
            // ),
            alignment: Alignment.center,
            child: Icon(
              Icons.menu,
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
      ),
      centerTitle: true,
      actions: [
        const ThemeModeButton.icon(),
        PopupMenuButton<int>(
          icon: const Icon(Icons.account_circle_outlined),
          tooltip: 'profile'.tr(),
          offset: const Offset(0, 45),
          padding: EdgeInsets.zero,
          onSelected: (value) {
            if (value == 0) {
              context.read<AuthCubit>().logout();
              context.read<RouterManager>().go(LoginView.path);
            }
          },
          itemBuilder: (_) => [
            PopupMenuItem(
              value: 0,
              child: Row(
                children: [
                  const Icon(
                    Icons.logout,
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  Text('logout'.tr()),
                ],
              ),
              onTap: () {
                // Sign out logic
              },
            ),
          ],
        ),
        const Gap(2),
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
