part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    @Default(true) bool isLoading,
    @Default(null) Failure? failure,
    @Default(0) int? userCount,
    @Default(<UserEntity>[]) List<UserEntity> users,
  }) = _Initial;
}
