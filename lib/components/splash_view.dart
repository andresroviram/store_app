import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/config/routes/cubit/router_manager.dart';

import '../config/injectable/injectable_dependency.dart';
import '../core/services/local_storage.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const String path = '/splash';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    final isLoggedIn = await getIt<LocalStorage>().getLoggedIn();
    if (!mounted) return;
    if (!isLoggedIn) {
      return context.read<RouterManager>().go('/login');
    }
    return context.read<RouterManager>().go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
