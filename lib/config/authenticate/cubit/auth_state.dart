part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoggedIn,
    @Default(false) bool error,
    @Default('') String message,
    @Default(null) String? errorEmail,
  }) = _Initial;
}
