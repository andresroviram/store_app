import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../core/services/local_storage.dart';
import '../../injectable/injectable_dependency.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@singleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(_Initial());

  Future<void> verifyAccount() async {
    final isLoggedIn = await getIt<LocalStorage>().getLoggedIn();
    emit(state.copyWith(isLoggedIn: isLoggedIn));
  }

  Future<void> login(String username, String password) async {
    emit(state.copyWith(isLoading: true, errorEmail: null));
    await Future.delayed(const Duration(seconds: 1));
    if (username == 'admin@gmail.com' && password == '123') {
      await getIt<LocalStorage>().setLoggedIn(true);
      emit(state.copyWith(
        isLoading: false,
        isLoggedIn: true,
        errorEmail: null,
      ));
    } else {
      emit(
        state.copyWith(
          isLoading: false,
          error: true,
          message: 'Usuario o contraseña incorrectos',
        ),
      );
    }
  }

  Future<void> logout() async {
    await getIt<LocalStorage>().setLoggedIn(false);
    emit(_Initial());
  }

  void invalidate() {
    emit(state.copyWith(
      error: false,
      message: '',
      errorEmail: null,
    ));
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese un correo electrónico';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor ingrese un correo electrónico válido';
    }
    return null;
  }

  void fingerprintLogin() {
    // Código para iniciar sesión con huella
  }
}
