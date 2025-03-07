part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(true) bool isLoading,
    @Default([]) List<ProductEntity> products,
    Failure? failure,
  }) = _Initial;
}
