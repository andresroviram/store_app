import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/error.dart';
import '../../../../core/utils/helpers.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/user_usecases.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUseCase _userUseCase;
  late OverlayEntry loader;
  UserBloc({
    required UserUseCase userUseCase,
  })  : _userUseCase = userUseCase,
        super(const _Initial()) {
    loader = Overloading.instance.overLayEntry();
    on<_GetUsers>(_getUsers);
    on<_Invalidate>(_invalidate);
  }

  void _invalidate(_Invalidate event, Emitter<UserState> emit) {
    emit(state.copyWith(failure: null));
  }

  void _getUsers(_GetUsers event, Emitter<UserState> emit) async {
    emit(state.copyWith(isLoading: true));
    final either = await _userUseCase.getUsers();
    switch (either) {
      case Left(value: Failure failure):
        emit(state.copyWith(
          failure: failure,
          isLoading: false,
        ));
      case Right(value: List<UserEntity> users):
        emit(state.copyWith(
          users: users,
          isLoading: false,
        ));
    }
  }
}
