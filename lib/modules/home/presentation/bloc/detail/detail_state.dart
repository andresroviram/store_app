part of 'detail_bloc.dart';

@freezed
class DetailState with _$DetailState {
  const factory DetailState({
    @Default(false) bool isLoading,
    Failure? failure,
    required ProductEntity product,
    String? id,
  }) = _Initial;

  factory DetailState.initial() => DetailState(product: ProductEntity.empty());
}
