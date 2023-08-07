part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

final class UserUpdatePhoneNumber extends UserEvent {
  UserUpdatePhoneNumber(this.phoneNumber);

  final String phoneNumber;
}

final class UserUpdateStatus extends UserEvent {}

final class UserUpdateName extends UserEvent {}

final class UserUpdatePIN extends UserEvent {}

final class UserUpdateAfterRegister extends UserEvent {}

final class UserClearOnLogout extends UserEvent {}
