import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/config/injectable/injectable_dependency.dart';

import '../../../../config/authenticate/cubit/auth_cubit.dart';
import '../../../../config/routes/cubit/router_manager.dart';
import '../../../home/presentation/view/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const String path = '/login';
  static const String name = 'login';

  static Widget create() => const LoginView();

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late AuthCubit _authCubit;
  final _usernameController = TextEditingController(text: 'admin@gmail.com');
  final _passwordController = TextEditingController(text: '123');
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          bloc: _authCubit,
          buildWhen: (previous, current) =>
              previous.error != current.error ||
              previous.isLoading != current.isLoading ||
              previous.isLoggedIn != current.isLoggedIn,
          listener: (context, state) {
            if (state.isLoggedIn) {
              getIt<RouterManager>().go(HomeView.path);
            }
            if (state.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1),
                  content: Text(
                    state.message,
                  ),
                  backgroundColor: Theme.of(context).hintColor,
                ),
              );
              _authCubit.invalidate();
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.sizeOf(context).height,
                padding: const EdgeInsets.all(20),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/img/logo.png',
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 80),
                        TextFormField(
                          controller: _usernameController,
                          forceErrorText: _authCubit.state.errorEmail,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            labelText: 'username'.tr(),
                          ),
                          validator: _authCubit.validateEmail,
                          onChanged: (value) {
                            _authCubit.invalidate();
                          },
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                            labelText: 'password'.tr(),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'restore_password'.tr(),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _authCubit.login(
                                      _usernameController.text,
                                      _passwordController.text,
                                    );
                                  }
                                },
                                child: Text(
                                  'login'.tr(),
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.shadow,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        IconButton(
                          icon: Icon(
                            Icons.fingerprint,
                            size: 50,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onPressed: _authCubit.fingerprintLogin,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
