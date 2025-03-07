import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../config/injectable/injectable_dependency.dart';
import '../bloc/home_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String path = '/';
  static const String name = 'home';

  static Widget create() => BlocProvider(
        lazy: false,
        create: (context) => HomeBloc(
            // homeUseCase: getIt<HomeUseCase>(),
            ),
        // ..add(LoadTrendingMovieList())
        // ..add(const LoadGenResList())
        // ..add(LoadTopRatedMovieList()),
        child: const HomeView(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home View'),
      ),
    );
  }
}
