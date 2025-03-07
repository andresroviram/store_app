import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:store_app/modules/home/domain/entities/entities.dart';

import '../../../../../core/error/error.dart';
import '../../../../../core/utils/helpers.dart';
import '../../../domain/usecases/home_usecases.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase _homeUseCase;
  late OverlayEntry loader;
  HomeBloc({
    required HomeUseCase homeUseCase,
  })  : _homeUseCase = homeUseCase,
        super(const _Initial()) {
    loader = Overloading.instance.overLayEntry();
    on<_GetProducts>(_getProducts);
    on<_Invalidate>(_invalidate);
  }

  void _invalidate(_Invalidate event, Emitter<HomeState> emit) {
    emit(state.copyWith(failure: null));
  }

  Future<void> _getProducts(
    _GetProducts event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final either = await _homeUseCase.getProducts();
    switch (either) {
      case Left(value: Failure failure):
        emit(state.copyWith(
          failure: failure,
          isLoading: false,
        ));
      case Right(value: List<ProductEntity> products):
        emit(state.copyWith(
          products: products,
          isLoading: false,
        ));
    }
  }
}
