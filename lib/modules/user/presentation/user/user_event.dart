part of 'user_bloc.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.started() = _Started;
  const factory UserEvent.getUsers() = _GetUsers;
  const factory UserEvent.invalidate() = _Invalidate;
}
