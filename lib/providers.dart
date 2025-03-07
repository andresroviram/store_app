import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/config/routes/cubit/router_manager.dart';
import 'package:store_app/my_app.dart';

import 'config/authenticate/cubit/auth_cubit.dart';

class Providers extends StatelessWidget {
  const Providers({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => ThemeCubit(),
        // ),
        BlocProvider(
          create: (context) => RouterManager(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => AuthCubit()..verifyAccount(),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('es', 'CO')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('en', 'US'),
        child: MyApp(),
      ),
    );
  }
}
