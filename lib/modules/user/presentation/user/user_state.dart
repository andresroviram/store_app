part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    @Default(true) bool isLoading,
    @Default(null) Failure? failure,
    @Default(<UserEntity>[]) List<UserEntity> users,
  }) = _Initial;
}
